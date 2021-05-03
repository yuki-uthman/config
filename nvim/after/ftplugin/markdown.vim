
setlocal linebreak
setlocal textwidth=80
setlocal fo+=t
setlocal fo-=l
setlocal conceallevel=2

inoremap ; :
inoremap : ;

runtime config/packs/markdown.vim
packadd vim-markdown
packadd goyo.vim

runtime config/packs/easy-align.vim
packadd vim-easy-align



