
local cmp = require('cmp')

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

cmp.setup {
    
    formatting = {
        format = function(entry, vim_item)

            -- set a name for each source
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                path = "[Path]",
                buffer = "[Buffer]",
                look = "[Dict]",
                spell = "[Spell]",
                calc = "[Calc]",
                emoji = "[Emoji]"
            })[entry.source.name]
            return vim_item
        end
    },

    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Down>'] = cmp.mapping.scroll_docs(2),
        ['<Up>'] = cmp.mapping.scroll_docs(-2),
        -- ['<C-L>'] = cmp.mapping.complete(),
        ['<C-E>'] = cmp.mapping.close(),
        ['<C-F>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
    },

    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },

    sources = {
        {name = 'buffer'}, 
        {name = "look"}, 
    },
    completion = {completeopt = 'menu,menuone,noinsert'}
}

-- Autopairs
-- require("nvim-autopairs.completion.cmp").setup({
--     map_cr = true,
--     map_complete = true,
--     auto_select = true
-- })
