
" open files containing boundary and initial condition settings
arg 0/*
sall
windo wincmd H
windo set nowrap
windo %s/\t/    /g

" open files containing system and discretization settings
cd ../system
tabnew
if filereadable('setFieldsDict')
    arg setFieldsDict
    argadd controlDict
else
    arg controlDict
endif
argadd blockMeshDict
argadd fvSchemes
argadd fvSolution
sall
windo wincmd H
windo set nowrap
windo %s/\t/    /g

" open files containing material and other properties
cd ..
tabnew
arg constant/*
sall
windo wincmd H
windo set nowrap
windo %s/\t/    /g

tabprevious
tabprevious

