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

  " go back to the beginning of the file
  exec "normal! ggk"
endfunc 

"}}}

" {{{ search 
" /Users/Yuki/.fzf/plugin/fzf.vim:94
" /Users/Yuki/.custom/nvim/main/pack/minpac/opt/fzf.vim/autoload/fzf/vim.vim:161
" refactor to use function rather than this looong command
" https://github.com/junegunn/dotfiles/blob/master/vimrc
function! ZetGrep(query, fullscreen) 
  let initial_command = "rg  --column --line-number --no-heading --color=always --smart-case ".shellescape(a:query)

  let spec = {'options': [ '--preview-window', '90%',
             \             '--bind', 'up:preview-up,down:preview-down',
             \             '--margin', '0%', 
             \             '--padding', '0%'],
             \ 'window': { 'width': 0.5,
             \             'height': 0.6,
             \             'xoffset': 1,
             \             'yoffset': 1,
             \             'border': 'left',
             \            },
             \ 'dir': g:zettelkasten }
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, "up", "ctrl-/"), a:fullscreen)
endfunction 
command! -nargs=* -bang ZetSearch call s:zet_search(<q-args>, <bang>0)
"}}}

" for normal mode sink
" /Users/Yuki/.zettel/2012261729_extract_filename_ripgrep.vim:1
function! s:insertLink(match) "{{{
    let l:filename = matchstr(a:match, '.\{-}\ze:\d\+:\d\+:')
    let mdlink = "[](". l:filename .")"
    execute "normal! i" . mdlink . "\<ESC>?[\<CR>"
endfunction "}}}

function! ZetLinkPreview(query, fullscreen) "{{{
  let initial_command = "rg  --column --line-number --no-heading --color=always --smart-case ".shellescape(a:query)

  let spec = {'options': [ '--preview-window', '90%',
             \             '--bind', 'up:preview-up,down:preview-down',
             \             '--margin', '0%', 
             \             '--padding', '0%'],
             \ 'window': { 'width': 0.5,
             \             'height': 0.6,
             \             'xoffset': 1,
             \             'yoffset': 1,
             \             'border': 'left',
             \            },
             \ 'dir': g:zet_dir,
             \ 'sink': function('s:insertLink')}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, "up", "ctrl-/"), a:fullscreen)
endfunction 
command! -nargs=* -bang ZetLinkPreview call ZetLinkPreview(<q-args>, <bang>0)
"}}}

" {{{ helper functions for ZetConvertIntoLink

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

" for visual mode sink
" /Users/Yuki/.zettel/2012261729_extract_filename_ripgrep.vim:1
function! s:convertIntoLink(match)
    let l:filename = matchstr(a:match, '.\{-}\ze:\d\+:\d\+:')
    let l:selection = s:get_visual_selection()
    exec "normal! gvd"
    let mdlink = "[". l:selection ."](". l:filename .")"

    if col(".") == col("$")-1      
      execute "normal! a" . mdlink . "\<ESC>o\<ESC>k/[\<CR>"
    else
      execute "normal! i" . mdlink . "\<ESC>?[\<CR>"
    endif

endfunction "}}}

function! ZetConvertIntoLink(query, fullscreen) "{{{
  let initial_command = "rg  --column --line-number --no-heading --color=always --smart-case ".shellescape(a:query)

  let spec = {'options': [ '--preview-window', '90%',
             \             '--bind', 'up:preview-up,down:preview-down',
             \             '--margin', '0%', 
             \             '--padding', '0%'],
             \ 'window': { 'width': 0.5,
             \             'height': 0.6,
             \             'xoffset': 1,
             \             'yoffset': 1,
             \             'border': 'left',
             \            },
             \ 'dir': g:zet_dir,
             \ 'sink': function('s:convertIntoLink')}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, "up", "ctrl-/"), a:fullscreen)
endfunction 
command! -range -nargs=* -bang ZetConvertIntoLink call ZetConvertIntoLink(<q-args>, <bang>0)
"}}}
"
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

" jump {{{
"~/.zettel/2107062329.vim:13
function! s:edit_markdown_file()
  " get id from the markdown link
  let id = matchstr(getline('.'), '\[.*\](\zs.\{-}\ze)')

  if empty(id)
    exec "normal! 1\<C-i>"
  else
    let file = systemlist("find . -iname '". id . "*' -print")[0]
    exec "edit " . g:zettelkasten . "/" . file
  endif
endfunction
"}}}


cnoreabbrev <expr> zg  (getcmdtype() ==# ':' && getcmdline() ==# 'zg')  ? 'ZetGrep'  : 'zg'
nnoremap zg :ZetGrep 

nnoremap zl :ZetLinkPreview :
vnoremap zl :ZetConvertIntoLink :

nnoremap zt "=strftime("%Y/%m/%d %H:%M")<CR>P

command! ZetCopyCursorPosition let @+ = join([expand('%:p:~'),  line(".")], ':')
nnoremap zc :ZetCopyCursorPosition<CR>

" New notes
nnoremap <silent> zn :<C-u>call <SID>new_note("n")<CR>
nnoremap <silent> znn :<C-u>call <SID>new_note("nl")<CR>
vnoremap <silent> zn :<C-u>call <SID>new_note("v")<CR>

nnoremap <silent> <C-n> :<C-u>call <SID>open_ID()<CR>
