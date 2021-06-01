
setlocal linebreak
setlocal textwidth=80
setlocal fo=want
setlocal conceallevel=2

inoremap <buffer> ; :
inoremap <buffer> : ;

runtime config/packs/markdown.vim
packadd vim-markdown
packadd goyo.vim

runtime config/packs/easy-align.vim
packadd vim-easy-align



