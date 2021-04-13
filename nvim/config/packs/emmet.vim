
" enable emmet just for normal and visual mode
let g:user_emmet_mode='a'

" type ,, to trigger the expansion
let g:user_emmet_leader_key=';'

" switched the expansion to ; and ,

" enable emmet just for some files
let g:user_emmet_install_global = 0
autocmd FileType html,css,eruby,scss EmmetInstall
