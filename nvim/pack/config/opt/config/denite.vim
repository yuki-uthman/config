" nnoremap df :Denite -start-filter -vertical-preview=true -floating-preview=true -split=floating -winrow=1 -auto_resize=1 file/rec<CR>
nnoremap dff :Denite -split=horizontal -vertical-preview file/rec<CR>
nnoremap dp :DeniteProjectDir -split=floating -winrow=1 file/rec grep:::!<CR>
nnoremap db :Denite buffer<CR>

nnoremap dg :Denite -start-filter grep:::!<CR>

nnoremap ]d :Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap [d :Denite -resume -cursor-pos=-1 -immediately<CR>

" call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#option('default', 'prompt', '>>')

" set wildignore+=tags

" Ripgrep command on grep source
call denite#custom#var('grep', {
  \ 'command': ['rg'],
  \ 'default_opts': ['-S', '--vimgrep', '--no-heading'],
  \ 'recursive_opts': [],
  \ 'pattern_opt': ['--regexp'],
  \ 'separator': ['--'],
  \ 'final_opts': [],
  \ })


call denite#custom#var('file/rec', 'command', ['rg'])

" call denite#custom#var('grep', 'command', ['ag'])
" call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'pattern_opt', [])
" call denite#custom#var('grep', 'separator', ['--'])
" call denite#custom#var('grep', 'final_opts', [])

call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
call denite#custom#source(
\ 'grep', 'matchers', ['matcher/fuzzy'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/*', '*.pyc', 'node_modules/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', '*.png'])

let s:denite_options = {'default' : {
\ 'direction': 'rightbelow',
\ 'winheight': '5',
\ 'preview_height': '15',
\ 'highlight_mode_insert': 'Visual',
\ 'highlight_mode_normal': 'Visual',
\ 'prompt_highlight': 'Function',
\ 'highlight_matched_char': 'Function',
\ 'highlight_matched_range': 'Normal'
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)

"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  " inoremap <silent><buffer><expr> <C-c>
  " \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-c>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
  imap <silent><buffer> <CR> <Plug>(denite_filter_quit)

  call denite#custom#map('_', '<C-j>', '<denite:move_to_next_line>')
  call denite#custom#map('_', '<C-k>', '<denite:move_to_previous_line>')
  " call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
  " call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
  if has('g:deoplete_is_loaded')
    call deoplete#custom#buffer_option('auto_complete', v:false)
  endif
endfunction



" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')

    nnoremap <silent><buffer> <C-q>
  \ :<C-u>call <SID>denite_quickfix()<CR>

  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> <Tab>
  \ denite#do_map('toggle_select')
endfunction

function! s:denite_quickfix()
  call denite#call_map('do_action', 'quickfix')
endfunction


