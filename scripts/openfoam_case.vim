" open files containing boundary and initial condition settings
arg 0/*
sall
windo wincmd H

" open files containing system and discretization settings
cd ..
tabnew
arg system/*
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

