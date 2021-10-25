
function! float#edit(filename, window) abort "{{{
  let ui = nvim_list_uis()[0]
  let height = float2nr(ui.height * a:window.height)
  let width = float2nr(ui.width * a:window.width)

  let x = float2nr((ui.width - width) * a:window.x)
  let y = float2nr((ui.height - height) * a:window.y)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': y,
        \ 'col': x,
        \ 'width': width,
        \ 'height': height,
        \ 'anchor': 'NW',
        \ 'style': 'minimal',
        \ 'focusable': v:true,
        \ 'border': "single",
        \ }

  " let bufnr = bufadd(a:filename)
  let bufnr = nvim_create_buf(v:false, v:true)
  let winid = nvim_open_win(bufnr, v:true, opts)
  exec "edit " . a:filename

  return {'bufnr': bufnr, 'winid': winid, 'height': height, 'width': width}
endfunction "}}}

" let window = {'y': 0, 'x': 1, 'height': 0.5, 'width': 0.25}
" let file = expand("~/.zettel/test1.md")
" let float = float#edit(file, window)
" echo float
" [TODO](2107211007)
