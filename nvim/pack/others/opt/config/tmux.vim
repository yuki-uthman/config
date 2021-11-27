packadd vim-tmux-runner

let g:tmux_navigator_no_mappings = 1
packadd vim-tmux-navigator

" nnoremap <leader>pry :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'pry'}<cr>


" send lines to tmux pane
nnoremap <C-R> :VtrSendLinesToRunner<CR>j
" vnoremap <leader>r :VtrSendLinesToRunner<CR>

nnoremap vs :VtrAttachToPane<CR>
nnoremap vv :VtrSendCommandToRunner<CR>
nnoremap vc :VtrFlushCommand<CR>
nnoremap v<Space> :VtrFocusRunner<CR>


nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
" nnoremap <silent> <C-/> :TmuxNavigatePrevious<cr>

