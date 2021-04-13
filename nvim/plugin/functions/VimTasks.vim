" VimTasks.vim - Simple Task Manager for VIM
" Version:      0.1
" URL: https://github.com/lqp1/simple-vim-tasks
" License: MIT

function! VimTasks#BrowseOpenTasks()
    call inputsave()
    let l:file = input('Choice: ', '', 'file')
    call inputrestore()
    call VimTasks#OpenTasks(l:file)
endfunction

function! VimTasks#EnsureTasksList(name)
    if ! filereadable(expand(a:name))
        call writefile([], expand(a:name))
    end
    call VimTasks#OpenTasks(a:name)
endfunction

function! VimTasks#SaveTasks()
    call search('Tasks list: ')
    let l:file = matchlist(getline('.'), '^Tasks list: \(.*\)$')[1]
    let l:lines = getline(line('.')+1, '$')
    let l:filecontent = []
    for l:line in l:lines
        if len(l:line) > 2
            let l:entry = matchlist(l:line, '^\[.*\] \(.*\)$')[1]
            let l:state = matchlist(l:line, '^\[\(.*\)\] .*$')[1]
            if l:state == ' '
                call add(l:filecontent, '0 ' . l:entry)
            elseif l:state == '✓'
                call add(l:filecontent, '1 ' . l:entry)
            elseif l:state == '✗'
                call add(l:filecontent, '2 ' . l:entry)
            elseif l:state == '…'
                call add(l:filecontent, '3 ' . l:entry)
            elseif l:state == '?'
                call add(l:filecontent, '4 ' . l:entry)
            else
                call add(l:filecontent, '0 ' . l:entry)
            end
        end
    endfor
    call writefile(l:filecontent, expand(l:file))
endfunction

function! VimTasks#OpenTasks(afile)
    let l:file = expand(a:afile)
    if ! filereadable(l:file)
        echoerr("File is not readable")
        return
    end
    if bufwinnr("^Tasks$") < 0
        let l:lines = readfile(l:file)
        new
        file Tasks
        setl buftype = "nofile"
        setl noswapfile
        let l:buf = ["Tasks list: " . l:file . "\n"]
        for l:line in l:lines
            if l:line[0] == "0"
                call add(l:buf, "[ ] " . l:line[2:])
            elseif l:line[0] == "1"
                call add(l:buf, "[✓] " . l:line[2:])
            elseif l:line[0] == "2"
                call add(l:buf, "[✗] " . l:line[2:])
            elseif l:line[0] == "3"
                call add(l:buf, "[…] " . l:line[2:])
            elseif l:line[0] == "4"
                call add(l:buf, "[?] " . l:line[2:])
            else
                call add(l:buf, "[ ] " . l:line)
            end
        endfor
        put=l:buf
        setl nomodifiable

        " q → quit buffer
        nnoremap <buffer><silent> q :bdelete!<ESC>
        " n → new entry
        nnoremap <buffer><silent> n :call VimTasks#AddEntry()<ESC>
        " W → save
        nnoremap <buffer><silent> W :call VimTasks#SaveTasks()<Esc>
        " e → edit
        nnoremap <buffer><silent> e :call VimTasks#EditEntry()<Esc>

        " Change sate : v → validate, x → cancel, w → WIP, p → pending, c → clear
        nnoremap <buffer><silent> v :call VimTasks#ChangeEntryState("norm! ma^lr\<C-k>OK`a")<Esc>
        nnoremap <buffer><silent> x :call VimTasks#ChangeEntryState("norm! ma^lr\<C-k>XX`a")<Esc>
        nnoremap <buffer><silent> w :call VimTasks#ChangeEntryState("norm! ma^lr\<C-k>,.`a")<Esc>
        nnoremap <buffer><silent> p :call VimTasks#ChangeEntryState("norm! ma^lr?`a")<Esc>
        nnoremap <buffer><silent> c :call VimTasks#ChangeEntryState("norm! ma^lr `a")<Esc>
        
        highlight VimTasksOK ctermfg=2 cterm=italic
        highlight VimTasksKO ctermfg=1 cterm=italic
        highlight VimTasksWIP ctermfg=4 cterm=bold
        highlight VimTasksPending ctermfg=3 cterm=none
        call matchadd("VimTasksOK", '^\[✓\] .*$')
        call matchadd("VimTasksKO", '^\[✗\] .*$')
        call matchadd("VimTasksWIP", '^\[…\] .*$')
        call matchadd("VimTasksPending", '^\[?\] .*$')
    else
        echoerr "Tasks is already opened"
    end
endfunction

function! s:validateLine()
    let l:cur = getline(".")
    let m = matchstr(l:cur, '^\[.*\] .*$')
    if empty(m)
        return 0
    else
        return 1
endfunction

function! VimTasks#EditEntry()
    if s:validateLine()
        let l:entry = matchlist(getline('.'), '^\[.*\] \(.*\)$')[1]
        let l:state = matchlist(getline('.'), '^\[\(.*\)\] .*$')[1]
        call inputsave()
        let l:newentry = input('Edition: ', l:entry)
        call inputrestore()
        setl modifiable
        call setline('.', '[' . l:state . '] ' . l:newentry)
        setl nomodifiable
    end
endfunction

function! VimTasks#ChangeEntryState(action)
    let l:cur = getline(".")
    let m = matchstr(l:cur, '^\[.*\] .*$')
    if ! s:validateLine()
        echoerr "Not a valid line"
    else
        setl modifiable
        execute a:action
        setl nomodifiable
    end
endfunction

function! VimTasks#AddEntry()
    call inputsave()
    let l:entry = input('Task: ')
    call inputrestore()
    setl modifiable
    put = '[ ] ' . l:entry
    setl nomodifiable
endfunction

command! -nargs=1 -complete=file VimTasksOpen :call VimTasks#OpenTasks(<q-args>)
command! VimTasks :call VimTasks#EnsureTasksList('~/.local.vt')
