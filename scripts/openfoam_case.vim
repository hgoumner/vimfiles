
" open files containing boundary and initial condition settings
arg 0/*
sall
windo wincmd H
windo set nowrap
windo %s/\t/    /ge

" open files containing system and discretization settings
cd ../system
tabnew
arg controlDict
argadd fvSchemes
argadd fvSolution
if filereadable('setFieldsDict')
    argadd setFieldsDict
endif
if filereadable('blockMeshDict')
    argadd blockMeshDict
endif
sall
windo wincmd H
windo set nowrap
windo %s/\t/    /ge

" open files containing material and other properties
cd ..
tabnew
arg constant/*
sall
windo wincmd H
windo set nowrap
windo %s/\t/    /ge

tabprevious
tabprevious

