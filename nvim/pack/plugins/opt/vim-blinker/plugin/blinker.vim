" Modified version of Damian Conway's Die Blinkënmatchen: highlight matches
"
" This is how long you want the blinking to last in milliseconds. If you're
" using an earlier Vim without the `+timers` feature, you need a much shorter
" blink time because Vim blocks while it waits for the blink to complete.
let s:blink_length = has("timers") ? 500 : 100

if has("timers")
  " This is the length of each blink in milliseconds. If you just want an
  " interruptible non-blinking highlight, set this to match s:blink_length
  " by uncommenting the line below
  let s:blink_freq = 100
  "let s:blink_freq = s:blink_length
  let s:blink_match_id = 0
  let s:blink_timer_id = 0
  let s:blink_stop_id = 0

  " Toggle the blink highlight. This is called many times repeatedly in order
  " to create the blinking effect.
  function! BlinkToggle(timer_id)
    if s:blink_match_id > 0
      " Clear highlight
      call BlinkClear()
    else
      " Set highlight
      let s:blink_match_id = matchadd('IncSearch', s:target_pat, 101)
      redraw
    endif
  endfunction

  " Remove the blink highlight
  function! BlinkClear()
    call matchdelete(s:blink_match_id)
    let s:blink_match_id = 0
    redraw
  endfunction

  " Stop blinking
  "
  " Cancels all the timers and removes the highlight if necessary.
  function! BlinkStop(timer_id)
    " Cancel timers
    if s:blink_timer_id > 0
      call timer_stop(s:blink_timer_id)
      let s:blink_timer_id = 0
    endif
    if s:blink_stop_id > 0
      call timer_stop(s:blink_stop_id)
      let s:blink_stop_id = 0
    endif
    " And clear blink highlight
    if s:blink_match_id > 0
      call BlinkClear()
    endif
  endfunction

  augroup die_blinkmatchen
    autocmd!
    autocmd CursorMoved * call BlinkStop(0)
    autocmd InsertEnter * call BlinkStop(0)
  augroup END
endif

function! HLNext(blink_length, blink_freq)
  let s:target_pat = '\c\%#'.@/
  if has("timers")
    " Reset any existing blinks
    call BlinkStop(0)
    " Start blinking. It is necessary to call this now so that the match is
    " highlighted initially (in case of large values of a:blink_freq)
    call BlinkToggle(0)
    " Set up blink timers.
    let s:blink_timer_id = timer_start(a:blink_freq, 'BlinkToggle', {'repeat': -1})
    let s:blink_stop_id = timer_start(a:blink_length, 'BlinkStop')
  else
    " Vim doesn't have the +timers feature. Just use Conway's original
    " code.
    " Highlight the match
    let ring = matchadd('ErrorMsg', s:target_pat, 101)
    redraw
    " Wait
    exec 'sleep ' . a:blink_length . 'm'
    " Remove the highlight
    call matchdelete(ring)
    redraw
  endif
endfunction

" Set up maps for n and N that blink the match
execute printf("nnoremap <silent> n n:call HLNext(%d, %d)<cr>", s:blink_length, has("timers") ? s:blink_freq : s:blink_length)
execute printf("nnoremap <silent> N N:call HLNext(%d, %d)<cr>", s:blink_length, has("timers") ? s:blink_freq : s:blink_length)


"{{{
" function! star_flasher#normal()
"   call s:star_flasher('n')
" endfunction

" function! star_flasher#visual()
"   call s:star_flasher('v')
" endfunction

function! s:get_visual_selection() "{{{
  let [l:lnum1, l:col1] = getpos("'<")[1:2]
  let [l:lnum2, l:col2] = getpos("'>")[1:2]
  if &selection !=# 'inclusive'
    let l:col2 -= 1
  endif
  let l:lines = getline(l:lnum1, l:lnum2)
  if !empty(l:lines)
    let l:lines[-1] = l:lines[-1][: l:col2 - 1]
    let l:lines[0] = l:lines[0][l:col1 - 1 : ]
  endif
  return join(l:lines, "\n")
endfunction " }}}

function! s:delete_matches(timer) "{{{

  if !empty(s:star_flasher_match_ids.on)
    let winid = s:star_flasher_match_ids.on.winid
    let match_id = s:star_flasher_match_ids.on.match
    call matchdelete(match_id, winid)
  endif

  if !empty(s:star_flasher_match_ids.off)
    let winid = s:star_flasher_match_ids.off.winid
    let match_id = s:star_flasher_match_ids.off.match
    call matchdelete(match_id, winid)
  endif


"   while !empty(s:star_flasher_match_ids)
"     let match = remove(s:star_flasher_match_ids, 0)
"     let windowID = match[0]
"     let matchID = match[1]

"     try
"       call matchdelete(matchID, windowID)
"     endtry
"   endwhile

  let s:star_flasher_match_ids = {'on': {}, 'off':{}}

endfunction "}}}

