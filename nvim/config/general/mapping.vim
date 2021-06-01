
" {{{ Global

" Start Command Prompt
" map <Space> :

"}}}

" {{{ Normal

" => Jump {{{

" nnoremap <expr> ; getcharsearch().forward ? ';' : ','
" nnoremap <expr> , getcharsearch().forward ? ',' : ';'

" }}}

" => Editor {{{

" Fast saving
nnoremap <leader>w :w!<cr>

" Reverse undo
nnoremap U <C-r>

let g:highlightedyank_highlight_duration = 400

" Insert new line in a normal mode
nnoremap o o<ESC>k
nnoremap O O<ESC>j

" Disable <CR> in a normal mode
nnoremap <CR> <NOP>

" Keep the default function of pressing enter in command and quickfix
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Moving lines
" nnoremap <M-j> :m .+1<CR>==
" nnoremap <M-k> :m .-2<CR>==

nnoremap <leader>j :m .+
nnoremap <leader>k :m .-

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

nnoremap <leader>s :%s///g<left><left>

" Replace the next match with just one key!
nnoremap Q :normal! n.<CR>

" Put current word in the search register without moving
nnoremap <silent> <expr> * Highlighting()

"}}}
"
"}}}

" {{{ Insert

" exit insert mode
inoremap <C-c> <ESC>

inoremap ; :
inoremap : ;

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

onoremap h :<C-u>normal! hv^<CR>
onoremap l :<C-u>normal! v$h<CR>

onoremap k :<C-u>normal! kVgg<CR>
onoremap j :<C-u>normal! VG$<CR>

" " }}}

"{{{ Command

cnoremap ; :
cnoremap : ;

" open command history with Space
nnoremap <Space> q:

set cmdwinheight=3
augroup command_window
    autocmd!
    " <C-c> to exit insert mode
    autocmd CmdwinEnter * inoremap <buffer> <silent> <C-c> <ESC>

    " <C-c> to leave cmdline-window from normal mode
    autocmd CmdwinEnter * inoremap <buffer> <silent> <ESC> <ESC>:close<cr>

    " <ESC> to leave cmdline-window from insert mode
    autocmd CmdwinEnter * nnoremap <buffer> <silent> <C-c> :close<cr>

    " start command line window in insert mode and no line numbers
    autocmd CmdwinEnter * startinsert
    autocmd CmdwinEnter * set nonumber
    autocmd CmdwinEnter * set laststatus=0
augroup END

"}}}

