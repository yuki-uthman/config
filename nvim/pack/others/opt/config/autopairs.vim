inoremap        (  ()<Left>
inoremap        ((  (
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap        [  []<Left>
inoremap        [[  [
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

inoremap        {  {}<Left>
inoremap        {{  {
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

inoremap        <  <><Left>
inoremap        <<  <
inoremap <expr> >  strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"

inoremap        '' '
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"

inoremap        "" "
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

let parethesis   = #{left: "(", right: ")"}
let bracket      = #{left: "[", right: "]"}
let curly        = #{left: "{", right: "}"}
let tag          = #{left: "<", right: ">"}
let single_quote = #{left: "'", right: "'"}
let double_quote = #{left: '"', right: '"'}

let s:pairs = [
      \parethesis, 
      \bracket, 
      \curly,
      \tag,
      \single_quote,
      \double_quote
      \]


inoremap <expr> <BS> <sid>better_bs()
inoremap <expr> <C-h> <sid>better_bs()

function! s:better_bs() abort
  let line = getline('.')
  let col = col('.')
  let right = strpart(line, col-1, 1)
  let left = strpart(line, col-2, 1)

  let matched_pair = {}

  " check if the left of the cursor matches any pair.left
  for pair in s:pairs
    if left == pair.left
      let matched_pair = pair
    endif
  endfor

  " after the loop if matched_pair is empty
  if empty(matched_pair)
    return "\<BS>"
  endif

  " if it matches any pair check the right of the cursor
  if right == matched_pair.right
    return "\<DEL>\<BS>" 
  else
    return "\<BS>"
  endif
endfunc

"https://vi.stackexchange.com/questions/24757/how-to-delete-a-pair-of-parenthesis-with-backspace
" inoremap <expr> <bs> <sid>remove_pair()
" imap <c-h> <bs>

" function s:remove_pair() abort
"   let pair = getline('.')[ col('.')-2 : col('.')-1 ]
"   return stridx('""''''()[]<>{}', pair) % 2 == 0 ? "\<del>\<c-h>" : "\<bs>"
" endfunction

" let g:couples = ['(#)', '[#]', '{#}', '<#>', '<div>#</div>', '""']
" function BetterBS()

"     for l:couple in g:couples
"         if ! (l:couple =~ '#')
"             continue
"         endif
"         let l:regex = substitute(escape(l:couple, '/\^$*.[~'), '#', '\\%#', '')
"         if search(l:regex, 'n')
"             let l:out = repeat("\<BS>", len(matchstr(l:couple, '^.\{-}\ze#')))
"             let l:out .= repeat("\<DEL>", len(matchstr(l:couple, '#\zs.\{-}$')))
"             return l:out
"         endif
"     endfor

"     return "\<BS>"
" endfunction
" inoremap <silent> <BS> <C-r>=BetterBS()<CR>



" delete empty pairs
" call lh#brackets#define_imap('<bs>',
"       \ [{ 'condition': 'lh#brackets#_match_any_bracket_pair()',
"       \   'action': 'lh#brackets#_delete_empty_bracket_pair()'}],
"       \ 0,
"       \ '\<bs\>'
"       \ )
