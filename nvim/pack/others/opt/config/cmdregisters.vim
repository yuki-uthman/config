
let s:float = {}
let s:cmdreg_timer = 0
let s:registers = ['n', 'b', 'f']

function! s:format(index, value) abort
  return ' @' .. a:value .. ' = |' .. getreg(a:value) .. '| '
endfunc

function! s:width(list) abort
  let max = 0
  for item in a:list
    if strlen(item) > max
      let max = strlen(item)
    end
  endfor
  return max
endfunc

function! s:open() abort

  if !empty(s:float)
    return
  endif

  let cmd = getcmdline()

  call feedkeys("\<C-U>\<C-C>", 'n')

  let height = len(s:registers)

  let formatted = map(copy(s:registers), function('s:format'))
  let width = s:width(formatted)

  let s:float = float#create()
        \.as_scratch()
        \.border('double')
        \.size(height, width)
        \.align_bottom()
        \.align_right()
        \.left(3)
        \.open()


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


