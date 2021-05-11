
" {{{ Global

" Start Command Prompt
map <Space> :

"}}}

" {{{ Normal

" => Jump {{{

" nnoremap h b
" nnoremap l e


" }}}

" => Editor {{{

" Fast saving
nnoremap <leader>w :w!<cr>

" Exit
nnoremap <M-w> :q!<CR>

" Space to insert space from normal mode

" Reverse undo
nnoremap U <C-r>

let g:highlightedyank_highlight_duration = 400

" Delete without saving
nnoremap D "_d
nnoremap DD "_dd

" Insert new line in a normal mode
nnoremap o o<ESC>k
nnoremap O O<ESC>j


" Disable <CR> in a normal mode
nnoremap <CR> <NOP>

" Insert empty line
" nnoremap <silent> <cr> :<C-u>call append(line("."),   repeat([""], v:count1))<CR>

" Keep the default function of pressing enter in command and quickfix
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>


" Moving lines
" nnoremap <M-j> :m .+1<CR>==
" nnoremap <M-k> :m .-2<CR>==

nnoremap <leader>j :m .+
nnoremap <leader>k :m .-

" nnoremap time "=strftime("%a %d %H:%M")<CR>P
" nnoremap mon "=strftime("%a %d %b")<CR>P
" nnoremap day "=strftime("%a %d")<CR>P
" nnoremap ss A  <ESC>
" noremap <leader>t :normal sstime<CR>
" noremap <leader>d :normal ssday<CR>
" noremap <leader>m :normal ssmon<CR>

