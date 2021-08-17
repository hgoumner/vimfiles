" Vim syntax file
" Language: RELAP5
" Maintainer: Hristo Goumnerov

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" Matches
" ----------------------------------------------
syn match rl5CW "^\$ .*$"
syn match rl5KW "^\*[cC]rd.*$"
syn match rl5Comment "^\*[^cC]*$"

" Highlight Links
" ----------------------------------------------
hi link rl5CW Statement
hi link rl5KW Function
hi link rl5Comment Comment

let b:current_syntax = "relap5"

let &cpoptions = s:cpo_save
unlet s:cpo_save

