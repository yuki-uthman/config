cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

set cmdwinheight=3
augroup command_window
    autocmd!

    " <C-C> to leave cmdline-window from insert mode
    autocmd CmdwinEnter * inoremap <buffer> <silent> <C-C> <ESC>:close<cr>

    " <C-C> or ZZ to leave cmdline-window from normal mode
    autocmd CmdwinEnter * nnoremap <buffer> <silent>   ZZ  :close<cr>
    autocmd CmdwinEnter * nnoremap <buffer> <silent> <Esc> :close<cr>

    " start command line window in insert mode and no line numbers
    autocmd CmdwinEnter * set nonumber
    autocmd CmdwinEnter * set laststatus=0
    autocmd CmdwinEnter * startinsert
augroup END

