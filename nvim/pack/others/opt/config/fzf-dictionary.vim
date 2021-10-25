
let g:fzf_dictionary_options = #{
      \height: 10,
      \width: 20,
      \row: 2,
      \col: 0.5,
     \}

packadd vim-fzf-dictionary

" function! s:get_previous_word()
"   let lig = getline(line('.'))
"   let lig = strpart(lig,0,col('.')-1)
"   " return matchstr(lig, '\<\k*\>\s*$')
"   return matchstr(lig, '\k*$')
" endfunction

" function! s:fzf_complete() abort
"   let word = s:get_previous_word()
"   if len(word) > 5
"     call fzf#dictionary#keep(g:fzf_dictionary_options)
"   end
" endfunc

" augroup fzf-dictionary
"   autocmd!
"   autocmd TextChangedI <buffer> call <sid>fzf_complete()
" augroup END



