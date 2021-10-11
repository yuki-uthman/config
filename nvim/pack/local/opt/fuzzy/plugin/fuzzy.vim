" # Fuzzy Finder my version

let g:max_result = 10000
let g:preview_window_options = { 
      \ 'x': 1,
      \ 'y': 0.3,
      \ 'height': 0.8,
      \ 'width': 0.5,
      \}

" [what happens spliting when there is only one word in the string](2107140830)
" [remove from a list](2107140834)
fun! s:update_search(option, filter) "{{{ dict = { command, dir, filter}
  let lists = split(a:filter)
  let search = a:option.command . " " . lists[0] . " " . a:option.dir

  call remove(lists, 0)

  for word in lists
    let search .= '| rg ''(?i):.*' . word . '.*'''
  endfor
  let @a = search
  return search . ' | head -n ' . g:max_result " [link](2107171606)
endfun "}}}

fun! s:clear_highlight() "{{{
  call clearmatches()
endfun "}}}

fun! s:highlight_input(string) " [syntax highlight](2107150117) {{{
  let lists = split(a:string)
  for word in lists
    let m = matchadd("fuzzyMatch", '\c' . word)
  endfor

endfun
"}}}

function! s:on_event(id, data, event) "{{{
  let last_match = len(a:data)
  0,$d
  call setline(1,a:data[0:g:max_result])
endfunction "}}}

" [buffer info](2107160706)
" [scratch buffer](2107160737)
" [bad habit](2107150247 
function! s:edit_with_float_window(filename) abort "{{{
    let ui = nvim_list_uis()[0]
    let height = float2nr(ui.height * 0.8) 
    let width = float2nr(ui.width * 0.5)

    let top = float2nr((&lines - height) / 2)
    let right =  &columns

    "Set the position, size, etc. of the floating window.
    let opts = {
          \ 'relative': 'editor',
          \ 'row': top - 1 ,
          \ 'col': right - 3,
          \ 'width': width ,
          \ 'height': height,
          \ 'anchor': 'NE',
          \ 'style': 'minimal',
          \ 'focusable': v:false,
          \ 'border': "single",
          \ }

    let text_bufnr = nvim_create_buf(v:false, v:true)
    let window_id = nvim_open_win(text_bufnr, v:true, opts)
    " call nvim_win_set_option(window_id, 'laststatus', 2)
    set winhl=Normal:Pmenu

    execute 'edit ' . a:filename

    return {'bufnr': text_bufnr, 'winid': window_id}
endfunction "}}}

fun! FilterClose(bufnr) "{{{

  call win_gotoid(g:main_bufnr)
  execute "bwipe" a:bufnr

  if g:preview_loaded
    execute 'bwipe ' . g:preview_window.bufnr
    unlet g:preview_loaded
  endif

  redraw
  echo "\r"
  return []
endf
"}}}

function! s:create_filter_window() "{{{
  botright 10new 
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal nobuflisted
  setlocal nonumber
  setlocal norelativenumber
  setlocal noswapfile
  setlocal nowrap
  setlocal foldmethod=manual
  setlocal nofoldenable
  setlocal modifiable
  setlocal noreadonly
  setlocal laststatus=0
  setlocal conceallevel=3
  setlocal concealcursor=nc
  setlocal cursorline

  " https://codeyarns.com/tech/2011-07-29-vim-chart-of-color-names.html 
  hi fuzzyMatch guifg=magenta1
  syn match filepath '^.\{-}:\d\{-}:' conceal cchar=>

  return bufnr('%')
endfunction "}}}

