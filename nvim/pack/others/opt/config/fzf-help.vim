
function! s:sink(line) abort

  let parts = split(a:line, ':')
  let match = {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}


  exec "new"  match.filename
  exec match.lnum

  set nonumber
  return 
endfunc

function! s:fzf_help(cword) abort

  let list = split(globpath(&rtp, 'doc/*.txt'))

  let cmd = "rg --line-number --column '' " .. join(list)

  let options = '
        \ --ansi
        \ --delimiter=:
        \ --with-nth=4..
        \ --bind=up:preview-up,down:preview-down
        \ --preview ''bat --theme=Dracula --style=full --color=always --highlight-line {2} {1}''
        \ --preview-window ''up:90%,~3,+{2}'''

  let word = expand('<cword>')

  if !empty(word) && a:cword
    let options ..= ' --query ' ..word
  end

  let bg = synIDattr(hlID("Normal"), "bg")
  let fg = synIDattr(hlID("Normal"), "fg")

  let colors = '
        \ --color=''
        \bg:#2f383e,
        \fg:#d3c6aa,
        \fg+:#d3c6aa,
        \spinner:#dbbc7f,
        \hl:#a7c080,
        \header:#859289,
        \info:#83c092,
        \pointer:#7fbbb3,
        \marker:#dbbc7f,
        \prompt:#e69875,
        \hl+:#83c092,
        \preview-bg:' ..bg ..',bg:'..bg .."'"

  let options .= colors

  let spec = #{
             \ source : cmd,
             \ options: options,
             \ sink   : function("s:sink"),
             \}


  call fzf#run(spec)
endfunc

nnoremap H :call <SID>fzf_help(0)<CR>
