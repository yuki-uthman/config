" /Users/Yuki/.custom/nvim/main/config/general/mapping.vim:318

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


let g:zet_search_window = { 
  \ 'width'   : 0.5,
  \ 'height'  : 0.6,
  \ 'xoffset' : 1,
  \ 'yoffset' : 1,
  \ 'border'  : 'left' }


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
  return get(comment_symbols, a:ext)

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

function! s:insert_link(text, link, ext) " {{{
  let markdown_link = '[' . a:text . '](' . a:link . ')'

  if a:ext !=# 'md'
    let comment = s:get_comment_symbol(a:ext)
    let markdown_link = comment . " " . markdown_link
  endif

  if col(".") == col("$")-1      
    exec "normal! a" . markdown_link
  else
    exec "normal! i" . markdown_link
  endif
endfunction "}}}

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

  let link_keyword = ''
  if a:mode ==# 'nl'
    let link_keyword = s:user_prompt('Link Keyword: ')
  endif

  let title = s:user_prompt("Note Title + Ext: ")

  let words = split(title)
  let ext = words[-1]

  let new_id = strftime("%y%m%d%H%M")

  let backlink_id = ''
  if a:mode ==# 'nl'
    " insert the link with the keyword at the end of the line
    " [test](2107160402)
    " insert space 
    call s:insert_link(link_keyword, new_id, expand('%:e'))
    " exec "normal! A" . '[' . link_keyword . '](' . new_id . ')'
    " save the ID to insert the backlink in the new file later
    let backlink_id = s:get_id_or_filepath()
  elseif a:mode ==# 'v'
    let selection = s:get_visual_selection()
    " delete the selection
    exec "normal! gvd"
    " is the cursor at the end of line?
    if col(".") == col("$")-1      
      " insert the markdown link 
      exec "normal! a" . '[' . selection . '](' . new_id . ')'
    else
      " insert the markdown link [test](2107111612)
      exec "normal! i" . '[' . selection . '](' . new_id . ')'
    endif

    " save the ID to insert the backlink in the new file later
    let backlink_id = s:get_id_or_filepath()

  endif

  let filename = g:zet_dir . "/" . new_id . '.' . ext 

  " open the new zettel note in a float
  if a:mode ==# 'n'
    exec "edit " . filename
  else
    call s:edit_file_with_float(filename)
  endif

  " always put # in the title for any files
  let words = split(title)
  let title = '# ' . join(words[0:-2], ' ')

  " add comment symbol if not md
  let comment = ''
  if ext !=# 'md'
    let comment = s:comment_symbol()

    let title = comment . title
  endif

  exec "normal! i" . title

  " add empty lines
  exec "normal! o\<C-U>\<C-j>\<C-j>\<C-j>"

  " insert backlink in the new note if backlink exists
  if !empty(backlink_id)
    let backlink_keyword = s:user_prompt("Refer to this note as: ")
    let backlink = comment . '[' . backlink_keyword . ']' . '(' . backlink_id . ')'
    exec "normal! o" . backlink
  endif

  " go back to the beginning of the file [setpos](2107111157.vim)
  call setpos('.', [0, 0, 0, 0])
endfunc 

"}}}

" jump {{{
" [find file by ID in zettel](2107062329.vim)
function! s:jump_to_zettel()
  " get id from the word under the cursor
  " [cfile and cWORD](2107091853.vim)
  let matched_id = matchstr(expand('<cWORD>'), '\zs\d\{10}\(\.\w\+\)\?\(:\d*\)\?\ze')
  let matched_id = split(matched_id, ':')
  echo matched_id

  " found ID under the cursor
  if !empty(matched_id)
    let id = matched_id[0]
    " need to expand ~/.zettel => /Users/Yuki [what is expand](2012071551:30) 
    " get the first file with the ID in /zettel
    let file = systemlist("find ". expand(g:zet_dir). " -iname '". id . "*' -print")[0]
    exec "edit " . file

    " found line number
    if len(matched_id) == 2
      let line_number = matched_id[1]
       " [setpos](2107111157)
      call setpos('.', [0, line_number, 1, 1])
      exec "normal! zz"
    endif
  else
    " No ID under the cursor
    " [jump to the next ID](2107091410.vim) 
    " following patterns are handled
    " <Space>ID
    " [link](ID)
    " [link](ID.ext)
    " Not compatible with obsidian
    " [link](ID:number)

    " jump to markdown link [link](2107131419)
    " [put in search register](2107131438) todo
    let markdown_link_regex = '\[.\{-}\](\zs[^"'']\{-}\ze)'
    exec "normal! /" . markdown_link_regex . "\<CR>"
  endif
endfunction
"}}}

" {{{ search

" https://github.com/junegunn/fzf/wiki/Examples-(vim)#narrow-ag-results-within-vim [Ag](2107131455)
" https://github.com/junegunn/fzf.vim/issues/379
function! s:sink(lines)
  let pressed_key = a:lines[0]
  let match = a:lines[1]

  let default_cmd = 'edit'
  let cmd = get({
                \ 'ctrl-b': 'backlink',
                \ 'ctrl-l': 'link',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vertical split',
                \ }, 
                \ pressed_key, default_cmd)

  let filename = matchstr(match, '.\{-}\ze:\d\+:')
  let id = matchstr(filename, '\d\{10}')

  " if the cmd is not link nor backlink
  if cmd !=# 'link' && cmd !=# 'backlink'
    execute cmd filename
    return
  endif

  " both link and backlink follows through to here

  let link_title = s:user_prompt("Link Title: ")
  let link = "[" .  link_title . "]" . "(" . id . ")"

  " insert the link of the chosen file
  if col(".") == col("$")-1      
    execute "normal! a" . link
  else
    execute "normal! i" . link
  endif

  if cmd ==# 'backlink'
    " append the link to the chosen file
    "
    " create the link
    let backlink_title = s:user_prompt("Refer to this note as: ")
    let backlink = "[" . backlink_title . "](". s:get_id_or_filepath() .")"

    " get the extension of the chosen file
    let ext = matchstr(filename, '.\{-}\.\zs.\{-}$')

    " [assign variable in if statement?](2107131517) error!!!
    if ext 
      let backlink = ext . " " . backlink
    endif

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
             \ 'window' : g:zet_search_window,
             \ 'dir'    : g:zet_dir,
             \ 'sink*'   : function("s:sink"),
             \}


  call fzf#run(fzf#vim#with_preview(spec, "up"))

endfunction

" }}}

" {{{ floating window
function! s:create_float_window(filename) abort 
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {
      \ 'relative': 'editor',
      \ 'row': top,
      \ 'col': left,
      \ 'width': width,
      \ 'height': height,
      \ 'style': 'minimal',
      \ 'focusable': v:false
    \ }

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰─" . repeat("─", width - 3) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let border_bufnr = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(border_bufnr, 0, -1, v:true, lines)
    let s:border_winid = nvim_open_win(border_bufnr, v:true, opts)

    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    let opts.focusable = v:true
    let text_bufnr = nvim_create_buf(v:false, v:true)
    call nvim_open_win(text_bufnr, v:true, opts)

    set winhl=Normal:Floating
    au WinLeave * ++once :q | call nvim_win_close(s:border_winid, v:true)
    return text_bufnr
endfunction

function! s:edit_file_with_float(query) abort
    call s:create_float_window(a:query)
    execute 'edit ' . a:query
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
nnoremap zc :<C-u>call <SID>copy_cursor_position()<CR>

