
let s:float = {}
let s:cmdreg_timer = 0
let s:registers = [0, 1, 2, 'a', 'b', 'c']

function! s:format(index, value) abort
  return ' ' .. a:value .. ' :' .. getreg(a:value)
endfunc

function! s:open() abort

  if !empty(s:float)
    return
  endif

  let cmd = getcmdline()

  call feedkeys("\<Esc>", 'n')

  let height = len(s:registers)
  let s:float = float#create()
        \.size(height, 0.7)
        \.align_bottom()
        \.right(0.5)
        \.open()

  let formatted = map(copy(s:registers), function('s:format'))

  call s:float.write(0, formatted)

  call feedkeys(':'.. cmd .."\<C-R>", 'n')

  let s:cmdreg_timer = timer_start(1, function('s:close'))
endfunc

function! s:close(id) abort

  call s:float.close()

  let s:float = {}
  let s:cmdreg_timer = 0
endfunc

cnoremap <C-R> <Cmd>call <SID>open()<CR>

