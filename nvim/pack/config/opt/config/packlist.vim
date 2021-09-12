


" call plugpac#begin()

" minpac
" Pack 'k-takata/minpac'                      , {'type': 'opt'}

" Editor
" Pack 'tpope/vim-commentary'                 , {'type':'opt'}
" Pack 'tpope/vim-endwise'                    , {'type':'opt'}
" Pack 'tpope/vim-unimpaired'                 , {'type':'opt'}
" Pack 'tpope/vim-scriptease'                 , {'type':'opt'}
" Pack 'machakann/vim-highlightedyank'        , {'type':'opt'}
" Pack 'machakann/vim-swap'                   , {'type':'opt'}
" Pack 'godlygeek/tabular'                    , {'type':'opt'}
" Pack 'traap/vimwiki'                        , {'type':'opt'}
" Pack 'michal-h21/vim-zettel'                , {'type':'opt'}
" Pack 'ronakg/quickr-preview.vim'            , {'type':'opt'}


" Fuzzy find
" Pack 'junegunn/fzf.vim'                     , {'type':'opt'}
" Pack 'chengzeyi/fzf-preview.vim'            , {'type':'opt'}
" Pack 'Shougo/denite.nvim'                   , {'type':'opt', 'name': 'denite'}

" Autocomplete
" Pack 'neoclide/coc.nvim'                    , { 'type' : 'opt' } , {'branch' : 'release' }
" Pack 'Shougo/deoplete.nvim'                 , { 'type' : 'opt' }
" Pack 'deoplete-plugins/deoplete-dictionary' , { 'type' : 'opt' }

" Snipmate and its dependencies
" Pack 'garbas/vim-snipmate'                  , {'type':'opt'}
" Pack 'MarcWeber/vim-addon-mw-utils'         , {'type':'opt'}
" Pack 'tomtom/tlib_vim'                      , {'type':'opt'}


" Syntax
" Pack 'ap/vim-css-color'         , {'type':'opt'}

" Vimscript plugin helper
" Pack 'tpope/vim-scriptease'     , {'type':'opt'}
" Pack 'tweekmonster/startuptime.vim' , {'type':'opt'}

" Rust
" Pack 'rust-lang/rust.vim'       , {'type':'opt'}

" Javascript
" Pack 'yuezk/vim-js'             , {'type':'opt'}

" Ruby
" Pack 'tpope/vim-rails'          , {'type':'opt'}
" Pack 'vim-ruby/vim-ruby'        , {'type':'opt'}

" Python
" Pack 'numirias/semshi'          , {'type':'opt'}

" File manager
" Pack 'vifm/vifm.vim'            , {'type':'opt'}


" Themes
" Pack 'lifepillar/vim-solarized8', { 'type' : 'opt' }


" call plugpac#end()



" PackInstall: Install newly added plugins.(minpac#update())
" PackUpdate: Install or update plugins.(minpac#update())
" PackClean: Uninstall unused plugins.(minpac#clean())
" PackStatus: See plugins status.(minpac#status())
" PackDisable: Move a plugin to minpac/opt.
" (minpac#update would move plugin back to minpac/start, 
" unless the plugin is explicitly optional. Useful for disabling a plugin temporarily)

" ~/.config/nvim/pack/minpac/opt/*
" if &loadplugins
"   if has('packages')

    " myplugins
    " packadd files
    
    " packadd coc.nvim
    " packadd fzf.vim
    " packadd denite
    " packadd startuptime.vim
    " packadd tabular
    " packadd tlib_vim
    packadd vifm.vim
    " packadd quickr-preview.vim
    " packadd vim-addon-mw-utils
    " packadd vim-commentary
    " packadd vim-endwise
    " packadd vim-highlightedyank
    " packadd vim-unimpaired
    " packadd vim-ruby
    " packadd vim-scriptease
    " packadd vim-snipmate
    " packadd vim-zettel
    " packadd! vimwiki

    " runtime! config/minpac/coc.vim
    " runtime! config/minpac/commentary.vim
    " runtime! config/minpac/denite.vim
    " runtime! config/minpac/deoplete.vim
    " runtime! config/minpac/fzf.vim
    " runtime! config/minpac/netrw.vim
    " runtime! config/minpac/vifm.vim
    " runtime! config/minpac/vimwiki.vim

  " endif
" endif
