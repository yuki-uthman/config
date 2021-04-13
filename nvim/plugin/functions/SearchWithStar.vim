" put visually selected text into to search register with *
" function! s:getSelectedText()
"   let l:old_reg = getreg('"')
"   let l:old_regtype = getregtype('"')
"   normal! gvy
"   let l:ret = getreg('"')
"   call setreg('"', l:old_reg, l:old_regtype)
"   exe "normal! \<Esc>"
"   return l:ret
" endfunction

" Put the visual selection into search register
" vnoremap <silent> * :call setreg("/",
"     \ substitute(<SID>getSelectedText(),
"     \ '\_s\+',
"     \ '\\_s\\+', 'g')
"     \ )<Cr>


