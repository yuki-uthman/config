" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" nnoremap <leader>pry :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'pry'}<cr>

" send lines to tmux pane
nnoremap <C-R> :VtrSendLinesToRunner<CR>j
vnoremap <leader>r :VtrSendLinesToRunner<CR>

nnoremap vs :VtrAttachToPane<CR>
nnoremap vv :VtrSendCommandToRunner<CR>
nnoremap vf :VtrFlushCommand<CR>
nnoremap v<Space> :VtrFocusRunner<CR>


let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-/> :TmuxNavigatePrevious<cr>
