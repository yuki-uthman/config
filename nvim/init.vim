
" {{{ general
runtime OPT general.vim
runtime OPT mapping.vim
runtime OPT colors.vim
" }}}

" {{{ small scripts

runtime OPT cmdwin.vim
runtime OPT echo.vim
runtime OPT autopairs.vim
runtime OPT cmdregisters.vim
runtime OPT words_search.vim

lua require 'utility'

" }}}

" {{{ github
runtime OPT commentary.vim
runtime OPT cutlass.vim
runtime OPT decho.vim
runtime OPT floaterm.vim
runtime OPT fzf.vim
packadd fzf-lua
runtime OPT lightspeed.vim
runtime OPT maximizer.vim
runtime OPT netrw.vim
runtime OPT tmux.vim
runtime OPT unimpaired.vim
runtime OPT vsnip.vim

packadd vim-endwise
packadd vim-surround
packadd vim-repeat
packadd targets.vim
packadd vim-cool
packadd vim-scriptease
packadd vim-textobj-user
packadd vim-textobj-url

" auto complete
runtime OPT cmp.vim
runtime OPT lsp.vim
runtime OPT wilder.vim

" treesitter
runtime OPT nvim-treesitter.vim

packadd fzf-lsp.nvim
packadd nvim-lspfuzzy
lua require('lspfuzzy').setup {}

" }}}

" {{{ My plugin
runtime OPT n_flasher.vim
runtime OPT vimpad.vim
runtime OPT fzf-dictionary.vim

packadd vim-scroller
packadd vim-star-flasher
packadd vim-cursor-flasher


" offline
packadd buffers
packadd dictionary
packadd files
packadd float
packadd vim-maktaba
packadd vim-yuki-library
packadd zettel

" }}}

" {{{ ftplugin

augroup vim
    autocmd!
    autocmd Filetype vim runtime OPT autocmd/vim.vim
augroup END

augroup markdown
    autocmd!
    autocmd Filetype markdown runtime OPT autocmd/markdown.vim
augroup END

augroup lua
    autocmd!
    autocmd Filetype lua runtime OPT autocmd/lua.vim
augroup END

augroup ruby
    autocmd!
    autocmd Filetype ruby runtime OPT autocmd/ruby.vim
augroup END


" }}}


