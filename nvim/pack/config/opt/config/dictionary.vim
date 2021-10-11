
function! s:get_previous_word()
  let lig = getline(line('.'))
  let lig = strpart(lig,0,col('.')-1)
  return matchstr(lig, '\<\k*\>\s*$')
endfunction

function! OpenDictionary() abort

  let cmd = "rg -I '' " .. join(split(&dictionary, ','))

  let height = 8
  let width = 20

  let line = winline()
  let col = wincol()
  let yoffset =  ( line - 1.0 ) / (&lines - height)
  
  let len = len(s:get_previous_word())
  let xoffset =  ( col - 3.0 - len ) / (&columns - width)

  let reverse = v:false
  if yoffset > 1
    let reverse = v:true
    let yoffset =  ( line - height - 0.0 ) / (&lines - height)
  endif

  let window = #{
        \yoffset: yoffset, 
        \xoffset: xoffset, 
        \height: height, 
        \width: width, 
        \border: "none"}

  let dict = #{
        \source: cmd,
        \window: window
        \}

  if reverse
    call extend(dict, #{options: '--layout=default'} )
  endif

   call fzf#vim#complete(cmd, dict)
endfunc

" inoremap <C-D> <cmd>call <SID>open()<CR>


