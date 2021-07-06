set nowrap

" open files containing boundary and initial condition settings
arg 0/*
sall
windo wincmd H

" open files containing system and discretization settings
cd ..
tabnew
arg system/setFieldsDict
argadd controlDict
argadd fvSchemes
argadd fvSolution
sall
windo wincmd H

" open files containing material and other properties
cd ..
tabnew
arg constant/*
sall
windo wincmd H

tabprevious
tabprevious

