
syn match   timeFlag              '@.\{-}\(\s\{1}\|$\)'
syn match   additionalFlag        '#.\{-}\(\s\{1}\|$\)'

hi def link timeFlag              VimwikiHeader6 
hi def link additionalFlag        VimwikiHeader2

hi VimwikiCheckBoxDone guifg=#8BE9FD gui=italic
hi VimwikiHeader1 guifg=#FF00FF
hi VimwikiHeader2 guifg=#BD93F9
hi VimwikiHeader3 guifg=#00FFFF
hi VimwikiHeader4 guifg=#00FF00
hi VimwikiHeader5 guifg=#e67e22
hi VimwikiHeader6 guifg=#fc5d7c
