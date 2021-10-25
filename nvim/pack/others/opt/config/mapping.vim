
" {{{ Global

" Start Command Prompt
" map <Space> :

"}}}

" {{{ Normal

" {{{ Disable 

nnoremap s <Nop>
nnoremap <C-e> <Nop>
nnoremap <C-y> <Nop>

" }}}

" => Jump {{{

" nnoremap <expr> ; getcharsearch().forward ? ';' : ','
" nnoremap <expr> , getcharsearch().forward ? ',' : ';'

" }}}

" => Editor {{{

" Fast saving
nnoremap <leader>w :w!<cr>

" Reverse undo
nnoremap U <C-r>

" Insert new line in a normal mode
nnoremap o o<ESC>k
nnoremap O O<ESC>j

nnoremap <leader>; :normal! mqA;<esc>`q
nnoremap <leader>, :normal! mqA,<esc>`q
nnoremap <leader>" :normal! mqA"<esc>`q
nnoremap <leader>' :normal! mqA'<esc>`q
nnoremap <leader>0 :normal! mqA)<esc>`q
nnoremap <leader>] :normal! mqA]<esc>`q
nnoremap <leader>} :normal! mqA}<esc>`q


"}}}

" => Window Management {{{

nnoremap <silent> vn :vnew<CR>
nnoremap <silent> vs :vs<CR>
" nnoremap <silent> new :new<CR>

nnoremap <silent> <C-l> :b#<CR>

nnoremap <nowait> <silent> = :vertical resize +5<CR>
nnoremap <nowait> <silent> - :vertical resize -5<CR>
nnoremap <nowait> <silent> + :resize +1<CR>
nnoremap <nowait> <silent> _ :resize -1<CR>

" move window up/down/right/left
nnoremap <C-k> <C-y>
nnoremap <C-j> <C-e>

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

nnoremap ,c :find init.vim<CR>
nnoremap ,s :so ~/.config/nvim/init.vim<CR>


"}}}

" => Search & Replace {{{

nnoremap <leader>s :%s///g<Left><Left><Left>

" Replace the next match with just one key!
nnoremap Q :normal! n.<CR>

"}}}
"}}}

" {{{ Insert

" exit insert mode
" inoremap <C-c> <ESC>

" Use Ctrl-O as Enter
" inoremap <C-o> <C-j>

" whole line completion
" inoremap <C-L> <C-X><C-L>

inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

cnoremap <C-J> <C-N>
cnoremap <C-K> <C-P>


func! s:eatchar(pat)
   let c = nr2char(getchar(0))       
   return (c =~ a:pat) ? '' : c      
endfunc

" iabbrev < <><Left>
" iabbrev ( )<Left>
" iabbrev [ ]<Left>
" iabbrev { }<Left>
" iabbrev " "<Left>
" iabbrev ' '<Left>
" iabbrev ` `<Left>

" " }}}

" " {{{ Visual

" vnoremap ∆ :m '>+1<CR>gv=gv
" vnoremap ˚ :m '<-2<CR>gv=gv

" vnoremap <leader>j :m '>+
" vnoremap <leader>k :m '>-

vnoremap <leader>s :s///g<Left><Left><Left>

" " Put current word in the search register without moving
" vnoremap <silent> * :call GetSelectedText(visualmode())<cr>

" search for visually highlighted text
vnoremap // y/<C-R>"<CR>

" visually yank without moving the cursor
vnoremap y ygv<Esc>

" indent block
vnoremap < <gv
vnoremap > >gv

" swap w & b to e & ge
vnoremap w e
vnoremap b ge

" " }}}

" " {{{ Operator Pending

onoremap h :<C-u>normal! hv^<CR>
onoremap l :<C-u>normal! v$h<CR>

onoremap k :<C-u>normal! kVgg<CR>
onoremap j :<C-u>normal! VG$<CR>

" " }}}

