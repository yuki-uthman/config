
setlocal linebreak
setlocal textwidth=80
setlocal fo+=t
setlocal fo-=l
setlocal conceallevel=2

inoremap ; :
inoremap : ;

runtime config/packs/markdown.vim
packadd goyo.vim
