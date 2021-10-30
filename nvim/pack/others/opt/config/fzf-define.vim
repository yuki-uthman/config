
function! s:sink(line) abort
endfunc

let s:dictionary = ['~/.config/nvim/dict/words']

let s:lookup_cmd = 'wkdict'


function! s:define(word) abort
  let cmd = "rg -I --case-sensitive '' " .. join(s:dictionary, ' ')
  
  let dict = #{
        \source: cmd,
        \sink: function('s:sink')}

  " you can change wkdict to sdcv
  " sdcv no internet required
  let options = '
        \ --query=' .. a:word .. '
        \ --ansi
        \ --bind=up:preview-up,down:preview-down
        \ --bind=space:accept
        \ --bind=change:first
        \ --preview '''.. s:lookup_cmd .. ' {}''
        \ --preview-window ''right:70%'''

  let spec = {
             \ 'source' : cmd,
             \ 'options': options,
             \ 'sink'   : { -> ''},
             \}

  call fzf#run(spec)

endfunc


command! -nargs=? Define call s:define('<args>')
cnoreabbrev <expr> def  (getcmdtype() ==# ':' && getcmdline() ==# 'def')  ? 'Define'  : 'def'
