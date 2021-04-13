
" If you don't like a particular colour choice from, you can
" override it here. For example, to change the colour of the search hightlight:
" hi Search guifg=#bada55 guibg=#000000 gui=bold ctermfg=green ctermbg=black cterm=bold

" If you don't know what the name of a particular hightlight is, you can use
" `What`. It will print out the syntax group that the cursor is currently above.
" from https://www.reddit.com/r/vim/comments/6z4aau/how_to_stop_vim_from_autohighlighting_italics_in/
command! What echo synIDattr(synID(line('.'), col('.'), 1), 'name')

" highligh IncSearch term=reverse ctermfg=180 ctermbg=59 guifg=#E5C07B guibg=#5C6370
" highligh Search term=reverse ctermfg=235 ctermbg=180 guifg=#282C34 guibg=#E5C07B
" highlight MatchParen term=bold ctermfg=235 ctermbg=114 guifg=#282C34

