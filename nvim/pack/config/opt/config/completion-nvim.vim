
let g:completion_confirm_key = "\<C-y>"
let g:completion_enable_auto_signature = 1
let g:completion_enable_snippet = 'vim-vsnip'

let g:completion_chain_complete_list = [
    \{'complete_items': ['snippet', 'lsp']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

packadd completion-nvim

lua require'lspconfig'.vimls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.pylsp.setup{on_attach=require'completion'.on_attach}

