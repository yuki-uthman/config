
let g:airline_inactive_collapse=1
let g:airline#extensions#taboo#enabled = 1
let g:airline_section_c = '%t'

" remove the filetype part
let g:airline_section_x=''
let g:airline_section_y=''
let g:airline_section_z = '%{strftime("%a %d %b %H:%M")}'

" remove separators for empty sections
let g:airline_skip_empty_sections = 1

" Remember tab names when saving sessions
set sessionoptions+=tabpages,globals



"
