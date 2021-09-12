
let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')

" Expand
imap <expr> <C-I>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-I>'
" smap <expr> <C-L>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-L>'

" Expand or jump
imap <expr> <C-J>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-J>'
smap <expr> <C-J>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-J>'

" Jump forward or backward
" imap <expr> <C-J> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-J>'
" smap <expr> <C-J> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-J>'
imap <expr> <C-K> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-K>'
smap <expr> <C-K> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-K>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
" nmap        s   <Plug>(vsnip-select-text)
" xmap        <C-J>   <Plug>(vsnip-select-text)
" nmap        S   <Plug>(vsnip-cut-text)
" xmap        <C-K>   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
" let g:vsnip_filetypes = {}
" let g:vsnip_filetypes.javascriptreact = ['javascript']
" let g:vsnip_filetypes.typescriptreact = ['typescript']
