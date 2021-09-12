packadd lightspeed.nvim

lua<<EOF
require'lightspeed'.setup { 
    jump_to_first_match = true,
    full_inclusive_prefix_key = '<tab>',
}
EOF

unmap t
unmap T
unmap f
unmap F

" fun! s:RepeatFt(reverse)
"   lua require'lightspeed'.ft['instant-repeat?'] = true
"   lua require'lightspeed'.ft:to(vim.api.nvim_eval('a:reverse'),
"                               \ require'lightspeed'.ft['prev-t-like?'])
" endfun

" nnoremap <silent> ; <cmd>call <SID>RepeatFt(v:false)<cr>
" xnoremap <silent> ; <cmd>call <SID>RepeatFt(v:false)<cr>
" nnoremap <silent> , <cmd>call <SID>RepeatFt(v:true)<cr>
" xnoremap <silent> , <cmd>call <SID>RepeatFt(v:true)<cr>
