
let curpath = getcwd()

" open files containing boundary and initial condition settings
let p0 = join([curpath, '0'], '/')
cd `=p0`
if has("unix")
    arg `find . -maxdepth 1 -type f`
else
    arg `dir /a-d /b`
endif
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
let pcon = join([curpath, 'constant'], '/')
cd `=pcon`
tabnew
if has("unix")
    arg `find . -maxdepth 1 -type f`
else
    arg `dir /a-d /b`
endif
sall
windo wincmd H
windo set nowrap
windo %s/\t/    /ge

tabprevious
tabprevious

