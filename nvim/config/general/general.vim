let g:python3_host_prog ='~/.asdf/shims/python'
let g:python_host_prog  = '/usr/bin/python'

" include fzf in the runtimepath
set rtp+=~/.fzf

" set config files directories 
set path+=~/.config/nvim/
set path+=~/.config/nvim/pack/mine/opt/**/*
set path+=~/.config/nvim/after/ftplugin/
set path+=~/.config/nvim/config/general/
set path+=~/.config/nvim/config/packs/
set path+=~/.config/nvim/plugin/
set path+=~/.config/nvim/snippets/

" set directories for Rails
set path+=$PWD/app/**
set path+=$PWD/db/**
set path+=$PWD/test/**

" ignore node_modules in rails project
set wildignore+=**/node_modules/** 
set wildignore+=**/.git/** 

set dictionary+=~/.config/nvim/dict/words
set dictionary+=~/.config/nvim/dict/words_cap

set autoindent
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
set relativenumber
set scrolloff=0
set shiftwidth=2
set smartindent
set splitbelow
set splitright
set tabstop=2
set timeoutlen=400
set completeopt=menuone,noselect

set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Search result updates as it is being typed
set incsearch

" Opens a horizontal split below
" set inccommand=split
set inccommand=nosplit

syntax enable
syntax on
filetype on
filetype indent on
filetype plugin on

let mapleader = " "

