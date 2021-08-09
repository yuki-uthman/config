

function! s:default_float_options() "{{{
  let ui = nvim_list_uis()[0]
  let height = float2nr(ui.height * 0.8)
  let width = float2nr(ui.width * 0.8)

  let x = float2nr((ui.width - width) * 0.5)
  let y = float2nr((ui.height - height) * 0.5)

  let x = 0
  let y = 0

  let default_opts = {
        \ 'relative': 'editor',
        \ 'row': y,
        \ 'col': x,
        \ 'width': width,
        \ 'height': height,
        \ 'anchor': 'NW',
        \ 'style': 'minimal',
        \ 'focusable': v:true,
        \ 'border': 'none',
        \ }
  return default_opts
endfunction "}}}

function! s:default_buf_options()
  return {}
endfunction

function! s:default_win_options()
  return {}
endfunction

function! yuki#float#create(...) abort "{{{

  let float = {
        \'open': function('s:open'),
        \'_float_options': s:default_float_options(),
        \'float_options': function('yuki#float#float_options'),
        \'_win_options': s:default_win_options(),
        \'win_options': function('yuki#float#win_options'),
        \'_buf_options': s:default_buf_options(),
        \'buf_options': function('yuki#float#buf_options'),
        \}

  let scratch = {
        \'_scratch' : 0,
        \'as_scratch': function('s:as_scratch'),
        \}
  call extend(float, scratch)

  let buf_name = {
        \'_buf_name': '',
        \'buf_name': function('s:set_buf_name'),
        \}
  call extend(float, buf_name)

  let border = {
        \'_border' : 0,
        \'border': function('yuki#float#border')
        \}
  call extend(float, border)

  let sizing = {
        \'_height': function('s:get_height'),
        \'_width': function('s:get_width'),
        \'height': function('yuki#float#height'),
        \'width': function('yuki#float#width'),
        \'height_of': function('s:height_of'),
        \'width_of': function('s:width_of'),
        \'size': function('yuki#float#size'),
        \'taller': function('s:taller'),
        \'wider': function('s:wider'),
        \'adjust_size': function('s:adjust_size'),
        \}
  call extend(float, sizing)

  let positioning = {
        \'up': function('yuki#float#up'),
        \'down': function('yuki#float#down'),
        \'right': function('yuki#float#right'),
        \'left': function('yuki#float#left'),
        \'center': function('yuki#float#center'),
        \}
  call extend(float, positioning)

  let aligning = {
        \'align_top': function('yuki#float#align_top'),
        \'align_bottom': function('yuki#float#align_bottom'),
        \'align_right': function('yuki#float#align_right'),
        \'align_left': function('yuki#float#align_left'),
        \}
  call extend(float, aligning)

  let on = {
        \'on_top_of': function('yuki#float#on_top_of'),
        \'on_bottom_of': function('yuki#float#on_bottom_of'),
        \'on_right_of': function('yuki#float#on_right_of'),
        \'on_left_of': function('yuki#float#on_left_of'),
        \}
  call extend(float, on)

  let stacking = {
        \'_floats' : [],
        \'add_float': function('s:add_float'),
        \'stack_top': function('yuki#float#stack_top'),
        \'stack_bottom': function('yuki#float#stack_bottom'),
        \'stack_right': function('yuki#float#stack_right'),
        \'stack_left': function('yuki#float#stack_left'),
        \}
  call extend(float, stacking)

  return float
endfunction "}}}

function! s:open(...) dict abort "{{{
  if a:0 > 1
    throw maktaba#error#Message('BadArguments', 
          \'%s only accepts 1 argument', 
          \ yuki#function#name(expand('<sfile>')))

  elseif maktaba#value#IsEqual(a:0, 1)
    call maktaba#ensure#IsString(a:1)
  endif

" [nvim_create_buf](/usr/local/Cellar/neovim/0.5.0/share/nvim/runtime/doc/api.txt:645)
" nvim_create_buf({listed}, {scratch})
  let bufnr = nvim_create_buf(1, self._scratch)
  let self.bufnr = bufnr

  if !yuki#value#IsEmpty(self._buf_name)
    call nvim_buf_set_name(bufnr, self._buf_name)
  endif

  if !yuki#value#IsEmpty(self._buf_options)
    for [key, value] in items(self._buf_options)
      call nvim_buf_set_option(bufnr, key, value)
    endfor
  endif

  let winid = nvim_open_win(bufnr, v:true, self._float_options)
  let self.winid = winid

  let floats = []
  " open all the floats inside _floats list
  " add back the opened float object back to self
  if !yuki#value#IsEmpty(self._floats)
    for float in self._floats
      call add(floats, float.open())
    endfor
    let self._floats = floats
  endif

  if maktaba#value#IsEqual(a:0, 1)
    exec 'silent edit ' . expand(a:1)
  endif

  if !yuki#value#IsEmpty(self._win_options)
    for [key, value] in items(self._win_options)
      call nvim_win_set_option(winid, key, value)
    endfor
  endif

  return self
