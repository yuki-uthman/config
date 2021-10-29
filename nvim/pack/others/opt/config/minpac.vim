
command! MinUpdate call s:minpac_init() | call minpac#update()
command! MinClean  call s:minpac_init() | call minpac#clean()

function! s:minpac_init() abort

  packadd minpac

  call minpac#init({'dir': expand('~/.local/share/nvim/site')})

  call minpac#add('BetterLua.vim', #{ type : 'opt'})
  call minpac#add('Decho', #{ type: 'opt'})
  call minpac#add('any-jump.vim', #{ type : 'opt'})
  call minpac#add('cmp-buffer', #{ type : 'opt'})
  call minpac#add('cmp-nvim-lsp', #{ type : 'opt'})
  call minpac#add('cmp-nvim-lua', #{ type : 'opt'})
  call minpac#add('cmp-path', #{ type : 'opt'})
  call minpac#add('cmp-vsnip', #{ type : 'opt'})
  call minpac#add('codi.vim', #{ type : 'opt'})
  call minpac#add('everforest', #{ type : 'opt'})
  call minpac#add('float.nvim', #{ type : 'opt'})
  call minpac#add('fzf-lsp.nvim', #{ type : 'opt'})
  call minpac#add('fzf.vim', #{ type : 'opt'})
  call minpac#add('goyo.vim', #{ type : 'opt'})
  call minpac#add('lspkind-nvim', #{ type : 'opt'})
  call minpac#add('lua-dev.nvim', #{ type : 'opt'})
  call minpac#add('nvim-cmp', #{ type : 'opt'})
  call minpac#add('nvim-colorizer.lua', #{ type : 'opt'})
  call minpac#add('nvim-fzf', #{ type : 'opt'})
  call minpac#add('nvim-lspconfig', #{ type : 'opt'})
  call minpac#add('nvim-lspfuzzy', #{ type : 'opt'})
  call minpac#add('nvim-luapad', #{ type : 'opt'})
  call minpac#add('nvim-treesitter', #{ type : 'opt'})
  call minpac#add('nvim-treesitter-textobjects', #{ type : 'opt'})
  call minpac#add('nvim-treesitter-textsubjects', #{ type : 'opt'})
  call minpac#add('registers.nvim', #{ type : 'opt'})
  call minpac#add('tagbar', #{ type : 'opt'})
  call minpac#add('targets.vim', #{ type : 'opt'})
  call minpac#add('vim-ReplaceWithRegister', #{ type : 'opt'})
  call minpac#add('vim-async', #{ type : 'opt'})
  call minpac#add('vim-commentary', #{ type : 'opt'})
  call minpac#add('vim-cool', #{ type : 'opt'})
  call minpac#add('vim-cutlass', #{ type : 'opt'})
  call minpac#add('vim-easy-align', #{ type : 'opt'})
  call minpac#add('vim-easymotion', #{ type : 'opt'})
  call minpac#add('vim-endwise', #{ type : 'opt'})
  call minpac#add('vim-floaterm', #{ type : 'opt'})
  call minpac#add('vim-fugitive', #{ type : 'opt'})
  call minpac#add('vim-highlightedyank', #{ type : 'opt'})
  call minpac#add('vim-js', #{ type : 'opt'})
  call minpac#add('vim-lookup', #{ type : 'opt'})
  call minpac#add('vim-lua', #{ type : 'opt'})
  call minpac#add('vim-maktaba', #{ type : 'opt'})
  call minpac#add('vim-maximizer', #{ type : 'opt'})
  call minpac#add('vim-medieval', #{ type : 'opt'})
  call minpac#add('vim-peekaboo', #{ type : 'opt'})
  call minpac#add('vim-rails', #{ type : 'opt'})
  call minpac#add('vim-repeat', #{ type : 'opt'})
  call minpac#add('vim-ruby', #{ type : 'opt'})
  call minpac#add('vim-scriptease', #{ type : 'opt'})
  call minpac#add('vim-surround', #{ type : 'opt'})
  call minpac#add('vim-swap', #{ type : 'opt'})
  call minpac#add('vim-test', #{ type : 'opt'})
  call minpac#add('vim-textobj-rubyblock', #{ type : 'opt'})
  call minpac#add('vim-textobj-url', #{ type : 'opt'})
  call minpac#add('vim-textobj-user', #{ type : 'opt'})
  call minpac#add('vim-tmux-navigator', #{ type : 'opt'})
  call minpac#add('vim-tmux-runner', #{ type : 'opt'})
  call minpac#add('vim-unimpaired', #{ type : 'opt'})
  call minpac#add('vim-vsnip', #{ type : 'opt'})
  call minpac#add('vim-vsnip-integ', #{ type : 'opt'})
  call minpac#add('wilder.nvim', #{ type : 'opt'})

endfunction
