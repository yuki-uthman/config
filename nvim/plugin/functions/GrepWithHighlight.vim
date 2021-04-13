function! Vimgrep()
    let searchString = input("Input search string: ")
    let g:myvimgrepSearch = searchString
    if searchString == '' || searchString == '\n'
        echom "Aborted Search."
        return
    endif
    exe 'vimgrep /'.searchString.'/ **/*'
    " Open the quickfix window first so match applies to it
    copen
    call clearmatches()
    silent call matchadd('Search', searchString) " Hi group / pattern
    let @/=searchString
endfunction


" maybe get the line number and column and length of the string
" h matchaddpos()

" command! -nargs=+ -complete=file_in_path -bar Vimgrep  cgetexpr Vimgrep(<f-args>)

" nnoremap <leader>v :call GrepWithHighlight()<Cr>
" cabbre vimgrep Vimgrep
