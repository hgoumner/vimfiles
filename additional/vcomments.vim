function! ToggleComment()
    let ext = tolower(expand('%:e'))
    if ext == 'bat'
        if matchstr(getline(line(".")),'^\s*REM.*$') == ''
            silent s/^/REM 
        else
            silent s/^REM //
        endif
    elseif ext == 'py' || ext == 'sh'
        if matchstr(getline(line(".")),'^\s*#.*$') == ''
            silent s/^/\#/
        else
            silent s/^\#//
        endif
    elseif ext == 'js'
        if matchstr(getline(line(".")),'^\s*\/\/.*$') == ''
            silent s:^:\/\/:g
        else
            silent s:^\/\/::g
        endif
    elseif ext == 'vim'
        if matchstr(getline(line(".")),'^\s*\".*$') == ''
            silent s:^:\":g
        else
            silent s:^\"::g
        endif
    elseif ext == 'inp' || 'in' || 'inp_exp' || 'log'
        if matchstr(getline(line(".")),'^\s*@.*$') == ''
            silent s:^:@:g
        else
            silent s/^[@]//
        endif
    endif
endfunction

function! Comment()
    let ext = tolower(expand('%:e'))
    if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
        silent s/^/\#/
    elseif ext == 'js'
        silent s:^:\/\/:g
    elseif ext == 'vim'
        silent s:^:\":g
    elseif ext == 'inp' || 'in' || 'inp_exp' || 'log'
        silent s:^:@:g
    endif
endfunction

function! UnComment()
    let ext = tolower(expand('%:e'))
    if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
        silent s/^\#//
    elseif ext == 'js'
        silent s:^\/\/::g
    elseif ext == 'vim'
        silent s:^\"::g
    elseif ext == 'inp' || 'in' || 'inp_exp' || 'log'
        silent s/^[@]//
    endif
endfunction