function! s:stop_all_timers(timer_id) "{{{

  if !exists('s:toggle_timer_id')
    let s:toggle_timer_id = 0
  endif

  if !exists('s:toggle_stop_id')
    let s:toggle_stop_id = 0
  endif

  " Cancel timers
  if s:toggle_timer_id > 0
    call timer_stop(s:toggle_timer_id)
    let s:toggle_timer_id = 0
  endif
  if s:toggle_stop_id > 0
    call timer_stop(s:toggle_stop_id)
    let s:toggle_stop_id = 0
  endif
  " And clear blink highlight
  if !empty(s:star_flasher_match_ids)
    call s:delete_matches(0)
  endif
endfunction "}}}

function! s:flash_toggle(timer_id) "{{{
  let winid = win_getid()

  if empty(s:star_flasher_match_ids.on) && empty(s:star_flasher_match_ids.off)
    echom 'turning on first time'
    let id = matchaddpos(s:param.hl_on, [s:flash_pos], 11) 

    let s:star_flasher_match_ids.on.match = id
    let s:star_flasher_match_ids.on.winid = winid

    echom s:star_flasher_match_ids

    echom 'turned on first time'
  elseif empty(s:star_flasher_match_ids.on)
    echom 'turning on'

    call matchdelete(s:star_flasher_match_ids.off.match, s:star_flasher_match_ids.off.winid)
    let s:star_flasher_match_ids.off = {}

    let id = matchaddpos(s:param.hl_on, [s:flash_pos], 11) 

    let s:star_flasher_match_ids.on.match = id
    let s:star_flasher_match_ids.on.winid = winid

    echom s:star_flasher_match_ids



    echom 'turned on'
  elseif empty(s:star_flasher_match_ids.off)
    echom 'turning off'

    call matchdelete(s:star_flasher_match_ids.on.match, s:star_flasher_match_ids.on.winid)
    let s:star_flasher_match_ids.on = {}


    let id = matchaddpos(s:param.hl_off, [s:flash_pos], 11) 

    let s:star_flasher_match_ids.off.match = id
    let s:star_flasher_match_ids.off.winid = winid

    echom s:star_flasher_match_ids


    echom 'turned off'
  endif

endfunction "}}}

function! s:put_in_search_reg(mode) "{{{
  let text = ''
  if a:mode ==# 'n'
    let text = expand('<cword>')
    let @/ = '\<'. text .'\>'

  elseif a:mode ==# 'v'
    let text = s:get_visual_selection()

    " escape dot
    let text = substitute(text, '\.', '\\.', "")
    let @/ = text
  endif

  " add the text to search history
  call histadd('/', @/)

  return text
endfunction "}}}

function! s:is_beginning_of_word() abort "{{{
  let pos = getpos('.')
  normal! bw
  if pos == getpos('.')
    return v:true
  else
    call setpos('.', pos)
    return v:false
  endif
endfunction "}}}

function! s:get_flash_pos(mode) "{{{
  let to_return = []
  if a:mode ==# 'n' && !s:is_beginning_of_word()
    let save_pos = getcurpos()
    normal! b
    let pos = getcurpos()
    let to_return = [pos[1], pos[2], strlen(@/) - 4]
    call setpos('.', save_pos)

  elseif a:mode ==# 'v'
    let [lnum, col] = getpos("'<")[1:2]
    let to_return = [lnum, col, strlen(@/)]

  else
    let pos = getcurpos()
    let to_return = [pos[1], pos[2], strlen(@/) - 4]
  endif
  return to_return
endfunction "}}}

function! s:get_param() "{{{
  let to_return = {}

  let highlight_on = get(g:, 'star_flasher_hl_group_on', 'IncSearch')
  let highlight_off = get(g:, 'star_flasher_hl_group_off', 'Search')

  let duration = get(g:, 'star_flasher_duration', 500)
  let times = get(g:, 'star_flasher_times', 1)
  let freq = float2nr(duration / (2 * times))

  return { 'duration' : duration , 'freq' : freq, 'hl_on': highlight_on, 'hl_off': highlight_off}
endfunction "}}}

function! s:star_flasher(mode)

  " if (!exists('s:star_flasher_match_ids'))
  "     let s:star_flasher_match_ids  = []
  " endif


  if (!exists('s:star_flasher_match_ids'))
    let s:star_flasher_match_ids  = {'on': {}, 'off': {}}
  endif

  " get necesarry parameters to start the flashing
  let s:param = s:get_param()

  call s:stop_all_timers(0)

  call s:put_in_search_reg(a:mode)

  let s:flash_pos = s:get_flash_pos(a:mode)

  let s:toggle_timer_id = timer_start(s:param.freq, function('<SID>flash_toggle'), {'repeat': -1})
  let s:toggle_stop_id = timer_start(s:param.duration, function('<SID>stop_all_timers'))

  " jump back to the beginning of the visual selection
  if a:mode ==# 'v'
    normal! `<
  endif

endfunction

"}}}
