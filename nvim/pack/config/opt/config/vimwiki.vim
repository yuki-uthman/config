
let technology = { 'path': '~/VimWiki/technology' }
let progress = { 'path': '~/VimWiki/progress' } " visulize progress Quran LaunchSchool and others if any
let uia = { 'path': '~/VimWiki/uia', 'diary_header':'UIA', 'diary_sort': 'asc', 'diary_caption_level':1 }
let todo = { 'path': '~/VimWiki/todo', 'diary_header':'ToDo', 'diary_sort': 'asc', 'diary_caption_level':-1 }  " keep the daily todo lists


let g:vimwiki_list = [{'path':'~/.zettel/', 
                      \'ext': '.md', 
                      \'syntax':'markdown', 
                      \'links_space_char':'_'}, technology]

let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_dir_link = 'index'
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_listsyms = 'X🌒🌓🌔✓'
let g:vimwiki_folding = 'custom'


let g:vimwiki_filetypes = ['markdown', 'pandoc']

" Customize which mappings to apply
let g:vimwiki_key_mappings = { 'all_maps': 0, }

" let g:vimwiki_key_mappings =
"     \ {
"     \   'all_maps': 0,
"     \   'global': 0,
"     \   'headers': 0,
"     \   'text_objs': 0,
"     \   'table_format': 0,
"     \   'table_mappings': 0,
"     \   'lists': 0,
"     \   'links': 0,
"     \   'html': 0,
"     \   'mouse': 0,
"     \ }



" Vimwiki Diary

 " fix the calendar width
let g:calendar_options = 'nornu'
let g:calendar_mark = 'left-fit'
