" /Users/Yuki/.custom/nvim/main/config/general/mapping.vim:318

let g:zettelkasten = "~/.zettel/"
let g:filetypes = [ ]
let g:zet_separator = '_'

function! s:comment_symbol() abort
  return split(get(b:, 'commentary_format', substitute(substitute(substitute(
        \ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', '')), '%s', 1)[0]
endfunction


command! -bang -range -nargs=* ZetNew <line1>,<line2>call ZetNew(<bang>0, <f-args>)
cnoreabbrev <expr> zn  (getcmdtype() ==# ':' && getcmdline() ==# 'zn')  ? 'ZetNew'  : 'zn'
nnoremap zn :ZetNew 
vnoremap zn :ZetNew! 

func! s:get_filetype(ext)
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
endfunction

func! s:capitalize(word)
  return substitute( a:word ,'\(\<\w\+\>\)', '\u\1', 'g')
endfunc

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
  let filename = g:zettelkasten . strftime("%y%m%d_%H%M"). '.' . ext

  " if called from viusal mode
  " insert the link at the current position
  let selection = ''
  if a:bang == 1
    " echo 'visual mode'
    let @a = s:get_visual_selection()
    let selection = s:get_visual_selection()
    " delete the selection
    exec "normal! gvd"
    " insert the markdown link
    exec "normal! i" . '[' . selection . '](' . filename . ')'
  endif

  " built title
  let title = ''
  if ext_provided == 1
    let title = a:000[0:-2]
  else
    let title = a:000[0:]
  endif
  let title = map(title, "s:capitalize(v:val)")
  let title = join(title, ' ')

  " open the new zettel note!
  exec "e " . filename

  if ext ==# 'md'
    let title = '# ' . title
  else
    let tag = ':'.ext.':'
    let title = s:comment_symbol() . title .' '. tag
  endif

  " add title
  exec "normal! i" . title

  " add 2 empty lines
  exec "normal! o\<C-U>\<ESC>o\<ESC>k"

endfunc



command! -nargs=* Zet call Zet(<f-args>)
" .vim/autoload/local/zettel.vim
func! Zet(...)

  " default extension => md
  let extension = 'md'

  let title = 'diary'

  " build the file name
  let l:sep = ''

  if len(a:000) == 1
    let l:sep = '_'
    let extension = a:1
  elseif len(a:000) > 1
    let l:sep = '_'
    let extension = a:000[-1]
    let title = a:000[:-2]
  endif

  let l:fname = g:zettelkasten . strftime("%y%m%d%H%M") . l:sep . join( title , l:sep ) . '.' . extension

  " exec "normal! i" . l:fname

  " edit the new file
  exec "e " . l:fname

  " %d => 01
  " %e =>  1
  let date = strftime("%e %B %Y")
  if len(a:000) > 0
    let title_list = a:000[:-2]
    let first_word = title_list[0]
    let rest_of_the_title = title_list[1:]

    if extension ==? 'md' || extension ==? 'vimwiki'
      " capitalize the first word and leave the rest as it is
      let first_word = substitute( first_word ,'\(\<\w\+\>\)', '\u\1', 'g')
      let rest_of_the_title = join( rest_of_the_title, ' ' )
      let title = first_word . ' ' . rest_of_the_title

        " # Title
        exec "normal! i# ". title

        " add two empty lines
        exec "normal! o\<ESC>\<C-U>o\<ESC>k"

    else
      " eg
      " # :python: title
      let tag = ':'.&ft.':'

      " this inserts the title after the tag
      exec "normal! i". s:comment_symbol() . tag . join(title_list,' ') . "\<ESC>"
      " add two empty lines
      exec "normal! o\<C-u>\<ESC>o\<ESC>k"
    endif

  else
    " No title No extension given
    "  2 December 2020
    exec "normal! i# " . date . "\<ESC>o\<ESC>o\<ESC>kk"
  endif
endfunc




command! ZetCopyCursorPosition let @+ = join([expand('%:p'),  line(".")], ':')

" /Users/Yuki/.fzf/plugin/fzf.vim:94
" /Users/Yuki/.custom/nvim/main/pack/minpac/opt/fzf.vim/autoload/fzf/vim.vim:161
" refactor to use function rather than this looong command
" https://github.com/junegunn/dotfiles/blob/master/vimrc
nnoremap zg :ZetGrep :
cnoreabbrev <expr> zg  (getcmdtype() ==# ':' && getcmdline() ==# 'zg')  ? 'ZetGrep'  : 'zg'
command! -bang -nargs=* ZetGrep
  \ call fzf#vim#grep("rg  --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
                        \ 1,
                        \fzf#vim#with_preview({'options': [
                        \                                   '--preview-window', '90%',
                        \                                   '--bind', 'up:preview-up,down:preview-down',
                        \                                   '--margin', '0%', '--padding', '0%'],
                        \                       'window': { 'width': 0.5,
                        \                                   'height': 0.6,
                        \                                   'xoffset': 1,
                        \                                   'yoffset': 1,
                        \                                   'border': 'left',
                        \                                  },
                        \                       'dir': '~/.zettel'}, 
                        \                       'up',  'ctrl-/'),
                        \ <bang>0)


command! -bang -nargs=* ZetLinkPreview
  \ call fzf#vim#grep("rg  --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
                        \ 1,
                        \fzf#vim#with_preview({'options': [
                        \                                   '--preview-window', 'top:90%',
                        \                                   '--bind', 'up:preview-up,down:preview-down',
                        \                                   '--margin', '0%', '--padding', '0%'],
                        \                       'window': { 'width': 0.5,
                        \                                   'height': 0.6,
                        \                                   'xoffset': 1,
                        \                                   'yoffset': 1,
                        \                                   'border': 'left',
                        \                                  },
                        \                       'dir': '~/.zettel',
                        \                       'sink': function('s:insertLink') },
                        \                       'up', 'ctrl-/'),
                        \ <bang>0)


