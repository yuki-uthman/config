
setlocal linebreak
setlocal textwidth=80
setlocal fo+=t
setlocal fo-=l

lua require'cmp'.setup.buffer {
\   completion = {
\     autocomplete = false
\   },
\   sources = {
\     { name = 'buffer' },
\     { name = 'look' },
\   },
\ }
