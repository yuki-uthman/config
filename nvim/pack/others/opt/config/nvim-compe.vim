
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.emoji = v:true

inoremap <silent> <expr> <C-Space> compe#complete()
" inoremap <silent> <expr> <CR>      compe#confirm({ 'keys': "\<Plug>DiscretionaryEnd", 'mode': '' })
inoremap <silent> <expr> <CR>      compe#confirm('<CR>')
inoremap <silent> <expr> <C-e>     compe#close('<C-e>')
inoremap <silent> <expr> <Down>      compe#scroll({ 'delta': +1 })
inoremap <silent> <expr> <Up>    compe#scroll({ 'delta': -1 })

packadd nvim-compe

