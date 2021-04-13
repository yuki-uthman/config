
" go up one directory
nmap <buffer> <silent> <nowait> h	<Plug>NetrwBrowseUpDir

" enter directory
nnoremap <buffer> <silent> <nowait> l :Ntree<CR>

" close the tree
" nmap <buffer> <silent> <nowait> c	gd


" nmap <buffer> <silent> <nowait> l <Plug>NetrwLocalBrowseCheck
" nnoremap <buffer> <silent> <Plug>NetrwBrowseUpDir		:<c-u>call <SID>NetrwBrowseUpDir(1)<cr>

" function! CreateInPreview()
"   let l:filename = input("please enter filename: ")
"   execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename
" endf

" function! CreateInPreview()
"   let l:filename = input("please enter filename: ")
"   let full_path = b:netrw_curdir . '/' . l:filename
"   wincmd p
"   execute 'e ' . full_path
"   normal \\
"   normal \\
"   wincmd p
"   write
" endf

" noremap <buffer> % :call CreateInPreview()<cr>
