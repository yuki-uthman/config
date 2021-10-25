" Usage:
"
" :Rename[!] {newname}

command! -nargs=* -bang Rename :call Rename("<args>", "<bang>")


function! s:Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc

function! Rename(name, bang)
    let curfile = expand("%:p")
    let curfilepath = expand("%:p:h")
    let newname = curfilepath . "/" . a:name 
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

autocmd CmdwinEnter * inoreabbrev <silent> <buffer> <expr> r "Rename \<C-R>=expand(\"#:t\")\<CR>\<C-R>=<SID>Eatchar(' ')\<CR>"

cnoreabbrev <expr> r  
      \ (getcmdtype() ==# ':' && getcmdline() ==# 'r')  ?
      \ "Rename \<C-R>=expand(\"%:t\")\<CR>\<C-R>=<SID>Eatchar(' ')\<CR>"  : 'r'

