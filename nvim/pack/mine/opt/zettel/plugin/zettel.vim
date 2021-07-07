" /Users/Yuki/.custom/nvim/main/config/general/mapping.vim:318

let g:zettelkasten = "~/.zettel"
let g:tag_symbol = "#"

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
" .vim/autoload/local/zettel.vim
func! ZetNew(bang, ...) range 

  let ext = 'md'
  let ext_provided = 0
  if a:0 > 0
    let ext = s:get_filetype(a:000[-1])
    " not recognized => md
    if ext == ''
      let ext = 'md'
    else
      let ext_provided = 1
      let ext = a:000[-1]
    endif
  endif

  " build the filename
  let filename = strftime("%y%m%d%H%M"). '.' . ext

  " if called from viusal mode
  " insert the link at the current position
  let backlink = ''
  if a:bang == 1
    let selection = s:get_visual_selection()
    " delete the selection
    exec "normal! gvd"
    " is the cursor at the end of line?
    if col(".") == col("$")-1      
      " insert the markdown link 
      exec "normal! a" . '[' . selection . '](' . filename . ')'
    else
      " insert the markdown link
      exec "normal! i" . '[' . selection . '](' . filename . ')'
    endif

    " save the filename to insert the backlink in the new file
    let backlink = "[". expand('%:t:r')."](" . expand('%:t') . ")"
  endif

  " built title
  let title = ''
  if ext_provided == 1
    let title = a:000[0:-2]
  else
    let title = a:000[0:]
  endif

  let title = join(title, ' ')

  " open the new zettel note!
  exec "e " . g:zettelkasten . "/" .filename

  if ext ==# 'md'
    let title = '# ' . title
  else
    let tag = g:tag_symbol.ext
    let title = s:comment_symbol() . title . " ". tag
  endif


  exec "normal! i" . title

  " add empty lines
  exec "normal! o\<C-U>\<C-j>\<C-j>\<C-j>"

  if ext ==# 'md'
    exec "normal! otags:"

    if a:bang == 1
      exec "normal! olinks:"
      exec "normal! o\<C-i>" . backlink
    endif
  else 
    if a:bang == 1
      exec "normal! o" . s:comment_symbol(). backlink
    endif
  endif

  exec "normal! ggk"
endfunc 

command! -bang -range -nargs=* ZetNew <line1>,<line2>call ZetNew(<bang>0, <f-args>)
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
command! -nargs=* -bang ZetGrep call ZetGrep(<q-args>, <bang>0)
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
             \ 'dir': g:zettelkasten,
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
    " let @a = join(lines,"\n")
    return join(lines, "\n")
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
             \ 'dir': g:zettelkasten,
             \ 'sink': function('s:convertIntoLink')}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, "up", "ctrl-/"), a:fullscreen)
endfunction 
command! -range -nargs=* -bang ZetConvertIntoLink call ZetConvertIntoLink(<q-args>, <bang>0)
"}}}
"

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

" New notes
cnoreabbrev <expr> zn  (getcmdtype() ==# ':' && getcmdline() ==# 'zn')  ? 'ZetNew'  : 'zn'
nnoremap zn :ZetNew 
vnoremap zn :ZetNew! 

cnoreabbrev <expr> zg  (getcmdtype() ==# ':' && getcmdline() ==# 'zg')  ? 'ZetGrep'  : 'zg'
nnoremap zg :ZetGrep 

nnoremap zl :ZetLinkPreview :
vnoremap zl :ZetConvertIntoLink :

nnoremap zt "=strftime("%Y/%m/%d %H:%M")<CR>P

command! ZetCopyCursorPosition let @+ = join([expand('%:p:~'),  line(".")], ':')
nnoremap zc :ZetCopyCursorPosition<CR>

nnoremap <silent> <C-i> :<C-u>call <SID>edit_markdown_file()<CR>
