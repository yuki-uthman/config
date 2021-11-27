
" {{{ general

runtime OPT general.vim
runtime OPT mapping.vim
runtime OPT colors.vim

" }}}

" {{{ small scripts

runtime OPT cmdwin.vim
runtime OPT echo.vim
runtime OPT echo-highlight.vim

" runtime OPT minipairs.vim
runtime OPT pairs.vim
" runtime OPT autopairs.vim
runtime OPT cmdregisters.vim
runtime OPT words_search.vim
runtime OPT align.vim
runtime OPT rtp.vim

lua require 'utility'

" }}}

" {{{ github
runtime OPT commentary.vim
runtime OPT cutlass.vim
runtime OPT decho.vim
runtime OPT floaterm.vim
runtime OPT fzf.vim
" runtime OPT lightspeed.vim
" runtime OPT maximizer.vim
runtime OPT netrw.vim
runtime OPT tmux.vim
runtime OPT unimpaired.vim
runtime OPT vsnip.vim
runtime OPT easy-align.vim

" packadd vim-endwise
packadd vim-fugitive
packadd vim-surround
packadd vim-repeat
packadd targets.vim
packadd vim-cool
packadd vim-scriptease
packadd vim-textobj-user
packadd vim-textobj-url

" library
packadd vim-maktaba
" packadd float.nvim
" packadd vim-yuki-library

" auto comple
" runtime OPT cmp.vim
" runtime OPT lsp.vim
" runtime OPT wilder.vim

" treesitter
runtime OPT nvim-treesitter.vim

" packadd nvim-colorizer.lua
" lua require'colorizer'.setup()

" telescope
packadd plenary.nvim
packadd telescope.nvim
packadd telescope-fzf-native.nvim

lua require 'config.telescope.setup'
" lua require 'config.telescope.youtube'

nnoremap ,c <cmd>lua require('config.telescope').edit_neovim()<CR>
nnoremap ,g <cmd>lua require('config.telescope').grep_nvim_config()<CR>

" nnoremap H <cmd>lua require('config.telescope').help_grep()<CR>
nnoremap <leader>f <cmd>lua require('config.telescope').find_files()<CR>
nnoremap <leader>g <cmd>lua require('config.telescope').grep_string()<CR>
nnoremap <leader>c <cmd>lua require('config.telescope').colors()<CR>
" nnoremap " :Telescope neoclip<CR>

" learning lua
" packadd fzf-lua.local
" packadd fzf-action.local
" packadd nvim-fzf
" packadd nvim-lspfuzzy.local
" lua require('lspfuzzy').setup {}

lua require 'config.hop'

" }}}

" {{{ my plugin
runtime OPT n_flasher.vim
" runtime OPT vimpad.vim
runtime OPT fzf-dictionary.vim
runtime OPT fzf-define.vim
runtime OPT fzf-help.vim

packadd vim-scroller
packadd vim-star-flasher
packadd vim-cursor-flasher


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
    autocmd BufEnter *.vim doautocmd Filetype vim
    autocmd BufEnter *.vim runtime OPT lookup.vim
    autocmd BufEnter *.vim runtime OPT ftplugin/vim.vim
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
    autocmd BufEnter *.rb doautocmd Filetype markdown
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


