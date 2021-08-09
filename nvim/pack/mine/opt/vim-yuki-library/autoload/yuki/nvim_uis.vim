
let s:ui = nvim_list_uis()[0]


function! yuki#nvim_uis#height(percentage)
  return float2nr(s:ui.height * a:percentage)
endfunction

function! yuki#nvim_uis#width(percentage)
  return float2nr(s:ui.width * a:percentage)
endfunction

function! yuki#nvim_uis#row(height, percentage)
  " TODO how to figure out if status line is visible
  return float2nr((s:ui.height - a:height - &cmdheight) * a:percentage) 
endfunction

function! yuki#nvim_uis#col(width, percentage)
  return float2nr((s:ui.width - a:width) * a:percentage)
endfunction
