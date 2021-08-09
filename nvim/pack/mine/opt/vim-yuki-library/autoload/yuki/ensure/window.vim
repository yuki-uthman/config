
function! yuki#ensure#window#at(winid, expected)
  call maktaba#value#IsNumber(a:winid)
  call maktaba#value#IsList(a:expected)

  let actual = win_screenpos(a:winid)

  if maktaba#value#IsEqual(actual, a:expected)
    return 1
  else
    " check if the window's buffer has a name
    let bufname = bufname(winbufnr(a:winid))

    if yuki#value#IsEmpty(bufname)
      let bufname = a:winid
    endif

    echom maktaba#error#Message('WrongWindowPosition', 
          \"window(%s)", 
          \ bufname)

    echom "Expected: " . string(a:expected)
    echom "Received: " . string(actual)

  endif
endfunction

function! yuki#ensure#window#exists_at(row, col)
  call maktaba#ensure#IsNumber(a:row)
  call maktaba#ensure#IsNumber(a:col)

  let windows = getwininfo()

  for window in windows
    if maktaba#value#IsEqual(window.winrow, a:row) && maktaba#value#IsEqual(window.wincol, a:col)
      return v:true
    endif
  endfor

  echom maktaba#error#Message('NoWindowFound', 'No window at [%s, %s]', a:row, a:col)
  for window in windows
    echom 'Found window at [' . window.winrow . ', ' . window.wincol . ']'
  endfor

  return v:false
endfunction



function! yuki#ensure#window#size(winid, expected)
  call maktaba#ensure#IsNumber(a:winid)
  call maktaba#ensure#IsList(a:expected)

  let actual = [winheight(a:winid), winwidth(a:winid)]

  if maktaba#value#IsEqual(actual, a:expected)
    return 1

  else

    " check if the window's buffer has a name
    let bufname = bufname(winbufnr(a:winid))

    if yuki#value#IsEmpty(bufname)
      let bufname = a:winid
    endif

    echom maktaba#error#Message('WrongWindowSize', 
          \"window(%s)", 
          \ bufname)

    echom "Expected: " . string(a:expected)
    echom "Received: " . string(actual)
  endif
endfunction