command! -range -bang -nargs=* ZetConvertIntoLink
  \ call fzf#vim#grep("rg  --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
                        \ 1,
                        \fzf#vim#with_preview({'options': [
                        \                                   '--preview-window', 'top:90%',
                        \                                   '--bind', 'up:preview-up,down:preview-down',
                        \                                   '--margin', '0%', '--padding', '0%'],
                        \                       'window': { 'width': 0.5,
                        \                                   'height': 0.6,
                        \                                   'xoffset': 1,
                        \                                   'yoffset': 1,
                        \                                   'border': 'left',
                        \                                  },
                        \                       'dir': '~/.zettel',
                        \                       'sink': function('s:convertIntoLink') },
                        \                       'up',  'ctrl-/'),
                        \ <bang>0)


" include bang!
function! HandleFZF(file)
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


" for normal mode sink
" /Users/Yuki/.zettel/2012261729_extract_filename_ripgrep.vim:1
function! s:insertLink(match)
    let l:filename = matchstr(a:match, '.\{-}\ze:\d\+:\d\+:')
    let mdlink = "[](". g:zettelkasten . l:filename .")"
    execute "normal! i" . mdlink . "\<ESC>?[\<CR>"
endfunction

" if there is a visually selected text use it as the text between [ ]
"/Users/Yuki/.zettel/2012252045_visual_selection_as_arguments.vim
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
    let mdlink = "[". l:selection ."](". g:zettelkasten .l:filename .")"
    execute "normal! i " . mdlink . "\<ESC>?[\<CR>"
endfunction

command!          ZetLink :call fzf#run(fzf#wrap({'sink' : 'HandleFZF',
                                                           \ 'down' : '25%' }))




" nnoremap zn :Zet

" Link Generation
" nnoremap zf :ZetLink<CR>
nnoremap zl :ZetLinkPreview :
vnoremap zl :ZetConvertIntoLink :


nnoremap zt "=strftime("%Y/%m/%d %H:%M")<CR>P



" nnoremap zg :Denite -path=$HOME/.zettel grep<CR>
nnoremap zg :ZetGrep :
cnoreabbrev <expr> zg  (getcmdtype() ==# ':' && getcmdline() ==# 'zg')  ? 'ZetGrep'  : 'zg'

nnoremap zcc :ZetCopyCursorPosition<CR>
nmap zx <Plug>VimwikiToggleListItem
" /Users/Yuki/.custom/nvim/minpac/after/ftplugin/vimwiki.vim:15
