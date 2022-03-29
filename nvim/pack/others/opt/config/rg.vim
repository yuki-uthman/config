
command! -nargs=+ -complete=dir -bar Grep lua require 'rg'.asyncGrep(<q-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'

