-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

packer = require 'packer'
packer.init {
  opt_default = true, -- Default to using opt (as opposed to start) plugins
  display = {
    open_fn  = require('packer.util').float, -- An optional function to open a window for packer's display
    working_sym = '🛠', -- The symbol for a plugin being installed/updated
    error_sym = '🧨', -- The symbol for a plugin with an error in installation/updating
    done_sym = '🎉', -- The symbol for a plugin which has completed installation/updating
    removed_sym = '🔥', -- The symbol for an unused plugin which was removed
    moved_sym = '🚀', -- The symbol for a plugin which was moved (e.g. from opt to start)
    header_sym = '━', -- The symbol for the header line in packer's display
    show_all_info = true, -- Should packer show all update details automatically?
    prompt_border = 'double', -- Border style of prompt popups.
  }
}

local use = packer.use
packer.reset()

packer.startup(function()

  use {
    'wbthomason/packer.nvim',
    opt = false
  }

  -- autocompletion
  use {
    'neoclide/coc.nvim', 
    branch = 'release'
  }

  use {
    'gelguy/wilder.nvim',
    run = ':UpdateRemotePlugins'
  }

  -- lsp
  use 'neovim/nvim-lspconfig'
  use "folke/lua-dev.nvim"

  -- auto complete
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      'hrsh7th/cmp-buffer', 
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'octaltree/cmp-look', 
      'hrsh7th/cmp-path', 
      'hrsh7th/cmp-calc',
      'f3fora/cmp-spell', 
      'hrsh7th/cmp-emoji'
    }
  }

  -- snippets
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- lua
  use 'rafcamlet/nvim-luapad'

  -- color
  use 'sainnhe/everforest'
  use 'projekt0n/github-nvim-theme'

  -- mark
  use 'Yilin-Yang/vim-markbar'

  use 'LucHermitte/lh-brackets'
  use 'LucHermitte/lh-vim-lib'
  use 'Shougo/denite.nvim'
  use 'chrisbra/Colorizer'
  use 'christoomey/vim-tmux-navigator'
  use 'christoomey/vim-tmux-runner'
  use 'dense-analysis/ale'
  use 'easymotion/vim-easymotion'
  use 'ggandor/lightspeed.nvim'
  use 'google/vim-maktaba'
  use 'gpanders/vim-medieval'
  use 'inkarkat/vim-ReplaceWithRegister'
  use 'inkarkat/vim-ingo-library'
  use 'junegunn/fzf.vim'
  use 'junegunn/goyo.vim'
  use 'junegunn/vader.vim'
  use 'junegunn/vim-easy-align'
  use 'junegunn/vim-peekaboo'
  use 'kana/vim-textobj-user'
  use 'kien/ctrlp.vim'
  use 'leonB/vim-textobj-url'
  use 'machakann/vim-highlightedyank'
  use 'machakann/vim-swap'
  use 'mattn/emmet-vim'
  use 'mattn/webapi-vim'
  use 'metakirby5/codi.vim'
  use 'mhinz/vim-lookup'
  use 'nelstrom/vim-textobj-rubyblock'
  use 'pechorin/any-jump.vim'
  use 'preservim/tagbar'
  use 'romainl/vim-cool'
  use 'rust-lang/rust.vim'
  use 'sillybun/vim-async'
  use 'svermeulen/vim-cutlass'
  use 'szw/vim-maximizer'
  use 'tomtom/tselectbuffer_vim'
  use 'tpope/vim-commentary'
  use 'tpope/vim-endwise'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'
  use 'tpope/vim-repeat'
  use 'tpope/vim-scriptease'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'vim-jp/vital.vim'
  use 'vim-ruby/vim-ruby'
  use 'vim-scripts/Decho'
  use 'vim-test/vim-test'
  use 'voldikss/vim-floaterm'
  use 'wellle/targets.vim'
  use 'yuezk/vim-js'

end)
