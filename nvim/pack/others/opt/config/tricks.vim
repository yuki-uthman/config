
" let s:default_path = escape(&path, '\ ') " store default value of 'path'

" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
" autocmd BufRead *
"       \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
"       \ exec "set path-=".s:tempPath |
"       \ exec "set path-=".s:default_path |
"       \ exec "set path^=".s:tempPath |
"       \ exec "set path^=".s:default_path
" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file#Mapping_or_command_for_quick_directory_change

