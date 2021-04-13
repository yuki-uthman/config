
nnoremap <buffer> <leader>r :!rust %<CR>
packadd rust.vim

let g:ale_linters = {'rust': ['rls']}
