
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- require'lspconfig'.pylsp.setup{
--   capabilities = capabilities,
-- }


lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
