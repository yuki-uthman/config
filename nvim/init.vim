
" {{{ general

runtime OPT general.vim
runtime OPT mapping.vim
runtime OPT colors.vim

" }}}

" {{{ small scripts

runtime OPT cmdwin.vim
runtime OPT echo.vim
runtime OPT echo-highlight.vim

" runtime OPT cmdregisters.vim
runtime OPT words_search.vim
runtime OPT align.vim
runtime OPT rtp.vim
runtime OPT vroom.vim
runtime OPT rg.vim

lua require 'utility'

" }}}

" {{{ plugins
runtime OPT commentary.vim
runtime OPT codi.vim
runtime OPT cutlass.vim
runtime OPT decho.vim
runtime OPT floaterm.vim
runtime OPT fzf.vim
runtime OPT netrw.vim
runtime OPT tmux.vim
runtime OPT vsnip.vim
runtime OPT easy-align.vim
runtime OPT due.vim
runtime OPT emmet.vim

packadd quickfix-reflector.vim
packadd targets.vim
packadd vim-cool
packadd vim-fugitive
packadd vim-repeat
packadd vim-scriptease
packadd vim-surround
" packadd vim-textobj-url
packadd vim-textobj-user
packadd vim-unimpaired
packadd vim-better-whitespace
packadd vim-prettier

" auto pairs
" runtime OPT minipairs.vim
" runtime OPT pairs.vim
" runtime OPT autopairs.vim
lua require 'config.pairz'

" auto complete
runtime OPT coc.vim
" runtime OPT cmp.vim
" runtime OPT wilder.vim
runtime OPT lsp.vim

" treesitter
runtime OPT nvim-treesitter.vim

" packadd nvim-colorizer.lua
" lua require'colorizer'.setup()

runtime OPT hop.vim
runtime OPT n_flasher.vim
runtime OPT cursor_flasher.vim
runtime OPT vimpad.vim

packadd jest.nvim
packadd vim-scroller
packadd vim-star-flasher

" library
packadd vim-maktaba
packadd float.nvim
packadd vim-yuki-library

" offline
packadd buffers
packadd dictionary
packadd files
packadd zettel.nvim

" }}}

" {{{ ftplugin

augroup vim
    autocmd!
    " with autocmd Filetype -> you cannot control the order
    " autocmd Filetype vim runtime OPT lookup.vim
    " autocmd Filetype vim runtime OPT autocmd/vim.vim
    " lookup.vim -> autocmd/vim.vim -> ftplugin/vim.vim

    " with autocmd BufEnter -> you can control the order
    autocmd BufEnter *.vim doautocmd Filetype vim " default ftplugin/vim.vim
    autocmd BufEnter *.vim runtime OPT lookup.vim
    autocmd BufEnter *.vim runtime OPT ftplugin/vim.vim " custom ftplugin/vim.vim
    " autocmd BufEnter *.vim lua require 'lsp.vim'

    " ftplugin/vim.vim -> lookup.vim -> autocmd/vim.vim
augroup END

augroup lua
    autocmd!
    " plugin syntax file should be loaded before doing the doautocmd Filetype
    " autocmd BufEnter *.lua packadd vim-lua
    autocmd BufEnter *.lua packadd BetterLua.vim
    autocmd BufEnter *.lua doautocmd Filetype lua
    autocmd BufEnter *.lua runtime OPT ftplugin/lua.vim
    " autocmd BufEnter *.lua lua require 'lsp.lua'

    " to override some of the syntax highlighting
    autocmd BufEnter *.lua runtime OPT syntax/lua.vim
augroup END

augroup ruby
    autocmd!
    autocmd BufEnter *.rb doautocmd Filetype ruby
    autocmd BufEnter *.rb runtime OPT ftplugin/ruby.vim
augroup END

augroup markdown
    autocmd!
    autocmd BufEnter *.md doautocmd Filetype markdown
    autocmd BufEnter *.md runtime OPT ftplugin/markdown.vim
    autocmd BufEnter *.md runtime OPT fzf-thesaurus.vim
    " autocmd BufEnter *.md lua require 'config.markdown'
augroup END


" }}}


