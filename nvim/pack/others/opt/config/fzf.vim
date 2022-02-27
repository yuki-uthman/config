
let g:fzf_preview_window = ['up:80%:hidden', 'ctrl-/']
let g:fzf_command_prefix = 'FZF'

packadd fzf.vim

let s:paths = [
      \'~/.config',
      \'~/.local',
      \'~/Youtube',
      \'~/Programming',
      \]

command! FZFcd call fzf#run(fzf#wrap({
      \'source': 'find ' . join(s:paths),
      \'sink' : 'cd',
      \'down': '20%'}
      \))

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


nnoremap <leader>fb :FZFBuffers<CR>
nnoremap <leader>fl :FZFBLines<CR>
nnoremap <leader>ff :FZFFiles<CR>
nnoremap <leader>fj :FZFJumps<CR>

runtime OPT fzf-dictionary.vim
runtime OPT fzf-define.vim
runtime OPT fzf-help.vim
runtime OPT fzf-rg.vim

