
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()

function! PackInit() abort

  packadd minpac

  call minpac#init({'dir': expand('~/.local/share/nvim/site')})

  " tpope
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-endwise' , { 'type' : 'opt' })
  call minpac#add('tpope/vim-scriptease' , { 'type' : 'opt' })
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-repeat')

  " Editor
  call minpac#add('dense-analysis/ale', { 'type' : 'opt' } )
  call minpac#add('easymotion/vim-easymotion', { 'type' : 'opt' })
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vim-easy-align', { 'type' : 'opt' })
  call minpac#add('junegunn/vim-peekaboo')
  call minpac#add('machakann/vim-highlightedyank')
  call minpac#add('machakann/vim-swap')
  call minpac#add('metakirby5/codi.vim', { 'type' : 'opt' } )
  call minpac#add('preservim/tagbar')
  call minpac#add('vim-test/vim-test', { 'type' : 'opt' } )
  call minpac#add('wellle/targets.vim', { 'type' : 'opt' })
  call minpac#add('gelguy/wilder.nvim', { 'type' : 'opt' })
  call minpac#add('ggandor/lightspeed.nvim', { 'type' : 'opt' })
  call minpac#add('romainl/vim-cool', { 'type' : 'opt' })
  call minpac#add('szw/vim-maximizer', { 'type' : 'opt' })
  call minpac#add('voldikss/vim-floaterm', { 'type' : 'opt' })

  " Text Object
  call minpac#add('kana/vim-textobj-user')
  call minpac#add('leonB/vim-textobj-url', { 'type' : 'opt' })

  " Library
  call minpac#add('google/vim-maktaba', { 'type' : 'opt' })
  call minpac#add('LucHermitte/lh-vim-lib', {'type' : 'opt' })
  call minpac#add('LucHermitte/lh-brackets', {'type' : 'opt' })
  call minpac#add('vim-jp/vital.vim', {'type' : 'opt' })
  call minpac#add('inkarkat/vim-ingo-library', {'type' : 'opt' })
  call minpac#add('mattn/webapi-vim', {'type' : 'opt' })
  call minpac#add('sillybun/vim-async', { 'type' : 'opt' })

  " Vimscript
  call minpac#add('junegunn/vader.vim', { 'type' : 'opt' })

  " Various searcher
  call minpac#add('tomtom/tselectbuffer_vim', {'type' : 'opt' })
  call minpac#add('pechorin/any-jump.vim', {'type' : 'opt' })
  call minpac#add('mhinz/vim-lookup', {'type' : 'opt' })
  call minpac#add('Shougo/denite.nvim', {'type' : 'opt' })
  call minpac#add('kien/ctrlp.vim', {'type' : 'opt' })

  " Chris Toomey
  call minpac#add('inkarkat/vim-ReplaceWithRegister', { 'type' : 'opt' })
  call minpac#add('svermeulen/vim-cutlass', { 'type' : 'opt' })
  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('christoomey/vim-tmux-runner')

  " snippets
  " call minpac#add('garbas/vim-snipmate')
  " call minpac#add('MarcWeber/vim-addon-mw-utils')
  " call minpac#add('tomtom/tlib_vim')
  call minpac#add('hrsh7th/vim-vsnip', { 'type' : 'opt' })

  " Ruby
  call minpac#add('tpope/vim-rails', { 'type' : 'opt' })
  call minpac#add('vim-ruby/vim-ruby', { 'type' : 'opt' })
  call minpac#add('nelstrom/vim-textobj-rubyblock', { 'type' : 'opt' })

  " Rust
  call minpac#add('rust-lang/rust.vim', { 'type' : 'opt' })

  " Javascript
  call minpac#add('yuezk/vim-js', { 'type' : 'opt' })

  " Dart
  call minpac#add('dart-lang/dart-vim-plugin')

  " HTML & CSS
  call minpac#add('mattn/emmet-vim', { 'type' : 'opt' })
  call minpac#add('chrisbra/Colorizer')

  " Markdown
  call minpac#add('junegunn/goyo.vim', { 'type' : 'opt' })
  call minpac#add('gpanders/vim-medieval', { 'type' : 'opt' })


endfunction

