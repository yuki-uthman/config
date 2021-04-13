function! AutoReply(cmdline)
  let previous_cmd  = getcompletion(a:cmdline[0], 'command')
  if &ignorecase
    call filter(previous_cmd, "v:val !~# previous[0]")
  endif
  let previous_cmd  = get(previous_cmd, 0, '')
  let previous_args = a:cmdline[1:]

  if previous_cmd ==# 'global'
    call feedkeys(':', 'n')
  elseif previous_cmd ==# 'undolist'
    call feedkeys(':undo' . ' ', 'n')
  elseif previous_cmd ==# 'oldfiles'
    call feedkeys(':edit #<', 'n')
  elseif previous_cmd ==# 'marks'
    call feedkeys(':normal! `', 'n')

  elseif previous_cmd ==# 'changes'
    call feedkeys(':normal! g;', 'n')
    call feedkeys("\<S-Left>", 'n')
  elseif previous_cmd ==# 'jumps'
    call feedkeys(':normal!' . ' ', 'n')
    call feedkeys("\<C-O>\<S-Left>", 'n')

 elseif index(['ls', 'files', 'buffers'], previous_cmd) != -1
    call feedkeys(':buffer' . ' ', 'n')
  elseif index(['clist', 'llist'], previous_cmd) != -1
    call feedkeys(':silent' . ' ' . repeat(previous_cmd[0], 2) . ' ', 'n')
  elseif index(['dlist', 'ilist'], previous_cmd) != -1
    call feedkeys(':' . previous_cmd[0] . 'jump' . ' ' . join(previous_args), 'n')
    call feedkeys("\<Home>\<S-Right>\<Space>", 'n')
  endif
endfunction

" augroup AutoReply
"   autocmd!
"   autocmd CmdlineLeave :
"     \ let s:cmdline = getcmdline()
"     \ | if !empty(s:cmdline)
"     \ |   call AutoReply(split(s:cmdline))
"     \ | endif
" augroup END 
