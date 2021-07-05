
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()

function! PackInit() abort

  packadd minpac

  call minpac#init()

  " tpope
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-endwise')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-repeat')


  " Editor
  call minpac#add('machakann/vim-highlightedyank')
  call minpac#add('machakann/vim-swap')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vim-peekaboo')
  call minpac#add('junegunn/vim-easy-align', { 'type' : 'opt' })
  call minpac#add('neoclide/coc.nvim', { 'type' : 'opt' } , {'branch' : 'release' } )
  call minpac#add('metakirby5/codi.vim', { 'type' : 'opt' } )
  call minpac#add('dense-analysis/ale', { 'type' : 'opt' } )
  call minpac#add('vim-test/vim-test', { 'type' : 'opt' } )
  call minpac#add('wellle/targets.vim', { 'type' : 'opt' })
  call minpac#add('preservim/tagbar')
  call minpac#add('kana/vim-textobj-user')
  call minpac#add('easymotion/vim-easymotion', { 'type' : 'opt' })

  " Chris Toomey
  call minpac#add('inkarkat/vim-ReplaceWithRegister', { 'type' : 'opt' })
  call minpac#add('svermeulen/vim-cutlass', { 'type' : 'opt' })
  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('christoomey/vim-tmux-runner')

  " File manager
  call minpac#add('vifm/vifm.vim')

  " Snipmate
  call minpac#add('garbas/vim-snipmate')
  call minpac#add('MarcWeber/vim-addon-mw-utils')
  call minpac#add('tomtom/tlib_vim')

  " Ruby
  call minpac#add('tpope/vim-rails', { 'type' : 'opt' })
  call minpac#add('vim-ruby/vim-ruby', { 'type' : 'opt' })
  call minpac#add('nelstrom/vim-textobj-rubyblock', { 'type' : 'opt' })

  " Rust
  call minpac#add('rust-lang/rust.vim', { 'type' : 'opt' })

  " Javascript
  call minpac#add('yuezk/vim-js', { 'type' : 'opt' })

  " PHP

  " Dart
  call minpac#add('dart-lang/dart-vim-plugin')

  " HTML & CSS
  call minpac#add('mattn/emmet-vim', { 'type' : 'opt' })
  call minpac#add('chrisbra/Colorizer')

  " Markdown
  call minpac#add('junegunn/goyo.vim', { 'type' : 'opt' })
  call minpac#add('gabrielelana/vim-markdown', { 'type' : 'opt' })

  " Vimscript
  call minpac#add('junegunn/vader.vim', { 'type' : 'opt' })
endfunction

runtime macros/matchit.vim

runtime config/packs/ale.vim
runtime config/packs/coc.vim
runtime config/packs/codi.vim
runtime config/packs/cutlass.vim
runtime config/packs/emmet.vim
runtime config/packs/fzf.vim
runtime config/packs/netrw.vim
runtime config/packs/peekaboo.vim
runtime config/packs/snipmate.vim
runtime config/packs/tmux.vim
runtime config/packs/vifm.vim
runtime config/packs/vim-test.vim
runtime config/packs/easymotion.vim

packadd ale
packadd coc.nvim
packadd codi.vim
packadd emmet-vim
packadd targets.vim
packadd vader.vim
packadd vim-ReplaceWithRegister
packadd vim-cutlass
packadd vim-test
packadd vim-easymotion

" My plugin
packadd dictionary
packadd editor
packadd files
packadd zettel
packadd colemak
