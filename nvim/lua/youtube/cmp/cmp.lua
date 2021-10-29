vim.cmd [[packadd nvim-cmp]]

vim.cmd [[packadd cmp-nvim-lsp]]
vim.cmd [[packadd cmp-buffer]]
vim.cmd [[packadd cmp-look]]

local cmp = require 'cmp'
local types = require 'cmp.types'

vim.cmd [[packadd lspkind-nvim]]
local lspkind = require 'lspkind'
lspkind.init({
    with_text = true,
    preset = 'codicons',
})

cmp.setup({

  formatting = {
    format = function(entry, vim_item)
      vim_item.item = nil
      vim_item.menu = nil
      return vim_item
    end
  },

  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-o>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },

  sources = {}

})

-- Setup lspconfig.
vim.cmd [[packadd nvim-lspconfig]]

local lsp = require 'lspconfig'
local cmp_lsp = require 'cmp_nvim_lsp'

lsp.vimls.setup {
  capabilities = 
    cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('data')..'/site/lsp/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/".."macOS".."/lua-language-server"

vim.cmd [[packadd lua-dev.nvim]]
local luadev = require("lua-dev").setup({
  -- add any options here, or leave empty to use the default settings
  lspconfig = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = false,
    -- Disable a feature
    update_in_insert = false,
  }
)

lsp.sumneko_lua.setup {
    capabilities = capabilities,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
}

lsp.solargraph.setup{
  capabilities = capabilities,
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
}
