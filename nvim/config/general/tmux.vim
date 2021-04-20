let g:tmux_is_open = 1
function! TmuxToggle()
    if g:tmux_is_open
        silent !tmux set status off
        " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
        let g:tmux_is_open = 0
    else
        silent !tmux set status on
        " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
        let g:tmux_is_open = 1
    endif
endfunction

command! TmuxToggle call TmuxToggle()

nnoremap <F2> :TmuxToggle<CR>
