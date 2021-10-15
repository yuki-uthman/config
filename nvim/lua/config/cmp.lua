vim.cmd [[runtime OPT dictionary.vim]]
local cmp = require('cmp')

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(key, true, true, true),
    mode, true)
end

-- vim.cmd [[packadd lspkind-nvim]]
-- vim.cmd [[packadd cmp-tabnine]]

-- local source_mapping = {
-- 	cmp_tabnine = "[TN]",
-- }

-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({
--         max_lines = 1000;
--         max_num_results = 20;
--         sort = true;
-- 	run_on_every_keystroke = true;
-- 	snippet_placeholder = '🚀';
-- })

-- local lspkind = require 'lspkind'

cmp.setup {

    -- formatting = {
    --   format = function(entry, vim_item)
    --     vim_item.kind = lspkind.presets.default[vim_item.kind]
    --     local menu = source_mapping[entry.source.name]
    --     if entry.source.name == 'cmp_tabnine' then
    --       if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
    --         menu = entry.completion_item.data.detail
    --       end
    --       vim_item.kind = '⚡️'
    --     end
    --     vim_item.menu = menu
    --     return vim_item
    --   end
    -- },



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

        ["<CR>"] = cmp.mapping(function(fallback)
          if vim.fn.complete_info().selected == -1 then

            if vim.fn.pumvisible() == 1 then
              -- feedkey("<C-E>", "n")
              cmp.close()
            end

            feedkey("<C-G>u", "n")
            feedkey("<CR>", "n")
            feedkey("<Plug>DiscretionaryEnd", "")

          else
            cmp.confirm()

          end
        end, { "i", "s", }),

        ["<C-M>"] = cmp.mapping(function(fallback)
          if vim.fn.complete_info().selected == -1 then
            if vim.fn.pumvisible() == 1 then
              -- feedkey("<C-E>", "n")
              cmp.close()
            end

            feedkey("<C-G>u", "n")
            feedkey("<CR>", "n")
            feedkey("<Plug>DiscretionaryEnd", "")

          else
            cmp.confirm()

          end
        end, { "i", "s", }),

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

        ["<C-K>"] = cmp.mapping(function(fallback)
          if vim.fn.pumvisible() == 1 then
            -- cmp.select_prev_item()
            feedkey("<C-P>", "n")

          elseif has_words_before() then
            feedkey("<Plug>(fzf-dictionary-open)", "")

          end
        end, { "i", "s" }),

        ["<C-O>"] = cmp.mapping(function(fallback)
          if has_words_before() then
            cmp.setup.buffer {

              sources = {
                {name = 'look'}
              }
            }
            cmp.complete()
          end

        end, { "i", "s" }
        ),

        -- ["<C-Q>"] = cmp.mapping(function(fallback)
        --   if has_words_before() then
        --     fzf.open_dict()

        --   else
        --     fzf.open_dict()

        --   end

        -- end, { "i" }
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


        ["<C-P>"] = cmp.mapping(function(fallback)
          if vim.fn.pumvisible() == 1 then
            cmp.select_prev_item()

          elseif has_words_before() then
            feedkey("<C-X>", "n")
            feedkey("<C-F>", "n")
          else
            feedkey("<C-P>", "n")

          end
        end, { "i", "s" }
        ),


      },

    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },

}

-- Autopairs
-- require("nvim-autopairs.completion.cmp").setup({
--     map_cr = true,
--     map_complete = true,
--     auto_select = true
-- })
