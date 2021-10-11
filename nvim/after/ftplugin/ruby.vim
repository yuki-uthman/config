
nnoremap <buffer> <silent> <leader>c :Codi!! ruby<CR>
" let b:undo_ftplugin = "unmap <buffer> <LocalLeader>c"

nnoremap <buffer> <leader>r :!ruby %<esc>
" let b:undo_ftplugin = b:undo_ftplugin . "unmap <buffer> <LocalLeader>r"

" inoremap <buffer> ; :
" inoremap <buffer> : ;


packadd vim-ruby
packadd vim-rails
packadd vim-textobj-rubyblock

" let b:ale_linters = ['rubocop']
" let b:ale_fixers = ['rubocop']
" let b:ale_ruby_rubocop_options = '--auto-corrent'
