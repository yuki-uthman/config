packadd wilder.nvim

call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
" cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
" cmap <expr> <C-N> wilder#in_context() ? wilder#next() : "\<C-N>"
cnoremap <expr> <C-J> wilder#in_context() ? wilder#next() : "\<C-N>"
" cmap <expr> <C-P> wilder#in_context() ? wilder#previous() : "\<C-P>"
cnoremap <expr> <C-K> wilder#in_context() ? wilder#previous() : "\<C-P>"
call wilder#set_option('modes', [':'])


let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \   'max_height' : '30%'
      \ }),
      \ '/': wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \ }),
      \ }))


" 'file_command' : for ripgrep : ['rg', '--files']
"                : for fd      : ['fd', '-tf']
" 'dir_command'  : for fd      : ['fd', '-td']
" 'filters'      : use ['cpsm_filter'] for performance, needs cpsm to be installed
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': ['rg', '--files'],
      \       'filters': ['fuzzy_filter', 'difflib_sorter'],
      \     }),
      \     wilder#cmdline_pipeline({
      \       'language': 'python',
      \       'sorter': wilder#python_difflib_sorter(),
      \       'fuzzy': 1,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern(),
      \       'engine': 're',
      \     }),
      \   ),
      \ ])

" call wilder#setup({
"       \ 'modes': [':', '/', '?'],
"       \ 'next_key': '<C-W>',
"       \ 'previous_key': '<S-Tab>',
"       \ 'accept_key': '<Down>',
"       \ 'reject_key': '<Up>',
"       \ })

cnoremap <C-T> <C-\>e(<SID>toggle())<CR>


function! s:toggle() abort
  let cmdlineBeforeCursor = strpart(getcmdline(), 0, getcmdpos() - 1)
  
  call wilder#toggle()

  if wilder#in_context()
    call wilder#next()

  endif

  call setcmdpos(strlen(cmdlineBeforeCursor) + 1)
  return cmdlineBeforeCursor

endfunc

augroup wilder_command_window
    autocmd!
    autocmd CmdwinEnter * nnoremap <expr> <C-T> <SID>toggle()
augroup END


