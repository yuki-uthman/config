" /Users/Yuki/.custom/nvim/main/config/general/mapping.vim:318

let g:zet_dir = "~/.zettel"

" search config for fzf
let g:zet_search_command = "rg  --column --line-number --no-heading --color=always --smart-case -H ''"

let g:zet_search_options = [ 
  \ '--preview-window', '90%',
  \ '--bind', 'up:preview-up,down:preview-down',
  \ '--margin', '0%', 
  \ '--padding', '0%' ]

let g:zet_search_window = { 
  \ 'width': 0.5,
  \ 'height': 0.6,
  \ 'xoffset': 1,
  \ 'yoffset': 1,
  \ 'border': 'left' }


function! s:comment_symbol() abort "{{{
  return split(get(b:, 'commentary_format', substitute(substitute(substitute(
        \ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', '')), '%s', 1)[0]
endfunction
"}}}

func! s:get_filetype(ext) "{{{
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

func! s:capitalize(word) "{{{
  return substitute( a:word ,'\(\<\w\+\>\)', '\u\1', 'g')
endfunc "}}}

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
  let title = s:user_prompt("Note Title: ")

  let link_keyword = ''
  if a:mode ==# 'n'
    echo "new mode n"
  elseif a:mode ==# 'nl'
    let link_keyword = s:user_prompt('Link Keyword: ')
    echo "new mode nn"
  elseif a:mode ==# 'v'
    echo "new mode v"
  else
    echo "Invalid mode"
    return
  endif

  let words = split(title)
  let ext = words[-1]

  let new_id = strftime("%y%m%d%H%M")

  let backlink = ''
  if a:mode ==# 'nl'
    " insert the link with the keyword at the end of the line
    " insert space 
    exec "normal! A " . '[' . link_keyword . '](' . new_id . ')'
    " save the ID to insert the backlink in the new file later
    let id = expand('%:t:r')
    let backlink = "[". id ."](" . id . ")"
  elseif a:mode ==# 'v'
    let selection = s:get_visual_selection()
    " delete the selection
    exec "normal! gvd"
    " is the cursor at the end of line?
    if col(".") == col("$")-1      
      " insert the markdown link 
      exec "normal! a" . '[' . selection . '](' . new_id . ')'
    else
      " insert the markdown link
      exec "normal! i" . '[' . selection . '](' . new_id . ')'
    endif

    " save the ID to insert the backlink in the new file later
    let id = expand('%:t:r')
    let backlink = "[". id ."](" . id . ")"
  endif

  " always put # in the title for any files
  let words = split(title)
  let title = '# ' . join(words[0:-2], ' ')

  " add comment symbol if not md
  if ext !=# 'md'
    let comment = s:comment_symbol()

    let title = comment . title
    if !empty(backlink)
      let backlink = comment . backlink
    end
  endif

  " open the new zettel note!
  exec "e " . g:zet_dir . "/" . new_id . '.' . ext

  exec "normal! i" . title

  " add empty lines
  exec "normal! o\<C-U>\<C-j>\<C-j>\<C-j>"

  " insert backlink in the new note if backlink exists
  if !empty(backlink)
    exec "normal! o" . backlink
  endif

  " go back to the beginning of the file [setpos](2107111157.vim)
  call setpos('.', [0, 0, 0, 0])
endfunc 

"}}}

" {{{ search 

function! s:build_filter(tags)
  let prev = ""
  for tag in a:tags

    let filter = "(rg -l -S '" . tag . "'"
    if !empty(prev)
      let filter = filter . " " . prev
    endif
    let filter = filter . ")"
    let prev = filter
  endfor

  return filter
endfunction
" [ripgrep](2107070924.md)


" /Users/Yuki/.fzf/plugin/fzf.vim:94
" /Users/Yuki/.custom/nvim/main/pack/minpac/opt/fzf.vim/autoload/fzf/vim.vim:161
" https://github.com/junegunn/dotfiles/blob/master/vimrc
 " [function as a function arg](2107101658)
function! s:search(sink, fullscreen)
  let search_terms = s:user_prompt("Search: ")

  let filter = s:build_filter(split(search_terms))

  let initial_command = g:zet_search_command . " " . filter
  echo initial_command

  let spec = {
             \ 'options': g:zet_search_options,
             \ 'window' : g:zet_search_window,
             \ 'dir'    : g:zet_dir,
             \}

  if a:sink != 0 
   " [append to dict](2107110900)
    call extend( spec, { 'sink': a:sink } )
  endif

" #vim#grep ~/.custom/nvim/main/pack/minpac/opt/fzf.vim/autoload/fzf/vim.vim:775
" command (string), has_column (0/1), [options (dict)], [fullscreen (0/1)]
  call fzf#vim#grep(initial_command, 0, fzf#vim#with_preview(spec, "up", "ctrl-/"), a:fullscreen)
endfunction
" }}}

" {{{ insert link

" if there is a visually selected text use it as the text between [ ]
" ~/.zettel/2012252045.vim
function! s:get_visual_selection() 
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

" /Users/Yuki/.zettel/2012261729_extract_filename_ripgrep.vim:1
function! s:sink_insert_link(match) 
    let filename = matchstr(a:match, '.\{-}\ze:\d\+:\d\+:')

    " check if the link_keyword exists
    if !exists("b:link_keyword")
      let b:link_keyword = s:get_visual_selection()
      exec "normal! gvd"
    endif

    let mdlink = "[" . b:link_keyword . "](". filename .")"

    if col(".") == col("$")-1      
      execute "normal! a" . mdlink
    else
      execute "normal! i" . mdlink
    endif

    unlet b:link_keyword
endfunction 

function! s:insert_link(mode)
  if a:mode ==# "n" || a:mode ==# "i"
    let b:link_keyword = s:user_prompt("Link Keyword: ")
  endif
  call s:search(function('s:sink_insert_link'), 0)
endfunction

"}}}

" jump {{{
" [find file by ID in zettel](2107062329.vim)
function! s:open_ID()
  " get id from the word under the cursor
  " [cfile and cWORD](2107091853.vim)
  let matched_id = matchstr(expand('<cWORD>'), '\zs\d\{10}\(\.\w\+\)\?\(:\d*\)\?\ze')
  let matched_id = split(matched_id, ':')
  echo matched_id

  " found ID
  if !empty(matched_id)
    let id = matched_id[0]
    " need to expand ~/.zettel => /Users/Yuki [what is expand](2012071551:30) 
    " get the first file with the ID in /zettel
    let file = systemlist("find ". expand(g:zet_dir). " -iname '". id . "*' -print")[0]
    exec "edit " . file

    " found line number
    if len(matched_id) == 2
      let line_number = matched_id[1]
      call setpos('.', [0, line_number, 1, 1])
      exec "normal! zz"
    endif
  else
    " [jump to the next ID](2107091410.vim) 
    " following patterns are handled
    " <Space>ID
    " [link](ID)
    " [link](ID.ext)
    " Not compatible with obsidian
    " [link](ID:number)
    let id_regex = '\(\s\zs\d\{10}\|\[.\{-1,}](\zs\d\{10}\ze\(\(\.\|:\).\+\)\?)\)'
    exec "normal! /" . id_regex . "\<CR>"
  endif
endfunction
"}}}

" include bang!
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

nnoremap zt "=strftime("%Y/%m/%d %H:%M")<CR>P

command! ZetCopyCursorPosition let @+ = join([expand('%:p:~'),  line(".")], ':')
nnoremap zc :ZetCopyCursorPosition<CR>

" New notes
nnoremap <silent> zn :<C-u>call <SID>new_note("n")<CR>
nnoremap <silent> znn :<C-u>call <SID>new_note("nl")<CR>
vnoremap <silent> zn :<C-u>call <SID>new_note("v")<CR>

nnoremap <silent> <C-n> :<C-u>call <SID>open_ID()<CR>

" Search notes
nnoremap <silent> zz :<C-u>call <SID>search(0, 0)<CR>

" Link insertion
nnoremap <silent> zi :<C-u>call <SID>insert_link('n')<CR>
inoremap <silent> ;; <ESC>:<C-u>call <SID>insert_link('i')<CR>
vnoremap <silent> zi :<C-u>call <SID>insert_link('v')<CR>
