let g:python3_host_prog ='~/.asdf/shims/python'
let g:python_host_prog  = '/usr/bin/python'

" include fzf in the runtimepath
set rtp+=~/.fzf

" set config files directories 
set path+=~/.config/nvim/
set path+=~/.config/nvim/lua/
set path+=~/.config/nvim/lua/**/*
set path+=~/.config/nvim/pack/mine/opt/**/*
set path+=~/.config/nvim/after/ftplugin/
set path+=~/.config/nvim/config/general/
set path+=~/.config/nvim/pack/config/opt/config/
set path+=~/.config/nvim/plugin/
set path+=~/.config/nvim/vsnip/

" set directories for Rails
set path+=$PWD/app/**
set path+=$PWD/db/**
set path+=$PWD/test/**

" ignore node_modules in rails project
set wildignore+=**/node_modules/** 
set wildignore+=**/.git/** 

set dictionary+=~/.config/nvim/dict/words
set dictionary+=~/.config/nvim/dict/words_cap
set dictionary+=~/.config/nvim/dict/info

set thesaurus+=~/.config/nvim/dict/thesaurus
" set thesaurus+=~/.config/nvim/dict/mthesaur.txt

function! s:thesaurus()
    let s:saved_ut = &ut
    if &ut > 200 | let &ut = 200 | endif
    augroup ThesaurusAuGroup
        autocmd CursorHold,CursorHoldI <buffer>
                    \ let &ut = s:saved_ut |
                    \ set iskeyword-=32 |
                    \ autocmd! ThesaurusAuGroup
    augroup END
    return ":set iskeyword+=32\<cr>vaWovea\<c-x>\<c-t>"
endfunction

nnoremap <expr> <leader>t <SID>thesaurus()

set clipboard=unnamed
set clipboard=unnamedplus
set expandtab
set hidden
set laststatus=1
set mouse=a
set noruler
set noshowcmd 
set noshowmode
set nospell
set noswapfile
set nowrap
set number
set norelativenumber
set scrolloff=0
set shiftwidth=2
" set smartindent
set splitbelow
set splitright
set tabstop=2
set timeoutlen=400
set completeopt=menu
set signcolumn=number

" this is the default here for reminder
set formatoptions=tcqj

set ignorecase
set smartcase

" Opens a horizontal split below
" set inccommand=split
set inccommand=nosplit

syntax enable
filetype on
filetype indent on

let mapleader = " "





