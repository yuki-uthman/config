" Setup

" remove the header at the top
let g:netrw_banner = 0

" Set the default listing style:
" = 0: thin listing (one file per line)
" = 1: long listing (one file per line with time
"      stamp information and file size)
" = 2: wide listing (multiple files in columns)
" = 3: tree style listing
let g:netrw_liststyle= 3














" Open and Close Netrw

" default window size
let g:netrw_winsize = 30

" toggle the file explorer on the right
nnoremap \\    :Lex<CR>

















" Opening a file

" 1 new horizontal split
" 2 new vertical split
" 3 new tab
" 4 previous window
let g:netrw_browse_split = 4






















" go up one directory
" nmap <buffer> <silent> <nowait> h	<Plug>NetrwBrowseUpDir

" enter directory
" nnoremap <buffer> <silent> <nowait> l :Ntree<CR>
