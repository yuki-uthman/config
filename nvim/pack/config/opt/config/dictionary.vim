
function! s:get_previous_word()
  let lig = getline(line('.'))
  let lig = strpart(lig,0,col('.')-1)
  return matchstr(lig, '\<\k*\>\s*$')
endfunction

function! OpenDictionary() abort

  let word = s:get_previous_word()

  " -I no file name 
  " -s case-sensitive
  let cmd = "rg -I --case-sensitive '" .. word .. "' " .. join(split(&dictionary, ','))

  let height = 8
  let width = 20

  let line = winline()
  let col = wincol()
  let yoffset =  ( line - 1.0 ) / (&lines - height)
  
  let len = len(word)
  let xoffset =  ( col - 3.0 - len ) / (&columns - width)

  let reverse = v:false
  if yoffset > 1
    let reverse = v:true
    let yoffset =  ( line - height - 0.0 ) / (&lines - height)
  endif

  " +i case sensitive flag for fzf
  " let options = ['+i']
  let options = []

  if reverse
    call extend(options, ['--layout=default'] )
  endif

  let window = #{
        \yoffset: yoffset, 
        \xoffset: xoffset, 
        \height: height, 
        \width: width, 
        \border: "none"}

  let dict = #{
        \source: cmd,
        \window: window,
        \options: options
        \}

   call fzf#vim#complete(cmd, dict)
endfunc

" inoremap <C-D> <cmd>call <SID>open()<CR>