endfunction "}}}

"{{{ other options: buf_name scratch border

function! s:set_buf_name(name) dict abort
  call maktaba#ensure#IsString(a:name)

  let self._buf_name = a:name
  return self
endfunction

function! s:as_scratch() dict abort
  let self._scratch = 1
  return self
endfunction

function! yuki#float#border(style) dict abort
  call maktaba#ensure#IsIn(a:style, ['single', 'double', 'rounded','solid', 'shadow', 'none'])

  if maktaba#value#IsIn(a:style, ['single', 'double', 'rounded','solid', 'shadow'])
    let self._border = 1
  elseif maktaba#value#IsEqual(a:style, 'none')
    let self._border = 0
  endif

  let self._float_options.border = a:style
  return self
endfunction

"}}}

"{{{ sizing

function! s:get_height() dict abort
" when aligning, the border should be accounted for calculation
" but the getwininfo do not inlcude the border height
  " let border = self._float_options.border
  if self._border
    return self._float_options.height + 2
  else
    return self._float_options.height
  endif
endfunction

function! s:get_width() dict abort
" when aligning, the border should be accounted for calculation
" but the getwininfo do not inlcude the border width
  " let border = self._float_options.border
  if self._border
  " if maktaba#value#IsIn(border, ['single', 'double', 'solid', 'shadow'])
    return self._float_options.width + 2
  else
    return self._float_options.width
  endif
endfunction

function! yuki#float#height(numeric) dict abort
  call maktaba#ensure#IsNumeric(a:numeric)

  if maktaba#value#IsNumber(a:numeric)
    let self._float_options.height = a:numeric
  elseif maktaba#value#IsFloat(a:numeric)
    let self._float_options.height = yuki#nvim_uis#height(a:numeric)
  endif

  return self
endfunction

function! yuki#float#width(numeric) dict abort
  call maktaba#ensure#IsNumeric(a:numeric)

  if maktaba#value#IsNumber(a:numeric)
    let self._float_options.width = a:numeric
  elseif maktaba#value#IsFloat(a:numeric)
    let self._float_options.width = yuki#nvim_uis#width(a:numeric)
  endif

  return self
endfunction

function! yuki#float#size(...) dict abort

  let new_self = {}
  if maktaba#value#IsEqual(a:0, 1)
    call maktaba#value#IsFloat(a:1)
    let new_self = self.height(a:1).width(a:1)

  elseif maktaba#value#IsEqual(a:0, 2)
    call maktaba#value#IsNumeric(a:1)
    call maktaba#value#IsNumeric(a:2)
    let new_self = self.height(a:1).width(a:2)

  else
    throw maktaba#error#Message("BadArguments", 
          \"yuki#float#size needs 1 or 2 arguments only")
  endif

  return new_self
endfunction

function! s:height_of(...) dict abort

  " first arg should be a float obj
  call maktaba#ensure#IsDict(a:1)
  let another_float = a:1

  " second arg should be a float
  let percentage = 1
  if maktaba#value#IsEqual(a:0, 2)
    call maktaba#ensure#IsFloat(a:2)
    let percentage = a:2
  endif

  " do not use _height() because the border will be added later
  let self._float_options.height = float2nr(another_float._float_options.height * percentage )

  return self
endfunction

function! s:width_of(...) dict abort

  " first arg should be a float obj
  call maktaba#ensure#IsDict(a:1)
  let another_float = a:1

  " second arg should be a float
  let percentage = 1
  if maktaba#value#IsEqual(a:0, 2)
    call maktaba#ensure#IsFloat(a:2)
    let percentage = a:2
  endif

  " do not use _width() because the border will be added later
  let self._float_options.width = float2nr(another_float._float_options.width * percentage )
  return self
endfunction

function! s:taller(number) dict abort
  call maktaba#ensure#IsNumber(a:number)
  let self._float_options.height += a:number
  return self
endfunction

function! s:wider(number) dict abort
  call maktaba#ensure#IsNumber(a:number)
  let self._float_options.width += a:number
  return self
endfunction

function! s:adjust_size(height, width) dict abort

  call maktaba#ensure#IsNumber(a:height)
  call maktaba#ensure#IsNumber(a:width)

  let new_self = self.taller(a:height).wider(a:width)

"   let self._float_options.height += a:height
"   let self._float_options.width += a:width

  return new_self
endfunction


"}}}

