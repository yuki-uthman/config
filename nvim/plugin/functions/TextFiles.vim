
function! EditingTextFiles()
  execute "normal! :CocDisable\<CR>"
  packadd! deoplete.nvim
  packadd! deoplete-dictionary
  set complete+=k
  setlocal dictionary+=$HOME/.config/nvim/dict/words
  setlocal dictionary+=$HOME/.config/nvim/dict/words_cap
  call deoplete#enable()
endfunction


