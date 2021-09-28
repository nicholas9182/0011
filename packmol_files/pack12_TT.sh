source ~/.zshrc

packmol << EOF
tolerance 2.0
filetype pdb
output hex12_TT.pdb 

structure pdb_files/FI.pdb 
number 1 
center 
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1
center 
fixed 13.85 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1 
center 
fixed 27.7 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1 
center 
fixed 41.55 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1 
center 
fixed 55.4 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1 
center 
fixed 69.25 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1 
center 
fixed 83.1 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1 
center 
fixed 96.95 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1 
center 
fixed 110.8 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1 
center 
fixed 124.65 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/FM.pdb 
number 1 
center 
fixed 138.5 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure pdb_files/HE.pdb 
number 1 
center 
fixed 151.65 -0.3 0 0 0 -0.13
inside box 0. 0. 0. 0 0 0 
end structure 



EOF

rm \#*