"{{{ positioning
function! yuki#float#up(offset) dict abort
  call maktaba#ensure#IsNumeric(a:offset)

  let offset = 0
  if maktaba#value#IsNumber(a:offset)
    let offset = a:offset
  elseif maktaba#value#IsFloat(a:offset)
    let offset = yuki#nvim_uis#row(self._height(), a:offset)
  endif

  let self._float_options.row -= offset

  if !yuki#value#IsEmpty(self._floats)
    for float in self._floats
      let float._float_options.row -= offset
    endfor
  endif

  return self
endfunction

function! yuki#float#down(offset) dict abort
  call maktaba#ensure#IsNumeric(a:offset)

  let offset = 0
  if maktaba#value#IsNumber(a:offset)
    let offset = a:offset
  elseif maktaba#value#IsFloat(a:offset)
    let offset = yuki#nvim_uis#row(self._height(), a:offset)
  endif

  let self._float_options.row += offset

  if !yuki#value#IsEmpty(self._floats)
    for float in self._floats
      let float._float_options.row += offset
    endfor
  endif

  return self
endfunction

function! yuki#float#right(offset) dict abort
  call maktaba#ensure#IsNumeric(a:offset)

  let offset = 0
  if maktaba#value#IsNumber(a:offset)
    let offset = a:offset
  elseif maktaba#value#IsFloat(a:offset)
    let offset = yuki#nvim_uis#col(self._width(), a:offset)
  endif

  let self._float_options.col += offset

  if !yuki#value#IsEmpty(self._floats)
    for float in self._floats
      let float._float_options.col += offset
    endfor
  endif

  return self
endfunction

function! yuki#float#left(offset) dict abort
  call maktaba#ensure#IsNumeric(a:offset)

  let offset = 0
  if maktaba#value#IsNumber(a:offset)
    let offset = a:offset
  elseif maktaba#value#IsFloat(a:offset)
    let offset = yuki#nvim_uis#col(self._width(), a:offset)
  endif

  let self._float_options.col -= offset

  if !yuki#value#IsEmpty(self._floats)
    for float in self._floats
      let float._float_options.col -= offset
    endfor
  endif

  return self
endfunction

function! yuki#float#center() dict abort
  return self.align_top().align_left().right(0.5).down(0.5)
endfunction


"}}}

"{{{ aligning

function! yuki#float#align_top(...) dict abort
  if a:0 == 0
    let self._float_options.row = 0

  elseif a:0 == 1
    call maktaba#ensure#IsDict(a:1)
    let self._float_options.row = a:1._float_options.row

  elseif a:0 == 2
    call maktaba#ensure#IsDict(a:1)
    call maktaba#ensure#IsIn(a:2, ['top', 'bottom'])

    if maktaba#value#IsEqual(a:2, 'bottom')
      let self._float_options.row = a:1._float_options.row + a:1._height()
    else
      " aligning the top with top is the same as just align_top(box1)
      let self._float_options.row = a:1._float_options.row
    endif


  else
    throw maktaba#error#Message("ExtraArgument", "Only 2 argument is allowed for %s", "yuki#float#align_top")
  endif
  return self
endfunction

function! yuki#float#align_bottom(...) dict abort
  if a:0 == 0
    let ui_height = nvim_list_uis()[0].height
    let self._float_options.row = ui_height - self._height() - 1

  elseif a:0 == 1
    call maktaba#ensure#IsDict(a:1)

    let ref_row = a:1._float_options.row
    let ref_height = a:1._height()

    let self._float_options.row = ref_row + ref_height - self._height()

  elseif a:0 == 2
    call maktaba#ensure#IsDict(a:1)
    call maktaba#ensure#IsIn(a:2, ['top', 'bottom'])

    if maktaba#value#IsEqual(a:2, 'top')
      let self._float_options.row = a:1._float_options.row - self._height()
    else
      " aligning the bottom with bottom is the same as just align_bottom(box1)
      let self._float_options.row = a:1._float_options.row
    endif

  else
    throw maktaba#error#Message("ExtraArgument", "Only 2 argument is allowed for %s", "yuki#float#align_bottom()")
  endif
  return self
endfunction

function! yuki#float#align_left(...) dict abort
  if a:0 == 0
    let self._float_options.col = 0

  elseif a:0 == 1
    call maktaba#ensure#IsDict(a:1)
    let self._float_options.col = a:1._float_options.col

  elseif a:0 == 2
    call maktaba#ensure#IsDict(a:1)
    call maktaba#ensure#IsIn(a:2, ['right', 'left'])

    if maktaba#value#IsEqual(a:2, 'right')
      let self._float_options.col = a:1._float_options.col + a:1._width()
    else
      " aligning the left with left is the same as just align_left(box1)
      let self._float_options.col = a:1._float_options.col
    endif
    " throw maktaba#error#Message("NotImplemented", "yuki#float#left({},{})")
  else
    throw maktaba#error#Message("ExtraArgument", "Only 2 argument is allowed for %s", "yuki#float#align_left()")
  endif
  return self
