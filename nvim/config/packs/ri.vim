" Disable ri keymap
let g:ri_no_mappings=1

" cnoreabbrev ri call ri#OpenSearchPrompt(0)<CR>
" cnoreabbrev <expr> ri  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'

nnoremap  RI :call ri#OpenSearchPrompt(0)<cr> " horizontal split
" nnoremap  RI :call ri#OpenSearchPrompt(1)<cr> " vertical split
nnoremap  RK :call ri#LookupNameUnderCursor()<cr> " keyword lookup
