

function! yuki#dict#diff(dict1, dict2)
  call maktaba#ensure#IsDict(a:dict1)
  call maktaba#ensure#IsDict(a:dict2)

  let filtered_dict1 = copy(a:dict1)
  let filtered_dict2 = copy(a:dict2)

  let diff = []

  for [ key, value ] in items(a:dict2)
    let condition = '!(v:key == ' . key . ' && v:val == ' . string(value) .')'
    call filter(filtered_dict1, condition)
  endfor

  if !yuki#value#IsEmpty(filtered_dict1)
    call add(diff, filtered_dict1)
  endif

  for [ key, value ] in items(a:dict1)
    let condition = '!(v:key == ' . key . ' && v:val == ' . string(value) .')'
    call filter(filtered_dict2, condition)
  endfor

  if !yuki#value#IsEmpty(filtered_dict2)
    call add(diff, filtered_dict2)
  endif

  return diff
endfunction

