source ~/.zshrc

gmx editconf -f ../pdb_files/T2.pdb -o temp.pdb -box 1.5 10 10 
gmx genconf -f temp.pdb -o temp2.pdb -nbox 98 1 1

packmol << EOF
tolerance 2.0
filetype pdb
output /Users/nicholassiemons/Dropbox/OBT/0011/pBTTT_uhw.pdb

structure /Users/nicholassiemons/Dropbox/OBT/0011/pdb_files/T1.pdb
number 1 
center 
resnumbers 2
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure /Users/nicholassiemons/Dropbox/OBT/0011/packmol_files/temp2.pdb 
number 1 
center 
resnumbers 2
fixed 742.5 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure /Users/nicholassiemons/Dropbox/OBT/0011/pdb_files/T3.pdb 
number 1 
center 
resnumbers 2
fixed 1485 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 


EOF

rm temp.pdb temp2.pdb
