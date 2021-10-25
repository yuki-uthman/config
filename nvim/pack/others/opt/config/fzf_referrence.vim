
" Default option
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
" let g:fzf_preview_window = 'right:0%'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}


" nnoremap <silent> <C-b> :Buffers<CR>
" nnoremap <silent> <C-t> :FZF<CR>

" nnoremap /  :BLines<CR>
" nnoremap // :Lines<CR>

" Mapping selecting mappings
" nmap zn <plug>(fzf-maps-n)
" nmap zi <plug>(fzf-maps-i)
" nmap zx <plug>(fzf-maps-x)
" nmap zo <plug>(fzf-maps-o)

" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-l> <plug>(fzf-complete-line)

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-q> fzf#vim#complete('cat /usr/share/dict/words')

" Word completion with custom spec with popup layout option
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.8, 'xoffset': 1 }})

" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'down' : '30%',
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))


" Custom

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('up', 'ctrl-/'), 1)


" function! RipgrepZettel(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let spec = {'options': [ '--preview-window', 'right:70%',  
"                             \'--phony', 
"                             \'--query', a:query ],
"                  \'dir':'~/.zettel'}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction
" command! -nargs=* -bang RgZettelCode call RipgrepZettel(<q-args>, <bang>0)

" function! RipgrepZettel(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   let spec = {'options': [ '--preview-window', 'right:70%',  
"                             \'--phony', 
"                             \'--query', a:query, '--bind', 
"                             \'change:reload:'.reload_command], 
"                  \'dir':'~/.zettel'}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction
" command! -nargs=* -bang RgZettelCode call RipgrepZettel(<q-args>, <bang>0)

command! -bang -nargs=* Rgf
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case ". <q-args>, 1, <bang>0 )


" How to use list and append
" Get list of directories to search for
" You can format with fnamemodify
let s:paths = [ '~/.config', 
                  \ '~/.local',
                  \ '~/Youtube',
                  \ '~/Programming',
                  \ '~/VimWiki', ]

let s:home_dir = 'find $HOME -maxdepth 1 -type d'

" let g:netrw_winsize = 20
" command! FZFcd call fzf#run(fzf#wrap({'source': 'find ' . join(s:paths) . ' -type d;' ,
command! FZFcd call fzf#run(fzf#wrap({'source': 'find ' . join(s:paths) ,
                                      \ 'sink' : 'cd' ,
                                      \'down': '20%'}))


command! FZFVifm call fzf#run(fzf#wrap({'source': 'find ' . join(s:paths) . ' -type d;' . s:home_dir,
                                      \ 'sink' : 'Vifm' , }))
                                      " \ 'down': '20%'  , })

command! ColorFZF 
      \ call fzf#run({'source': map(split(globpath(&rtp, 'colors/*.vim')), 'fnamemodify(v:val, ":t:r")'),
                    \ 'sink'  : 'colo', 
                    \ 'left'  : '25%'})


" let $FZF_DEFAULT_OPTS="--ansi 
"                       \ --preview-window 'right:70%' 
"                       \ --layout reverse 
"                       \ --margin=1,4 
"                       \ --preview 'bat --color=always --style=header,grid --line-range :300 {}'"







function! s:make_sentence(lines)
  return substitute(join(a:lines), '^.', '\=toupper(submatch(0))', '').'.'
endfunction

" You can keep selecting the words inside FZF
" The first word would be capitalized
" period would be added after the last word chosen
inoremap <expr> <c-q> fzf#vim#complete({
  \ 'source':  'cat /usr/share/dict/words',
  \ 'reducer': function('<sid>make_sentence'),
  \ 'options': '--multi --reverse --margin 10%,0',
  \ 'down':    13})

function! s:make_sentence(lines)
  return substitute(join(a:lines), '^.', '\=toupper(submatch(0))', '').'.'
endfunction
                                                            
function! Tab() abort
  call feedkeys("\<tab>\<C-u>", "n")
endfunc

inoremap <tab> <cmd>call Tab()<CR>


" inoremap <expr> <c-q> fzf#vim#complete('cat /usr/share/dict/words')

" Better command history with q:
" command! CmdHist call fzf#vim#command_history({'right': '40'})
" nnoremap q: :CmdHist<CR>


" Better search history
" command! QHist call fzf#vim#search_history({'right': '40'})
" nnoremap q/ :QHist<CR>


" function! FuzzyFuncTrigger()
"   setlocal completefunc=FuzzyCompleteFunc
"   setlocal completeopt=menu
"   call feedkeys("\<c-x>\<c-u>", 'n')
" endfunction

" imap <c-x><c-j> <c-o>:call FuzzyFuncTrigger()<cr>

" function! TabComplete()
"   let col = col('.') - 1

"   if !col || getline('.')[col - 1] !~# '\k'
"     call feedkeys("\<tab>", 'n')
"     return
"   endif

"   call feedkeys("\<c-x>\<c-j>")
" endfunction

" inoremap <silent> <tab> <c-o>:call TabComplete()<cr>




