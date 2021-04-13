
function! TodaysEntry()
    let path = '~/Vimwiki/todo/diary/'
    let today = strftime("%Y-%m-%d")
    let filepath = path . today . ".wiki"
    execute ":e ". filepath
    if getline(1) !~ '\d'
      let todayTitle = strftime("%A %e %B") 
      execute "normal! i~~ " . todayTitle . " ~~\<ESC>o\<ESC>o\<ESC>"
    endif
endfunction

" call TodaysEntry()
			" :for line in readfile(fname, '', 10)
			" :  if line =~ 'Date' | echo line | endif
			" :endfor
" echo IsLineEmpty(1)

" How to open file with the string?
" check if the first line of the file is empty
function! IsLineEmpty(lineNo) 
  let line = getline(a:lineNo)
  if match( line, '^\s*$' ) 
    return 1
  else 
    return 0
  endif
endfunction
