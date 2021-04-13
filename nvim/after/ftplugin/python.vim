nnoremap <buffer> <leader>r :!python %<cr>

inoremap <buffer> ; :
inoremap <buffer> : ;

let b:ale_linters = ['flake8']
let b:ale_fixers = ['black']

