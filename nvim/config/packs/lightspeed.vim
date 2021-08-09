
fun! s:RepeatFt(reverse)
  lua require'lightspeed'.ft['instant-repeat?'] = true
  lua require'lightspeed'.ft:to(vim.api.nvim_eval('a:reverse'),
                              \ require'lightspeed'.ft['prev-t-like?'])
endfun

nnoremap <silent> ; <cmd>call <SID>RepeatFt(v:false)<cr>
xnoremap <silent> ; <cmd>call <SID>RepeatFt(v:false)<cr>
nnoremap <silent> , <cmd>call <SID>RepeatFt(v:true)<cr>
xnoremap <silent> , <cmd>call <SID>RepeatFt(v:true)<cr>
