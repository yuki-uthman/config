
""
" Whether {value} is in {collection}.
" Returns 1 if {value} is in {collection}
" Returns 0 otherwise
" @throws BadValue if {collection} is not either list or dict.
function! yuki#value#IsIn(Value, collection) abort
  call maktaba#ensure#IsCollection(a:collection)

  if maktaba#value#IsList(a:collection)
    return index(a:collection, a:Value) >= 0
  elseif maktaba#value#IsDict(a:collection)
    return has_key(a:collection, a:Value)
  endif

endfunction


""
" Whether {key} is in {dictionary}.
" Returns 1 if the {dictionary} contains the {key}
" Returns 0 otherwise
" @throws BadValue if {dictionary} is not a dict.
function! yuki#value#HasKey(key, dict) abort
  call maktaba#ensure#IsDict(a:dict)
  return has_key(a:dict, a:key)
endfunction


""
" Whether the {value} is empty
function! yuki#value#IsEmpty(value)
  let empty_value = maktaba#value#EmptyValue(a:value)
  return maktaba#value#IsEqual(a:value, empty_value)
endfunction
