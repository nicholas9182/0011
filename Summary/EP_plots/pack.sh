source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output but3.pdb 

structure ../BI.pdb 
number 1 
center 
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure ../BM.pdb 
number 1 
center 
fixed 9 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure ../BE.pdb 
number 1 
center 
fixed 18 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 


EOF

