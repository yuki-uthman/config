
  
function! GetLatestQfLocList()
  if !exists('b:qftick')
      let b:qftick = -1
  endif

  let l:wininfo = getwininfo(win_getid())[0]

  if l:wininfo.quickfix
      let l:info = getqflist({'changedtick':1, 'size':1})
      " echo l:info
      if l:info.changedtick != b:qftick
          let b:qflist = getqflist()
          let b:qfsize = l:info.size
          let b:qftick = l:info.changedtick
      endif
      return 1
  endif

endfunction


function! GetValidEntry(linenr)
    " Ensure this function is run within a qf/loc list
    if &filetype !=# 'qf'
        return {}
    endif
    " Ensure the cached qf/loc list is up to date
    if !GetLatestQfLocList()
        return {}
    endif
    " Ensure the entry exist within the qf/loc list
    if a:linenr > b:qfsize
        return {}
    endif
    " Ensure the current entry is valid
    if !b:qflist[a:linenr-1].valid
        return {}
    endif
    " Ensure the file actually exists
    if !filereadable(bufname(b:qflist[a:linenr-1].bufnr))
        return {}
    endif
    " Return the valid entry
    " echo b:qflist[a:linenr-1] 
    return b:qflist[a:linenr-1]
endfunction

function! OpenPreviewWindow(bufname, linenr)
    " execute 'set previewheight='.l:size
    execute 'keepjumps '. 'edit .' +'.a:linenr.' .a:bufname
    " execute 'set previewheight='.l:orig_preview_height
endfunction

function! QFList(linenr)
    " Get the current entry and ensure it is valid
    let l:entry = GetValidEntry(a:linenr)
    " echo l:entry
    if empty(l:entry)
        return
    endif
    " echo a:linenr
    let bufname = bufname(l:entry.bufnr)
    let line = l:entry.lnum
    let col = l:entry.col
    " echo bufname
    " echo "jump to " . line
    keepjumps wincmd k
    execute "normal! :edit ". bufname . "\<CR>"
    execute "normal! " . line . "G"
    execute "normal! zz"

    let line = l:entry.lnum
    let col  = l:entry.col
    let title = getqflist({'title' : 0}).title
    let pattern = matchstr(title, '/.\{-}/' )
    let patternLength = len(pattern) - 2
    let line = '\%'. line . 'l' 
    let endCol = col + patternLength 
    let end = '\%<' . endCol . 'v.'
    let start = '\%>' . col . 'v'
    let hightlightPattern = line . end . start

    " echo line . end . start
    " call matchadd('Search', '\%30l\%<100v.\%>10v', -1)
    
    call clearmatches()
    call matchadd('Underlined',  hightlightPattern , -1 )

    " echo 'line = ' . line
    " echo 'col  = ' . col
    " echo 'pattern = ' . patternLength

    " call matchaddpos('Search', [line, col, patternLength])
    " :vimgrep /Resident/gj
    " /\/\(\w*\)\/
     " :vimgrep /resident =/gj
      " \/\(.*\)\/


    
    " go back to qflist window
    keepjumps wincmd p
endfunction


nnoremap <buffer> p :call QFList(line('.'))<CR>

" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction

command! RemoveQFItem :call RemoveQFItem()

" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
nnoremap <buffer> dd :RemoveQFItem<cr>


" nmap <buffer> p <plug>(quickr_preview)




" nnoremap <buffer> p :call QuickfixHighlightedPreview()<CR> 
" nmap     <buffer> n np

" Use <silent> so ":call quickfixed#older()" isn't output to the command line
" nnoremap <silent> <buffer> <Left> :call quickfixed#older()<CR>
" nnoremap <silent> <buffer> <Right> :call quickfixed#newer()<CR>

