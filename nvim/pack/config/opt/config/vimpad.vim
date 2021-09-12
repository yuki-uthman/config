
" save and run vim file 
" nnoremap <silent><buffer> <leader> :so %<CR>

nmap <leader>v <Plug>(vimpad-toggle)
vmap <leader>r <Plug>(vimpad-execute)

let g:vimpad_add_space = 1
let g:vimpad_add_padding = 1
" let g:vimpad_refresh_on_save = 0

" normal output
let g:vimpad_style = 'custom'
let g:vimpad_prefix = "\uE0B6"
let g:vimpad_suffix= "\uE0B4"
highlight VimpadOutput guifg=bg guibg=LightBlue gui=bold
highlight VimpadPrefix guifg=bg guibg=LightBlue gui=reverse
highlight VimpadSuffix guifg=bg guibg=LightBlue gui=reverse

" error output
let g:vimpad_style_error = 'lsp'
let g:vimpad_prefix_error = '🧨'
" let g:vimpad_prefix_error = '💣'

packadd nvim-vimpad
