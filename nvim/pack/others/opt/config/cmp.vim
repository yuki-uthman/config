" cmp 
packadd nvim-cmp.new

" cmp source
packadd cmp-nvim-lsp
packadd cmp-nvim-lua
packadd cmp-buffer
packadd cmp-vsnip
packadd cmp-look
packadd cmp-path
packadd cmp-spell
packadd cmp-tabnine

lua require('config/cmp')

" disable in command-line window
augroup disable_cmp
    autocmd!
    autocmd CmdwinEnter *  setlocal eventignore+=TextChangedI,InsertEnter
    autocmd CmdwinLeave *  setlocal eventignore-=TextChangedI,InsertEnter
augroup END

" refresh sources every time
" autocmd BufLeave * lua require'cmp'.setup { 
"       \ sources = {}
"       \}


" autocmd FileType vim lua require'cmp'.setup.buffer {
" \   completion = {
" \     autocomplete = false
" \   },
" \   sources = {
" \     { name = 'nvim_lsp' },
" \     { name = 'path' },
" \   },
" \ }

" autocmd FileType lua lua require'cmp'.setup.buffer {
" \   completion = {
" \     autocomplete = false
" \   },
" \   sources = {
" \     { name = 'nvim_lsp' },
" \   },
" \ }



