
let g:coc_global_extensions = [
        \ 'coc-snippets',
        \ 'coc-tsserver',
        \ 'coc-solargraph',
        \ 'coc-rls',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-json',
        \ 'coc-prettier',
        \ 'coc-pyright',
        \ 'coc-flutter'
        \ ]


" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Plug>CustomCocCR pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

" use <C-j/k> to navigate the snippets menu
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

if has('nvim-0.4.3') || has('patch-8.2.0750')
  inoremap <nowait><expr> <Down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 1)\<cr>" : "\<Right>"
  inoremap <nowait><expr> <Up> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, 1)\<cr>" : "\<Left>"
endif

nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)