endfunction

function! yuki#float#align_right(...) dict abort
  if a:0 == 0
    let ui_width = nvim_list_uis()[0].width
    let float_width = self._float_options.width

    let self._float_options.col = ui_width - float_width

  elseif a:0 == 1
    call maktaba#ensure#IsDict(a:1)

    let ref_col = a:1._float_options.col
    let ref_width = a:1._width()

    let self._float_options.col = ref_col + ref_width - self._width()

  elseif a:0 == 2
    call maktaba#ensure#IsDict(a:1)
    call maktaba#ensure#IsIn(a:2, ['right', 'left'])

    if maktaba#value#IsEqual(a:2, 'left')
      let self._float_options.col = a:1._float_options.col - self._width()
    else
      " aligning the right with right is the same as just align_right(box1)
      let self._float_options.col = a:1._float_options.col
    endif
    " throw maktaba#error#Message("NotImplemented", "yuki#float#left({},{})")
  else
    throw maktaba#error#Message("ExtraArgument", "Only 2 argument is allowed")
  endif

  return self
endfunction



"}}}

"{{{ on

function! yuki#float#on_top_of(another_float) dict abort
  let self._float_options.row = a:another_float._float_options.row - self._height()

  " align the horizontal position of the window
  let self._float_options.col = a:another_float._float_options.col

  " if there is border on either of the window center it horizontally
  if a:another_float._border && self._border
    " if both have borders no adjustments needed
  elseif a:another_float._border
    let self._float_options.col += 1
  elseif self._border
    let self._float_options.col -= 1
  endif
  return self
endfunction

function! yuki#float#on_bottom_of(another_float) dict abort
  let self._float_options.row = a:another_float._float_options.row + a:another_float._height()

  " align the horizontal position of the window
  let self._float_options.col = a:another_float._float_options.col

  " if there is border on either of the window center it horizontally
  if a:another_float._border && self._border
    " if both have borders no adjustments needed
  elseif a:another_float._border
    let self._float_options.col += 1
  elseif self._border
    let self._float_options.col -= 1
  endif
  return self
endfunction

function! yuki#float#on_right_of(another_float) dict abort
  let self._float_options.col = 
        \a:another_float._float_options.col + a:another_float._width()

  " align the horizontal position of the window
  let self._float_options.row = a:another_float._float_options.row

  " if there is border on either of the window center it horizontally
  if a:another_float._border && self._border
    " if both have borders no adjustments needed
  elseif a:another_float._border
    let self._float_options.row += 1
  elseif self._border
    let self._float_options.row -= 1
  endif
  return self
endfunction

function! yuki#float#on_left_of(another_float) dict abort
  let self._float_options.col = 
        \a:another_float._float_options.col - self._width()

  " align the horizontal position of the window
  let self._float_options.row = a:another_float._float_options.row

  " if there is border on either of the window center it horizontally
  if a:another_float._border && self._border
    " if both have borders no adjustments needed
  elseif a:another_float._border
    let self._float_options.row += 1
  elseif self._border
    let self._float_options.row -= 1
  endif
  return self
endfunction



"}}}

"{{{ stacking

function! s:add_float(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  call add(self._floats, a:another_float)
  return self
endfunction

function! yuki#float#stack_top(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  let float = a:another_float

  let float._float_options.row = self._float_options.row - float._height()
  let float._float_options.col = self._float_options.col

  return self.add_float(float)
endfunction


function! yuki#float#stack_bottom(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  let float = a:another_float

  let float._float_options.col = self._float_options.col
  let float._float_options.row = self._float_options.row + self._height()

  return self.add_float(float)
endfunction

function! yuki#float#stack_right(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  let float = a:another_float

  let float._float_options.row = self._float_options.row
  let float._float_options.col = self._float_options.col + self._width()

  return self.add_float(float)
endfunction

function! yuki#float#stack_left(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  let float = a:another_float

  let float._float_options.row = self._float_options.row
  let float._float_options.col = self._float_options.col - float._width()

  return self.add_float(float)
endfunction


"}}}


function! yuki#float#float_options(options) dict abort
  call maktaba#ensure#IsDict(a:options)
  call extend(self._float_options, a:options)
  return self
endfunction

function! yuki#float#buf_options(options) dict abort
  call maktaba#ensure#IsDict(a:options)
  call extend(self._buf_options, a:options)
  return self
endfunction

function! yuki#float#win_options(options) dict abort
  call maktaba#ensure#IsDict(a:options)
  call extend(self._win_options, a:options)
  return self
endfunction

" [TODO](2108090603)
