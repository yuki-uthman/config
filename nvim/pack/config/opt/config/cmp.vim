" cmp 
packadd nvim-cmp
lua require('lsp/cmp')

" disable in command-line window
augroup disable_cmp
    autocmd!

    autocmd CmdwinEnter *  setlocal eventignore+=TextChangedI,InsertEnter
    autocmd CmdwinLeave *  setlocal eventignore-=TextChangedI,InsertEnter
augroup END

autocmd BufLeave * lua require'cmp'.setup { 
      \ sources = {}
      \}

" autocmd FileType text lua require'cmp'.setup.buffer {
" \   sources = {
" \     { name = 'buffer' },
" \     { name = 'look' },
" \   },
" \ }

autocmd FileType vim lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'vsnip' },
\     { name = 'nvim_lsp' },
\     { name = 'nvim-lua' },
\     { name = 'buffer' },
\     { name = 'path' },
\   },
\ }

autocmd FileType lua lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'vsnip' },
\     { name = 'nvim_lsp' },
\     { name = 'nvim-lua' },
\     { name = 'buffer' },
\     { name = 'path' },
\   },
\ }


" cmp source
packadd cmp-nvim-lsp
packadd cmp-nvim-lua
packadd cmp-buffer
packadd cmp-vsnip
packadd cmp-look
packadd cmp-path
packadd cmp-spell
