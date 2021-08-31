
let curpath = getcwd()

" open files containing boundary and initial condition settings
let p0 = join([curpath, '0'], '\')
cd `=p0`
arg `dir /a-d /b`
sall
windo wincmd H
windo set nowrap
windo %s/\t/    /ge

" open files containing system and discretization settings
let psys = join([curpath, 'system'], '\')
cd `=psys`
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
let pcon = join([curpath, 'constant'], '\')
cd `=pcon`
tabnew
arg `dir /a-d /b`
sall
windo wincmd H
windo set nowrap
windo %s/\t/    /ge

tabprevious
tabprevious

