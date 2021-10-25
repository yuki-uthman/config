

let g:fzf_command_prefix = 'FZF'

packadd fzf.vim

nnoremap <C-F> <Nop>

nnoremap <C-F><C-B> :FZFBuffers<CR>
nnoremap <C-F><C-L> :FZFBLines<CR>
nnoremap <C-F><C-F> :FZFFiles<CR>
nnoremap <C-F><C-G> :FZFRg<CR>
nnoremap <C-F><C-J> :FZFJumps<CR>

" inoremap <C-F><C-P> <Cmd>call fzf#vim#complete#path("find . -path '*/\.*' -prune -o -type f -print -o -type l -print \| sed 's:^..::'")<CR>

let s:paths = [ 
      \'~/.config', 
      \'~/.local',
      \'~/Youtube',
      \'~/Programming',
      \]

" let s:paths = [ '/usr' ]

command! FZFcd call fzf#run(fzf#wrap({
      \'source': 'find ' . join(s:paths),
      \'sink' : 'cd',
      \'down': '20%'}))



nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)


function! GetJumps()
  redir => cout
  silent jumps
  redir END
  return reverse(split(cout, "\n")[1:])
endfunction

function! GoToJump(jump)
    let jumpnumber = split(a:jump, '\s\+')[0]
    execute "normal " . jumpnumber . "\<c-o>"
endfunction

command! FZFJumps call fzf#run(fzf#wrap({
        \ 'source': GetJumps(),
        \ 'sink': function('GoToJump')}))

" /Users/Yuki/.config/nvim/pack/minpac/start/fzf.vim/doc/fzf-vim.txt:108


function! s:fzf_help() abort
  let list = split(globpath(&rtp, 'doc/*.txt'))

  let cmd = "rg -I '' " .. join(list)

  let dict = #{
        \source: cmd,
        \sink: 'edit'}

  call fzf#run(dict)
  
endfunc






