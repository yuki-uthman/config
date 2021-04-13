let s:error = 0

function! RuboCop(args)
  if &filetype == "ruby"
    call s:RunRuboCop(@%, 1, a:args)

  else
    echo "Cannot run rubocop on non-ruby file"
  endif
endfunction

function! RuboCopFix()
  if &filetype == "ruby"
    call s:RunRuboCop(@%, 0, "--auto-correct --safe")
  else
    echo "Cannot run rubocop on non-ruby file"
  endif
endfunction

function! RuboCopAll(args)
  call s:RunRuboCop("", 1, a:args)
endfunction

function! s:RunRuboCop(path, async, args)
  let l:rubocop_args = a:args . join(a:000, " ")

  if !empty(a:path)
    let l:rubocop_args = l:rubocop_args . " " . a:path
  endif

  let l:rubocop_command = s:RuboCopCmd(). " " . l:rubocop_args

  if s:error
    return
  endif

  if a:async
    call s:executeCmdAsync(l:rubocop_command)
  else
    call s:executeCmd(l:rubocop_command)
  endif
endfunction

function! s:RuboCopCmd()
  if exists('g:rubocop_cmd')
    if g:rubocop_cmd =~ "emacs"
      let l:rubocop_command = g:rubocop_cmd
    else
      let l:rubocop_command = g:rubocop_cmd . " --format emacs"
    endif
  else
    if !executable('rubocop')
      let s:error = 1
      echom s:error
      echoerr "Rubocop: rubocop binary not found. Pleast install it first"
      return
    endif

    let l:rubocop_command = 'rubocop --format emacs'
    let l:root = getcwd()
    let l:gemfile_path = root . "/Gemfile"
    if filereadable(l:gemfile_path)
      let l:body = join(readfile(l:gemfile_path), "\n")
      let l:bundle_path = matchstr(l:body, "rubocop")
      if empty(l:bundle_path)
        lt l:rubocop_command = 'rubocop --format emacs'
      else
        let l:rubocop_command = 'bundle exec rubocop --format emacs'
      endif
    endif
  endif

  return l:rubocop_command
endfunction

function! BackgroundCmdFinish(channel)
  execute "cfile! " . g:backgroundCommandOutput

  let l:match_count = len(getqflist())

  if l:match_count
    copen
  else
    cclose
    echom "No errors! bravo!"
  endif

  unlet g:backgroundCommandOutput
endfunction

function! s:executeCmdAsync(cmd)
  echom "Running Rubocop"

  let g:backgroundCommandOutput = tempname()
  call jobstart(a:cmd, {'close_cb': 'BackgroundCmdFinish', 'out_io': 'file', 'out_name': g:backgroundCommandOutput})
endfunction

function! s:executeCmd(cmd)
  echom a:cmd
  let oldautoread=&autoread
  set autoread
  silent !clear
  execute "!" . a:cmd
  redraw
  let &autoread=oldautoread
endfunction

command! -nargs=* RuboCop call RuboCop(<q-args>)
command! -nargs=* Rubocop call RuboCop(<q-args>)
command! -nargs=* RuboCopAll call RuboCopAll(<q-args>)
command! -nargs=0 RuboCopFix call RuboCopFix()