fun! Finder(command, dir, prompt) abort "{{{
  let g:main_bufnr = bufnr('%')
  let g:main_winid = bufwinid(bufnr('%'))

  let g:preview_loaded = 0

  let filter = ""
  let filter_bufnr = s:create_filter_window()

  let search_options = {'command': a:command, 'dir': a:dir}

  echo a:prompt
  while 1
    let l:error = 0 " Set to 1 when pattern is invalid

    " check if the char is CTRL-C
    try
      let ch = getchar()
    catch /^Vim:Interrupt$/  " CTRL-C
      return FilterClose(filter_bufnr)
    endtry

    if ch ==# "\<bs>" || ch ==# 0x08" Backspace
      if g:preview_loaded
        exec 'bwipe ' . g:preview_window.bufnr
        let g:preview_loaded = 0
      endif

      if len(filter) == 0

      elseif len(filter) == 1
        let filter = ""
        call s:clear_highlight()
      else
        let last_char = filter[-1:] " [char by position](2107171450)
        let filter = filter[:-2]
        if last_char ==# " "
          let new_search = s:update_search(search_options, filter)
          call jobstart(new_search, {'on_stdout': function('s:on_event'), 'stdout_buffered' : v:true}) " [async](2107142027)
        endif
        call s:clear_highlight()
        call s:highlight_input(filter)
      endif

    elseif ch >=# 0x20 " Printable character
      let filter .= nr2char(ch)
      if ch ==# 0x20
        let new_search = s:update_search(search_options, filter)
        let result = systemlist(new_search)
        0,$d
        call setline(1,result[0:g:max_result])
        call s:clear_highlight()
        call s:highlight_input(filter)
      endif

    elseif ch ==# 0x1B " Escape
      return FilterClose(filter_bufnr)

    elseif ch ==# 0x17 " CTRL-W for preview

      " if preview is open
      if g:preview_loaded
        exec 'bwipe ' . g:preview_window.bufnr
        let g:preview_loaded = 0
      else
        " get filename
        let chosen_line = getline('.')
        let filename = matchstr(chosen_line, '.\{-}\ze:\d\+:')
        let line = matchstr(chosen_line, '.\{-}:\zs\d\+\ze:')

        " open in the floating window
        let g:preview_window = s:edit_with_float_window(filename)
        let g:preview_loaded = 1

        if line 
          exec line
          exec "normal! zt"
        endif

        " unfold for preview window
        exec "normal! zR"

        " go back to the filter window
        let filter_winind = bufwinid(filter_bufnr)
        call win_gotoid(filter_winind)
      endif

    elseif ch ==# 0x06 " CTRL-F
      let @a = "CTRL-F"
      if &conceallevel == 3
        setlocal conceallevel=0
      else
        setlocal conceallevel=3
      endif

    elseif ch ==# "\<Down>" || ch ==# "\<Up>" " Scrolling
      " check if the preview is open
      if g:preview_loaded
        call win_gotoid(g:preview_window.winid)
        exec "normal! " . (ch ==# "\<Down>" ? "\<C-E>" : "\<C-Y>")
      endif

    elseif ch ==# 0x0D " Enter
      " get filename
      let chosen_line = getline('.')
      let filename = matchstr(chosen_line, '.\{-}\ze:\d\+:')
      let line = matchstr(chosen_line, '.\{-}:\zs\d\+\ze:')

      call s:clear_highlight()

      call win_gotoid(g:main_winid)
      exec "edit " . filename
      exec line
      exec "normal! zz"

      call FilterClose(filter_bufnr)
      return 

    elseif ch ==# 0x15 " CTRL-U (clear)
      let filter = ""
      redraw

    elseif ch ==# 0x0E " CTRL-N https://www.csee.umbc.edu/portal/help/theory/ascii.txt
      " change/close? the preview window if already open
      if g:preview_loaded

      endif
      norm! j 

    elseif ch ==# 0x10 " CTRL-P
      norm! k
    endif

    redra 
    echo (l:error ? "[Invalid pattern] " : "").a:prompt filter
  endwhile
endf "}}}

" [head](2107150102)

command! PackSearcher 
      \ call Finder("rg --line-number --no-heading --smart-case -H -g='*.vim'", 
      \ "/Users/Yuki/.config/nvim/pack/minpac/", 
      \ 'Search >')

" call s:edit_with_float_window(location.filename)
" exec location.line

" exec "edit " items[0]

" [original code from fandom](2107071433)

" [TODO](2107211004)