nnoremap <leader>; :normal! mqA;<esc>`q
nnoremap <leader>, :normal! mqA,<esc>`q
nnoremap <leader>" :normal! mqA"<esc>`q
nnoremap <leader>' :normal! mqA'<esc>`q
nnoremap <leader>0 :normal! mqA)<esc>`q
nnoremap <leader>] :normal! mqA]<esc>`q
nnoremap <leader>} :normal! mqA}<esc>`q


"" Quick comment toggling
nnoremap <leader>/ :Commentary<CR>

"}}}

" => Window Management {{{

nnoremap <silent> vn :vnew<CR>
nnoremap <silent> vs :vs<CR>
" nnoremap <silent> new :new<CR>

" nnoremap <nowait> <silent> = :vertical resize +5<CR>
" nnoremap <nowait> <silent> - :vertical resize -5<CR>
" nnoremap <nowait> <silent> + :resize +1<CR>
" nnoremap <nowait> <silent> _ :resize -1<CR>

" move window up/down/right/left
" nnoremap <C-k> <C-y>
" nnoremap <C-j> <C-e>

" nnoremap <c-l> :normal! zl<CR>zlzl
" nnoremap <c-h> :normal! zh<CR>zhzh

" Use alt + w to swtich window
tnoremap <ESC> <ESC>
tnoremap <C-w> <C-\><C-N><C-w>

" Use <C-i> to exit insert mode in terminal mode
" tnoremap <C-i> <C-\><C-N>
" nnoremap <silent> <M-h> :call WinMove('h')<CR>
" nnoremap <silent> <M-j> :call WinMove('j')<CR>
" nnoremap <silent> <M-k> :call WinMove('k')<CR>
" nnoremap <silent> <M-l> :call WinMove('l')<CR>

" nnoremap <M-l> <C-w><C-l>
" nnoremap <M-h> <C-w><C-h>


" Close buffer
nnoremap <silent> <Leader>bd :Bclose<CR>

"}}}

" => File Shortcut {{{

nnoremap cd :cd %:p:h<CR>

nnoremap <F1> :call TodaysEntry()<CR>
nnoremap <F2> :edit ~/VimWiki/technology/index.wiki<CR>


"}}}

" => Search & Replace {{{

" nnoremap <expr> n  'Nn'[v:searchforward]
" nnoremap <expr> N  'nN'[v:searchforward]

" nnoremap f /
" nnoremap F ?

" Clear search buffer
nnoremap <silent> <ESC><ESC> :let @/=''<CR>
nnoremap <leader>s :%s///g<left><left>

" Highlight the selection with * then edit
" Replace the next match with just one key!
nnoremap Q :normal! n.<CR>

" Put current word in the search register without moving
nnoremap <silent> <expr> * Highlighting()

"}}}
"}}}

" {{{ Insert

" " Disable arrow keys
" inoremap <Left>  <nop>
" inoremap <Right> <nop>
" inoremap <Up>    <nop>
" inoremap <Down>  <nop>

" Use <C-hjkl> key to move around
" inoremap <nowait> <C-L> <RIGHT>
" inoremap <nowait> <C-h> <LEFT>


" Terminal shorcuts
inoremap <C-e> <ESC>$a
" inoremap <C-a> <ESC>0i

" Move current line up with C-k
imap <C-k> <ESC>lmlkojp0i

" Automatically closing braces
" inoremap {<CR> {<CR>}<Esc>ko<tab>
" inoremap [<CR> [<CR>]<Esc>ko<tab>
" inoremap (<CR> (<CR>)<Esc>ko<tab>

" " }}}

" " {{{ Visual

" xnoremap ( xi()<ESC>P
" xnoremap [ xi[]<ESC>P
" xnoremap " xi""<ESC>P
" xnoremap ' xi''<ESC>P

" vnoremap ∆ :m '>+1<CR>gv=gv
" vnoremap ˚ :m '<-2<CR>gv=gv

" vnoremap <leader>j :m '>+
" vnoremap <leader>k :m '>-

xnoremap <Leader>s :s///g<Left><Left>

" " Put current word in the search register without moving
" vnoremap <silent> * :call GetSelectedText(visualmode())<cr>

vnoremap < <gv
vnoremap > >gv


" " }}}

" " {{{ Operator Pending

" " inside the next parenthesis
" onoremap in( :<c-u>normal! f(vi(<cr>

" onoremap end :<c-u>normal! /end o<cr>

" " ruby def block
" onoremap if :<c-u>execute "normal! ?def?1\r:nohlsearch\rv/end/-1\rg_"<cr>
" onoremap af :<c-u>execute "normal! ?def?0\r:nohlsearch\rv/end/0\rg_"<cr>


onoremap h :<C-u>normal! hv^<CR>
onoremap l :<C-u>normal! v$h<CR>

" " onoremap k :<C-u>normal! H<CR>
" " onoremap j :<C-u>normal! L<CR>

onoremap k :<C-u>normal! kVgg<CR>
onoremap j :<C-u>normal! VG$<CR>

" onoremap ih :<c-u>execute "normal! /\\v^(\\=\\=+\|--+)$\r:nohlsearch\rkvg_"<cr>


" " \v(\\)@<!(\(|[|\{)
" " only search ( not preceded by \ and has a matching ) in the same line
" " \v(\\)@<!\((.*\).*$)@=
" " if you need two \ then inside the quote there would be four \
" onoremap ab :<c-u>execute "normal! /\\v(\\\\)@<!(\\(\|[\|\\{)\r:nohlsearch\rv%"<cr>

" " try it with single quote
" " onoremap ab :execute 'normal! /\v(\\)@<!(\(\|[\|\{)' . "\r:nohlsearch\rv%"<cr>

" onoremap ib :<c-u>execute "normal! /\\v(\\\\)@<!(\\(\|[\|\\{)\r%hvNly:nohlsearch\rgv"<CR>



" " fix
" " quote but ignore right after \
" onoremap aq :<c-u>execute "normal! /\\v(\\\\)@<!('\|\")\rvny:nohlsearch\rgv"<cr>
" onoremap iq :<c-u>execute "normal! /\\v('\|\")\rlvnhy:nohlsearch\rgv"<cr>

" " match only the quote with matching ending quote
" " \v(\\)@<!(")@<=.*(\\)@<!(")@=|(\\)@<!(')@<=.*(\\)@<!(')@=

" vnoremap q :<C-u>execute '/\v(\\)@<!(")@<=.*(\\)@<!(")@=\|(\\)@<!('')@<=.*(\\)@<!('')@='<CR>

" " search for opening double quote
" " \v(\\)@<!"\ze.*"

" omap aq :<C-u>execute 'normal! vqvny' . ":nohlsearch\rgv"<CR>

" " \{
" "   hello
" " }
" " { hello }

" " ( \( hello )
" " hello ( )
" " hello {world}
" " hello [world]
" " hello 'world'
" " hello "world"



" " }}}

"{{{ Comamnd

cnoremap ; :
cnoremap : ;

"}}}
