local cmp = require('cmp')

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(key, true, true, true),
    mode, true)
end

cmp.setup {

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = nil
            vim_item.menu = nil

            return vim_item
        end
    },

    completion = {
      autocomplete = false,
      completeopt = 'menu,menuone,noinsert'
    },

    mapping = {
        ['<Down>'] = cmp.mapping.scroll_docs(2),
        ['<Up>'] = cmp.mapping.scroll_docs(-2),
    
        ["<C-M>"] = cmp.mapping(function(fallback)
          local selected = cmp.core.view:get_selected_entry()
          if selected then
            cmp.confirm({ select = true })

          else
            feedkey("<C-g>u<CR>", "n")
            feedkey("<Plug>DiscretionaryEnd", "")

          end

        end, { "i", "s", }),
        
        ["<C-F>"] = cmp.mapping(function(fallback)
          local selected = cmp.core.view:get_selected_entry()
          if selected then
            cmp.confirm({ select = true })

          else
            feedkey("<C-F>", "n")

          end

        end, { "i" }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if vim.fn["vsnip#available"]() == 1 then
            feedkey("<Plug>(vsnip-expand)", "")

          else
            if has_words_before() then
              cmp.setup.buffer {

                sources = {
                  {name = 'nvim_lsp'}
                }
              }

              cmp.complete()
            else
              feedkey("<Tab>", "n")
            end

          end
        end, { "i", "s" }),

        ["<C-J>"] = cmp.mapping.select_next_item(),
        ["<C-K>"] = cmp.mapping(function(fallback)
          -- put(cmp.core.view:_get_entries_view())
          -- put(cmp.get_selected_entry())
          if cmp.get_selected_entry() then
            cmp.select_prev_item()
            -- feedkey("<C-P>", "n")

          elseif has_words_before() then
            feedkey("<Plug>(fzf-dictionary-open)", "")

          end
        end, { "i", "s" }),

        -- ["<C-O>"] = cmp.mapping(function(fallback)
        --   if has_words_before() then
        --     cmp.setup.buffer {

        --       sources = {
        --         {name = 'look'}
        --       }
        --     }
        --     cmp.complete()
        --   end

        -- end, { "i", "s" }
        -- ),

        ["<C-N>"] = cmp.mapping(function(fallback)
            feedkey("<C-X>", "n")
            feedkey("<C-N>", "n")
        end, { "i", "s" }
        ),

        ["<C-L>"] = cmp.mapping(function(fallback)
          feedkey("<C-X>", "n")
          feedkey("<C-L>", "n")
        end, { "i", "s" }
        ),

      },

    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },

    experimental = {
      native_menu = false,
      ghost_text = true,
    },


}

