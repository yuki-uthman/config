
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


inoremap <expr> <Plug>CustomCocCR pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

" use <Tab> to navigate the snippets menu
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Arrow key to scroll the float window
if has('nvim-0.4.3') || has('patch-8.2.0750')
  inoremap <nowait><expr> <Down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 1)\<cr>" : "\<Right>"
  inoremap <nowait><expr> <Up> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, 1)\<cr>" : "\<Left>"
endif

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
