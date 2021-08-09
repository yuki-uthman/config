
let g:zet_dir = "~/.zettel"

" search config for fzf
let g:zet_search_command = "rg  --line-number --no-heading --color=always --smart-case -H ''"

let g:zet_search_options = '
                          \ --expect=ctrl-t,ctrl-v,ctrl-x,ctrl-b,ctrl-l
                          \ --ansi
                          \ --delimiter :
                          \ --bind=up:preview-up,down:preview-down
                          \ --preview ''bat --style=numbers --color=always --highlight-line {2} {1}''
                          \ --preview-window +{2}-/2
                          \ --preview-window=up:80%
                          \'

let g:zet_search_window_options = { 
  \ 'width'   : 0.5,
  \ 'height'  : 0.6,
  \ 'xoffset' : 1,
  \ 'yoffset' : 1,
  \ 'border'  : 'left' }

let s:default_todo_window_options = {
      \ 'x': 1,
      \ 'y': 0.1,
      \ 'height': 0.8,
      \ 'width': 0.3,
      \}

let s:default_float_window_options = {
      \ 'x': 0.5,
      \ 'y': 0.5,
      \ 'height': 0.5,
      \ 'width': 0.5,
      \}

let s:default_format = "%y%m%d%H%M"

function! s:comment_symbol() abort "{{{
  return split(get(b:, 'commentary_format', substitute(substitute(substitute(
        \ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', '')), '%s', 1)[0]
endfunction
"}}}

function! s:get_comment_symbol(ext) "{{{
  " [retrieve from dict](2107131453)
 
  let comment_symbols = { 
        \ 'rb' : '#',
        \ 'py' : '#',
        \ 'js' : '//',
        \ 'vim' : '"', 
        \}
  return get(comment_symbols, a:ext, '')

endfunction "}}}

function! s:get_filetype(ext) "{{{
  if a:ext ==? 'html'
    return 'html'
  elseif a:ext ==? 'dart'
    return 'dart'
  endif
  let ext = expand(a:ext)
  " let matching = uniq(sort(filter(split(execute('autocmd filetypedetect'), "\n"), 'v:val =~ "\*\.".ext')))
  let filtered = filter(split(execute('autocmd filetypedetect'), "\n"), 'v:val =~ "\*\.".ext')
  " let @a = join(sort(filtered),"\n")
  let filetype = ''
  for line in filtered
    " echo line
    if line =~ '.*' . ext . '\s'
      let filetype = matchstr(line, 'setf\s*\zs\w*')
      return filetype
    endif
  endfor
endfunction "}}}

function! s:capitalize(word) "{{{
  return substitute( a:word ,'\(\<\w\+\>\)', '\u\1', 'g')
endfunc "}}}

function! s:get_id_or_filepath() " {{{
  " check if the current file is a zettel note [check dir of the file vim](2107111552)
  " can expand be given a filename? [expand](2012071551)
  if expand('%:p:h') ==# expand(g:zet_dir)
    " use zettel id
    return expand('%:t:r')
  else
    " use the absolute path as id
    return expand('%:p:~')
  endif
endfunction "}}}

function! s:get_visual_selection() " {{{
" if there is a visually selected text use it as the text between [ ]
" ~/.zettel/2012252045.vim
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "h dp\n")
endfunction 

"}}}

function! s:append(text, filename) "{{{
  " insert backlink to the linked file [append to end of file](2107090907.vim)
  silent exec "w !echo '" . a:text . "' >> " . shellescape(expand(a:filename))
endfunc "}}}

function! s:build_filter(tags) "{{{
  let prev = ""
  for tag in a:tags

    let filter = "$(rg -l -S '" . tag . "'"
    if !empty(prev)
      let filter = filter . " " . prev
    endif
    let filter = filter . ")"
    let prev = filter
  endfor

  return filter
endfunction "}}}

function! s:copy_cursor_position() " {{{
  let @+ = join([expand('%:p:~'),  line(".")], ':')
endfunction "}}}

function! s:get_filepath_from_id(id) abort "{{{
  " needs to use systemlist cuz the result contains newline character
  let file = systemlist("rg --files " . expand(g:zet_dir) . "| rg " . a:id)

  if yuki#value#IsEmpty(file)
    throw maktaba#error#Message('ZettelNotFound', 'No such zettel(%s)', a:id)
  endif

  return file[0]
endfunction "}}}

function! s:create_zettel_id() " {{{
  let format = get(g:, 'zet_id_format', s:default_format)
  return strftime(format)
endfunction "}}}

function! s:get_markdown_link(text, link) "{{{
  return '[' . a:text . ']' . '(' . a:link . ')'
endfunction "}}}

function! HandleFZF(file) "{{{
    let absolute_path = fnameescape(fnamemodify(a:file, ":p"))
    let filename = fnameescape(fnamemodify(a:file, ":t"))
    "why only the tail ?  I believe the whole filename must be linked unless everything is flat ...
    " let filename = fnameescape(a:file)
    let filename_wo_timestamp = fnameescape(fnamemodify(a:file, ":t:s/^[0-9]*-//"))
     " Insert the markdown link to the file in the current buffer
    let mdlink = "[](".absolute_path.")"
    execute "normal! i" . mdlink . "\<ESC>?[\<CR>"
endfunction
command! -nargs=1 HandleFZF          :call HandleFZF(<f-args>)
command! ZetLink :call fzf#run(fzf#wrap({'sink' : 'HandleFZF', 'down' : '25%' }))
"}}}

function! s:is_commented() abort "{{{
  let syntax = synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")
  if syntax ==? 'comment'
    return 1
  else
    return 0
  endif
endfunction "}}}

function! s:commentout(text, ext) "{{{
  let text = a:text
  let ext = a:ext

  let comment = s:get_comment_symbol(ext)
  if comment !=# ''
    let text = comment . " " . text
  endif

  return text
endfunction "}}}

function! s:is_empty(line) " {{{
    return match(a:line, '^\s*$') != -1
endfu "}}}

function! s:generate_link(always_commentout, text, link, ext) "{{{
  let link = '[' . a:text . ']' . '(' . a:link . ')'

  if a:always_commentout
    let link = s:commentout(link, a:ext)

  " check if the current cursor position is already commented out
  elseif s:is_commented()
    " dont do anything if already commmented out
  else
    let link = s:commentout(link, a:ext)
  endif
  return link
endfunction "}}}

function! s:insert_link(link) " {{{
  let link = a:link

  " if inserting in the blank line then use cc or S
  if s:is_empty(getline('.'))
    exec "normal! cc" . link
    return
  endif

  " if the cursor is not on the space then add space
  if col(".") !=# ' '
    let link = ' ' . link
  endif

  " if the cursor is on the last col
  if col(".") == col("$")-1
    exec "normal! a" . link
  else
    exec "normal! i" . link
  endif
endfunction "}}}

function! s:extract_title() "{{{
  " .*#\s\+\zs.\{-}\ze\($\|\s#\)
  let first_line = getline(1)
  let title =  matchstr(first_line, '.*#\s\+\zs.\{-}\ze\($\|\s#\)')
  return title
endfunction " }}}

"{{{ new file
" get user input from the command-line mode
function! s:user_prompt(message)
  call inputsave()
  let input = input(a:message) 
  call inputrestore()
  return input
endfunction

" n => new note
" nl => new note with link 
" v => new note from visual mode
func! s:new_note(mode) range  

  let title = s:user_prompt("Note Title + Ext: ")
  let words = split(title)
  let title = join(words[:-2], ' ')
  let ext = words[-1]

  let new_id = strftime("%y%m%d%H%M")

  let link_keyword = ''
  if a:mode ==# 'nl'
    let link_keyword = s:user_prompt('Refer to the new note as: ')
    if link_keyword ==# ''
      let link_keyword = title
    endif

  elseif a:mode ==# 'v'
    let link_keyword = s:get_visual_selection()

    " delete the selection" [test](2107220749)
    exec "normal! gvd"
  endif

  let backlink_id = ''
  if a:mode ==# 'nl' || a:mode ==# 'v'
    " insert the link with the keyword
    " [test](2107160402)
    let link = s:generate_link(0, link_keyword, new_id, expand('%:e'))
    call s:insert_link(link)

    " save the ID to insert the backlink in the new file later
    let backlink_id = s:get_id_or_filepath()
    let backlink_keyword = s:user_prompt("Refer to this note as: ")
    let backlink = s:generate_link(1, backlink_keyword, backlink_id, ext)
  endif

  let filename = g:zet_dir . "/" . new_id . '.' . ext " [test](2107231055)

  if a:mode ==# 'n'
    exec "edit " . filename
  else
    " open the new zettel note in a float
    let options = get(g:, 'zet_float_window_options', s:default_float_window_options)
    call float#edit(filename, options)
  endif

  " always put # in the title for any files
  let title = s:get_comment_symbol(ext) . '# ' . title

  exec "normal! i" . title
  exec "normal! o\<C-U>\<C-j>\<C-j>\<C-j>"

  " insert backlink in the new note if backlink exists" [hello world](2107220805)
  if !empty(backlink_id)
    exec "normal! o" . backlink
  endif

  " go back to the beginning of the file
  " [setpos](2107111157.vim)
  " [cursor](2107210726)
  call setpos('.', [0, 0, 0, 0])
  write
endfunc 

"}}}

" jump {{{

" [extract filepath](2107272049)
function! s:extract_file(string)
  let match = matchlist(a:string, '\(\~\/.*\.\w*\):\?\(\d*\)\?')

  if yuki#value#IsEmpty(match)
    return maktaba#value#EmptyValue(match)
  endif

  let file = {}
  let file.path = match[1]
  let file.line_number = str2nr(match[2])

  return file
endfunction

" [extract zettel](2107272035)
function! s:extract_zettel(string)
  let match = matchlist(a:string, '\(\d\{10}\)\(\.\w*\)\?:\?\(\d*\)')

  if yuki#value#IsEmpty(match)
    return maktaba#value#EmptyValue(match)
  endif

  let id = match[1]
  let filepath = s:get_filepath_from_id(id)

  if yuki#value#IsEmpty(filepath)
    return maktaba#value#EmptyValue(match)
  endif

  let line_number = str2nr(match[3])

  let zettel = {}
  let zettel.id = id
  let zettel.path = filepath
  let zettel.line_number = line_number
  return zettel
endfunction

function! s:extract_jump_location(string) "{{{
  let match = matchstr(a:string, '(\zs\d\{1,9}\ze)')
  if !yuki#value#IsEmpty(match)
    let file = {}
    let file.path = expand('%:p')
    let file.line_number = str2nr(match)
    return file
  endif

  let match = matchlist(a:string, '\(\d\{10}\)\(\.\w*\)\?:\?\(\d*\)')
  if !yuki#value#IsEmpty(match)
    let id = match[1]
    let filepath = s:get_filepath_from_id(id)
    let line_number = str2nr(match[3])
    let file = {}
    let file.path = filepath
    let file.line_number = line_number
    call maktaba#ensure#FileWritable(file.path)
    return file
  endif

  let match = matchlist(a:string, '\(\~\/.*\.\w*\):\?\(\d*\)\?')
  if !yuki#value#IsEmpty(match)
    let file = {}
    let file.path = expand(match[1])
    call maktaba#ensure#FileWritable(file.path)
    let file.line_number = str2nr(match[2])
    return file
  endif

  return maktaba#value#EmptyValue(match)
endfunction "}}}

" [find file by ID in zettel](2107062330.vim)
function! s:jump_to_zettel() abort
  " [zettel plugin](~/.config/nvim/pack/mine/opt/zettel/plugin/zettel.vim:100)
  " [search()](2107202214)
  if search('\[.\{-}\](\zs[^"'']\{-}\ze)', 'wnc') == 0
    echo "No link found"
    return
  endif

  " [cfile and cWORD](2107091853.vim)
  try
    let jump_location = s:extract_jump_location(expand('<cWORD>'))
  catch /ERROR(NotFound)/
    echom v:exception
    return
  catch /ERROR(ZettelNotFound)/
    echom v:exception
    return
  endtry

  if !yuki#value#IsEmpty(jump_location)
    let is_todo_open = getwinvar(winnr(), 'todo', 0)
    if is_todo_open
      exec "wincmd p"
    endif

    exec "edit " . jump_location.path
    exec jump_location.line_number
    exec "normal! zz"
    return
  endif

  " no zettel no file found
  " [put in search register](2107131438)
  let @/ = '\[.\{-}\](\zs[^"'']\{-}\ze)'
  call feedkeys("n")
endfunction
"}}}

" {{{ search

function! s:fzf_match(line)
  let filepath = matchstr(a:line, '.\{-}\ze:\d\+:')
  let @a = filepath
  let id = matchstr(filepath, '\d\{10}')
  let ext = matchstr(filepath, '.\{-}\.\zs.\{-}$')
  return {'filepath': filepath, 'id': id, 'ext': ext}
endfunction

" https://github.com/junegunn/fzf/wiki/Examples-(vim)#narrow-ag-results-within-vim [Ag](2107131455)
" https://github.com/junegunn/fzf.vim/issues/379
function! s:sink(lines)
  let pressed_key = a:lines[0]
  let match = a:lines[1]
  call s:fzf_match(match)

  let default_cmd = 'edit'
  let cmd = get({
                \ 'ctrl-b': 'backlink',
                \ 'ctrl-l': 'link',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vertical split',
                \ }, 
                \ pressed_key, default_cmd)

  " detail of the chosen file from fzf
  let filename = matchstr(match, '.\{-}\ze:\d\+:')
  let id = matchstr(filename, '\d\{10}')
  let ext = matchstr(filename, '.\{-}\.\zs.\{-}$')

  " if the cmd is not link nor backlink
  if cmd !=# 'link' && cmd !=# 'backlink'
    execute cmd filename
    return
  endif

  " both link and backlink follows through to here

  let link_title = s:user_prompt("Refer to other note as: ") " TODO get the title of the note if left empty
  let link = s:generate_link(0, link_title, id, expand('%:e'))

  " insert the link of the chosen file
  call s:insert_link(link)

  if cmd ==# 'backlink'
    " append the link to the chosen file
    "
    " create the link
    let backlink_title = s:user_prompt("Refer to this note as: ")
    let backlink = s:generate_link(1, backlink_title, s:get_id_or_filepath(), ext)

    " insert backlink to the linked file [append to the end of file](2107090907.vim)
    let absolute_path = g:zet_dir . '/' . filename
    call s:append(backlink, absolute_path)
  endif
endfunction


" ~/.fzf/plugin/fzf.vim:416 fzf#run
" ~/.fzf/plugin/fzf.vim:272 common_sink
" ~/.fzf/plugin/fzf.vim:94
function! s:search()

  let query = s:user_prompt("Search: ")

  let initial_command = g:zet_search_command
  if !empty(query)
    let filter = s:build_filter(split(query))
    let initial_command .= " " . filter
  endif

  let spec = {
             \ 'source' : initial_command,
             \ 'options': g:zet_search_options,
             \ 'window' : g:zet_search_window_options,
             \ 'dir'    : g:zet_dir,
             \ 'sink*'   : function("s:sink"),
             \}


  call fzf#run(fzf#vim#with_preview(spec, "up"))

endfunction

" }}}

" {{{ todo

function! s:get_todo_id()
  let cursor_pos = getpos(".")

  if search('\[TODO](\zs[^"'']\{-}\ze)', 'c') == 0 " " [seach](2107202214)
       echo 'No "TODO" file found for this buffer'
       return 0
  endif

  let todo_id = matchstr(expand('<cWORD>'), '\zs\d\{10}\(\.\w\+\)\?\(:\d*\)\?\ze')
  let todo_id = split(todo_id, ':')

  call cursor(cursor_pos[1], cursor_pos[2])
  return todo_id[0]
endfunction

function! s:get_todo_window()
  for winnr in range(1, winnr('$'))
    let todo_window = getwinvar(winnr, 'todo_window' , {})
    if !empty(todo_window)
      return todo_window
    endif
  endfor
  return 0
endfunction

function! s:is_zettel_open(id)
  for i in range(1, winnr('$'))
    let filename = bufname(winbufnr(i))
    let id = matchstr(filename, '\d\{10}')
    if id == a:id
      return 1
    endif
  endfor
  return 0
endfunction

function! s:open_todo(focus)
  " extract todo id from current file
  let todo_id = s:get_todo_id()

  let todo_filepath = ''
  if empty(todo_id)
    " create new id
    let todo_id = s:create_zettel_id()
    let todo_filepath = g:zet_dir . '/' . todo_id . '.md'

    " insert the link at the end of the current file
    let markdown_link = s:get_markdown_link('TODO', todo_id)
    call s:append(markdown_link, expand('%:p'))
  else
    " get the file path from id
    let todo_filepath = s:get_filepath_from_id(todo_id)

    " check if the todo window is already open [window with custom id](2107220211)
    " can you get filename from the window number? " [link](2107220310)
    if s:is_zettel_open(todo_id)
      let todo_window = s:get_todo_window()
      call win_gotoid(todo_window.winid)
      exec "normal! :w"
      exec "normal! ZZ"
      return
    endif
  endif

  " open it in a float
  let options = get(g:, 'zet_todo_window_options', s:default_todo_window_options)
  let w:todo_window = float#edit(todo_filepath, options)

  " set the window id to the zettel id
  " how to add key/value to a dict [add to dictionary](2107240418)
  " add id to zet_todo_window TODO

  " format the todo list for narrower window
  " exec "setlocal textwidth=" . w:todo_window.width
  " exec "normal! gwG"

  setlocal relativenumber
  setlocal wrap

  if a:focus == 0
    exec "wincmd p"
  endif

endfunction


"}}}

" Create new zettel notes
nnoremap <silent> zn :<C-u>call <SID>new_note("n")<CR>

" Create new zettel note with a link
nnoremap <silent> ZN :<C-u>call <SID>new_note("nl")<CR>
vnoremap <silent> ZN :<C-u>call <SID>new_note("v")<CR>

" Jump to zettel link
nnoremap <silent> <C-n> :<C-u>call <SID>jump_to_zettel()<CR>

" Open zettel notes searcher
nnoremap <silent> zo :<C-u>call <SID>search()<CR>

" Copy the current position of the cursor to the clipboard
nnoremap <silent> zc :<C-u>call <SID>copy_cursor_position()<CR>

" Open todo list for the current file in a float window
nnoremap <silent> zO :<C-U>call <SID>open_todo(1)<CR>

" [TODO](2107170601)
