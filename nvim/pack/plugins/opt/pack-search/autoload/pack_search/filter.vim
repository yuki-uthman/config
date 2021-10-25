
fu! s:CreateNvimUi(internal_buffer) abort
  let buf = nvim_create_buf(1, 0)
  call nvim_buf_set_name(buf, 'ps_filter')

  call nvim_buf_set_option(buf, 'bufhidden', 'delete')
  call nvim_buf_set_option(buf, 'buftype', 'nofile')
  call nvim_buf_set_option(buf, 'modifiable', v:true)

  let height     = float2nr(&lines * g:any_jump_window_height_ratio)
  let width      = float2nr(&columns * g:any_jump_window_width_ratio)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical   = g:any_jump_window_top_offset

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal',
        \ }

  let winid = nvim_open_win(buf, v:true, opts)

  " Set filetype after window appearance for proper event propagation
  call nvim_buf_set_option(buf, 'filetype', 'ps')

  call nvim_win_set_option(winid, 'number', v:false)
  call nvim_win_set_option(winid, 'wrap', v:false)

  let t:any_jump.vim_bufnr = buf

  " [RenderUi](~/.config/nvim/pack/mine/opt/any-jump.clone/autoload/internal_buffer.vim:554)
  call t:any_jump.RenderUi()
  call t:any_jump.JumpToFirstOfType('link', 'definitions')
endfu



function! pack_search#filter#open()
  " float open one liner
  " return the filter object
  " what should the filter object contain?
  " winner()
  " bufnr()
endfunction
