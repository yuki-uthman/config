
function! s:align()    
  " Patterns needed to locate assignment operators...
  let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'    
  let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)\(.*\)$'    

  " Locate block of code to be considered (same indentation, no blanks)
  let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'    
  let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1    
  let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1    
  if lastline < 0        
    let lastline = line('$')    
  endif    

  " Decompose lines at assignment operators...
  let lines = []    
  for linetext in getline(firstline, lastline)        
    let fields = matchlist(linetext, ASSIGN_LINE)        
    call add(lines, fields[1:3])    
  endfor    

  " Determine maximal lengths of lvalue and operator...
  let op_lines = filter(copy(lines),'!empty(v:val)')    
  let max_lval = max( map(copy(op_lines), 'strlen(v:val[0])') ) + 1    
  let max_op   = max( map(copy(op_lines), 'strlen(v:val[1])'  ) )    

  " Recompose lines with operators at the maximum length...
  let linenum = firstline    
  for line in lines        
    if !empty(line)            
      let newline            
            \    = printf("%-*s%*s%s", max_lval, line[0], max_op, line[1], line[2])            
      call setline(linenum, newline)        
    endif        
    let linenum += 1    
  endfor
endfunction

nnoremap <silent> = :call <SID>align()<CR>

