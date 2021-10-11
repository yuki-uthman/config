
set completeopt=menu,menuone
setlocal formatoptions-=o


nnoremap <buffer> <leader>r :luafile %<esc>

packadd nvim-luapad

" lua require'cmp'.setup.buffer {
" \   sources = {
" \     { name = 'nvim_lsp' },
" \     { name = 'nvim_lua' },
" \     { name = 'look' },
" \     { name = 'path' },
" \   },
" \ }

" \   completion = {
" \     autocomplete = false,
" \   },
