" Vim syntax file
" Language: AC2
" Maintainer: Hristo Goumnerov

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" Matches
" ----------------------------------------------
syn match ac2CW "^C----.*$"
syn match ac2KW "^K----.*$"
syn match ac2SW "^S----.*$"
syn match ac2PW "^-----.*$"
syn match ac2Comment "@.*$"

" Highlight Links
" ----------------------------------------------
hi link ac2CW Statement
hi link ac2KW Function
hi link ac2SW Debug
hi link ac2PW Identifier
hi link ac2Comment Comment

let b:current_syntax = "ac2"

let &cpoptions = s:cpo_save
unlet s:cpo_save

setlocal complete+=k
setlocal dictionary+=$HOME/vimfiles/syntax/ac2_words.txt
setlocal iskeyword+=-

function! Fold()
    let l:cur_line = getline(v:lnum)
    let l:next_line = getline(v:lnum+1)
    if l:cur_line =~# '^C-'
        return '>' . (matchend(l:cur_line, '^C-') - 1)
    else
        if l:cur_line ==# '' && (matchend(l:next_line, '^C-') - 0) == 1
            return 0
        else
            return '='
        endif
    endif
endfunction

"function! FoldText()
"    let line = getline(v:foldstart)
"    let sub = substitute(line, '.*\<\(\w\+\)(.*).*', '\1(...)', 'g')
"    return '+-- ' . sub . ' (' . (v:foldend - v:foldstart + 1) . ' lines)'
"endfunction

setlocal foldmethod=expr
setlocal foldexpr=Fold()
setlocal foldlevel=1
"setlocal foldtext=FoldText()
"setlocal fillchars-=fold:-
