
let s:float = {}
let s:cmdreg_timer = 0
let s:registers = ['b', 'f', 's']

function! s:format(index, value) abort
  return ' ' .. a:value .. ' :' .. getreg(a:value)
endfunc

function! s:open() abort

  if !empty(s:float)
    return
  endif

  let cmd = getcmdline()

  call feedkeys("\<C-U>\<C-C>", 'n')

  let height = len(s:registers)
  let s:float = float#create()
        \.as_scratch()
        \.border('double')
        \.size(height, 0.5)
        \.align_bottom()
        \.right(0.5)
        \.open()

  let formatted = map(copy(s:registers), function('s:format'))

  call s:float.write(0, formatted)

  set winhighlight=Normal:Pmenu

  call feedkeys(':'.. cmd .."\<C-R>", 'n')

  let s:cmdreg_timer = timer_start(1, function('s:close'))
endfunc

function! s:close(id) abort

  call s:float.close()

  let s:float = {}
  let s:cmdreg_timer = 0
endfunc

cnoremap <C-R> <Cmd>call <SID>open()<CR>


