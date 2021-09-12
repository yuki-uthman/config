

let g:fzf_command_prefix = 'FZF'

nnoremap <C-F> <Nop>

nnoremap <C-F><C-B> :FZFBuffers<CR>
nnoremap <C-F><C-L> :FZFBLines<CR>
nnoremap <C-F><C-F> :FZFFiles<CR>
nnoremap <C-F><C-G> :FZFRg<CR>
nnoremap <C-F><C-J> :FZFJumps<CR>


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
