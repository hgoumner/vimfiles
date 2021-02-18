" delete all lines not starting with a or t
%g!/.*\(|\|\s=\).*$/d
"
" Matches
" ----------------------------------------------
syn match bl_True "True"
syn match bl_False "False"

" Coloring
" ----------------------------------------------
highlight bl_True guifg=green
highlight bl_False guifg=red
