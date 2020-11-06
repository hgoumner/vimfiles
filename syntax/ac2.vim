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
" ---------------------------------------------------------------------
hi link ac2CW Statement
hi link ac2KW Function
hi link ac2SW Debug
hi link ac2PW Identifier
hi link ac2Comment Comment

let b:current_syntax = "ac2"

let &cpoptions = s:cpo_save
unlet s:cpo_save

"" fold control words
"syn region vimFoldControl
"      \ start="^C----.*$"
"      \ end="^C----"
"      \ transparent fold
"      \ keepend extend
"
"" fold key words
"syn region vimFoldKey
"      \ start="^K----.*$"
"      \ end="^K----"
"      \ transparent fold
"      \ keepend extend
" 
"syn sync fromstart
"set foldmethod=syntax
"set foldlevelstart=200
"set foldcolumn=0
"
