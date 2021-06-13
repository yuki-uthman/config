
set formatoptions-=o

nnoremap <buffer> <silent> <leader>c :Codi!! javascript<CR>
nnoremap <buffer> <leader>r :!node --harmony %<esc>

inoremap $      ${}<Left>

" Swap single quote with backtick 
inoremap ''     ``<Left>
inoremap ' `
onoremap i' i`
onoremap a' a`

