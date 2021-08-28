function! ToggleComment()
    let ext = tolower(expand('%:e'))
    if ext == 'bat'
        if matchstr(getline(line(".")),'^\s*REM.*$') == ''
            silent s/^/REM  
        else
            silent s/^REM //
        endif
    elseif ext == 'c' || ext == 'cpp' || ext == 'lark'
        if matchstr(getline(line(".")),'^\s*\/\/.*$') == ''
            silent s/^/\/\//g
        else
            silent s/^\/\///g
        endif
    elseif ext == 'py' || ext == 'sh'
        if matchstr(getline(line(".")),'^\s*#.*$') == ''
            silent s/^/\#/g
        else
            silent s/^\#//g
        endif
    elseif ext == 'js'
        if matchstr(getline(line(".")),'^\s*\/\/.*$') == ''
            silent s/^/\/\//g
        else
            silent s/^\/\///g
        endif
    elseif ext == 'vim' || &filetype == 'vim'
        if matchstr(getline(line(".")),'^\s*\".*$') == ''
            silent s/^/"/g
        else
            silent s/^["]//g
        endif
    elseif ext == 'inp' || 'in' || 'inp_exp' || 'log' || &filetype == 'ac2'
        if matchstr(getline(line(".")),'^\s*@.*$') == ''
            silent s/^/@ /g
        else
            silent s/^@ \?//g
        endif
    endif
endfunction

function! Comment()
    let ext = tolower(expand('%:e'))
    if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
        silent s/^/\#/g
    elseif ext == 'js'
        silent s/^/\/\//g
    elseif ext == 'vim' || &filetype == 'vim'
        silent s/^/\"/g
    elseif ext == 'inp' || 'in' || 'inp_exp' || 'log' || &filetype == 'ac2'
        silent s/^/@ /g
    endif
endfunction

function! UnComment()
    let ext = tolower(expand('%:e'))
    if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
        silent s/^\#//g
    elseif ext == 'js'
        silent s/^\/\///g
    elseif ext == 'vim' || &filetype == 'vim'
        silent s/^\"//g
    elseif ext == 'inp' || 'in' || 'inp_exp' || 'log' || &filetype == 'ac2'
        silent s/^@ \?//g
    endif
endfunction
