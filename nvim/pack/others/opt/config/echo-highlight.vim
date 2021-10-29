"name"		the name of the syntax item
"fg"		foreground color (GUI: color name used to set
		" the color, cterm: color number as a string,
		" term: empty string)
"bg"		background color (as with "fg")
"font"		font name (only available in the GUI)
"sp"		special color (as with "fg") |highlight-guisp|
"fg#"		like "fg", but for the GUI and the GUI is running the name in "#RRGGBB" form
"bg#"		like "fg#" for "bg"
"sp#"		like "fg#" for "sp"
"bold"		"1" if bold
"italic"	"1" if italic
"reverse"	"1" if reverse
"inverse"	"1" if inverse (= reverse)
"standout"	"1" if standout
"underline"	"1" if underlined
"undercurl"	"1" if undercurled
"strikethrough"	"1" if struckthrough


function! s:echo_highlight() abort
  let id = synID(line('.'), col('.'), 1)

  let trans_id = synIDtrans(id)
  let @n = synIDattr(trans_id, 'name')
  let @b = synIDattr(trans_id, 'bg#')
  let @f = synIDattr(trans_id, 'fg#')

  let name = synIDattr(synID(line('.'), col('.'), 1), 'name')
  execute 'highlight' name
 
endfunc

nnoremap <leader>h <cmd>call <sid>echo_highlight()<CR>
