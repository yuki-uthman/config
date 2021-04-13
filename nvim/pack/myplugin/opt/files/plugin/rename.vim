" Usage:
"
" :Rename[!] {newname}

command! -nargs=* -complete=file -bang Rename :call Rename("<args>", "<bang>")

function! Rename(name, bang)
    let ext = expand("%:e")
    let curfile = expand("%:p")
    let curfilepath = expand("%:p:h")
    let newname = curfilepath . "/" . a:name . '.' . ext
    let v:errmsg = ""
    silent! exe "saveas" . a:bang . " " . newname
    if v:errmsg =~# '^$\|^E329'
        if expand("%:p") !=# curfile && filewritable(expand("%:p"))
            silent exe "bwipe! " . curfile
            if delete(curfile)
                echoerr "Could not delete " . curfile
            endif
        endif
    else
        echoerr v:errmsg
    endif
endfunction
cnoreabbrev <expr> rename  (getcmdtype() ==# ':' && getcmdline() ==# 'rename')  ?
      \ "Rename \<C-R>=expand(\"%:t:r\")\<CR>\<C-R>=Eatchar(' ')\<CR>"  : 'rename'
