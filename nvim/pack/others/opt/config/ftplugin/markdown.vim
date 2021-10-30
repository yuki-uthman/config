
for char in split('abcdefghijklmnopqrstuvwxyz', '\zs')
    exe printf("inoremap <expr> %s search('[.!?]\\_s\\+\\%%#', 'bcnw') ? '%s' : '%s'", char, toupper(char), char)
endfor

for char in split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '\zs')
    exe printf("inoremap <expr> %s search('[.!?]\\_s\\+\\%%#', 'bcnW') ? '%s' : '%s'", char, tolower(char), char)
endfor

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

