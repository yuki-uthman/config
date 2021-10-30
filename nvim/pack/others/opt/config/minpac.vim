
command! MinUpdate call s:minpac_init() | call minpac#update()
command! MinClean  call s:minpac_init() | call minpac#clean()

function! s:minpac_init() abort

  packadd minpac

  call minpac#init({'dir': expand('~/.local/share/nvim/site')})

  call minpac#add('christoomey/vim-tmux-navigator', #{type: 'opt'})
  call minpac#add('christoomey/vim-tmux-runner', #{type: 'opt'})
  call minpac#add('folke/lua-dev.nvim', #{type: 'opt'})
  call minpac#add('gelguy/wilder.nvim', #{type: 'opt'})
  call minpac#add('google/vim-maktaba', #{type: 'opt'})
  call minpac#add('gpanders/vim-medieval', #{type: 'opt'})
  call minpac#add('hrsh7th/cmp-buffer', #{type: 'opt'})
  call minpac#add('hrsh7th/cmp-nvim-lsp', #{type: 'opt'})
  call minpac#add('hrsh7th/cmp-nvim-lua', #{type: 'opt'})
  call minpac#add('hrsh7th/cmp-vsnip', #{type: 'opt'})
  call minpac#add('hrsh7th/nvim-cmp', #{type: 'opt'})
  call minpac#add('hrsh7th/vim-vsnip', #{type: 'opt'})
  call minpac#add('hrsh7th/vim-vsnip-integ', #{type: 'opt'})
  call minpac#add('junegunn/fzf.vim', #{type: 'opt'})
  call minpac#add('junegunn/vim-easy-align', #{type: 'opt'})
  call minpac#add('kana/vim-textobj-user', #{type: 'opt'})
  call minpac#add('leonB/vim-textobj-url', #{type: 'opt'})
  call minpac#add('machakann/vim-highlightedyank', #{type: 'opt'})
  call minpac#add('machakann/vim-swap', #{type: 'opt'})
  call minpac#add('mhinz/vim-lookup', #{type: 'opt'})
  call minpac#add('neovim/nvim-lspconfig', #{type: 'opt'})
  call minpac#add('pechorin/any-jump.vim', #{type: 'opt'})
  call minpac#add('preservim/tagbar', #{type: 'opt'})
  call minpac#add('romainl/vim-cool', #{type: 'opt'})
  call minpac#add('svermeulen/vim-cutlass', #{type: 'opt'})
  call minpac#add('tpope/vim-commentary', #{type: 'opt'})
  call minpac#add('tpope/vim-endwise', #{type: 'opt'})
  call minpac#add('tpope/vim-fugitive', #{type: 'opt'})
  call minpac#add('tpope/vim-repeat', #{type: 'opt'})
  call minpac#add('tpope/vim-scriptease', #{type: 'opt'})
  call minpac#add('tpope/vim-surround', #{type: 'opt'})
  call minpac#add('tpope/vim-unimpaired', #{type: 'opt'})
  call minpac#add('vim-scripts/Decho', #{type: 'opt'})
  call minpac#add('voldikss/vim-floaterm', #{type: 'opt'})
  call minpac#add('wellle/targets.vim', #{type: 'opt'})

endfunction

