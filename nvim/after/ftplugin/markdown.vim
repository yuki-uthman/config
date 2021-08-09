
let g:markdown_fenced_languages = [
      \ 'css', 
      \ 'bash', 
      \ 'erb=eruby', 
      \ 'javascript', 
      \ 'js=javascript', 
      \ 'json=javascript', 
      \ 'ruby', 
      \ 'sass', 
      \ 'xml', 
      \ 'html',
      \ ]

let g:markdown_syntax_conceal = 1

setlocal linebreak
setlocal textwidth=80
setlocal fo=want
setlocal conceallevel=2

runtime config/packs/goyo.vim
packadd goyo.vim

runtime config/packs/medieval.vim
packadd vim-medieval
