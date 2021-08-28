function! AddDocstring()
    """Create docstrings in python files"""

    "let ft = &filetype
    let ext = tolower(expand('%:e'))

    if ext == 'py'
        "%s/\(def\|class\)\(.*\)/\1\2\r    """This is a bockwurst docstring.\r\rArgs:\r\r\rKwargs:\r\r\rReturns:\r\r\rRaises:\r\r\rExamples:\r\r\r"""/gc
        %s/\(def\|class\)\(.*\)/\1\2\r    """This is a bockwurst docstring."""/gcI
    endif

    normal gg=G

endfunction

" call function
call AddDocstring()
