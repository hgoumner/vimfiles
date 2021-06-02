" delete all lines not containing | (Triggers, Actions)
%v/.*\(|\|\s=\).*$/d
"
" Matches
" ----------------------------------------------
syn match bl_True "True"
syn match bl_False "False"

" Coloring
" ----------------------------------------------
highlight bl_True guifg=green
highlight bl_False guifg=red
