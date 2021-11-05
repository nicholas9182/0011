source ~/.zshrc

for i in $(seq -175 5 180)
do
	(
	cat <<- EOF
	load mon.pdb
	set retain_order, 1
	set pdb_retain_ids,[0,1]
	set_dihedral id 2, id 3, id 7, id 8, ${i}
	save pg2T_TT_${i}.pdb
	EOF
	) > temp.pml && echo "made pg2T_TT_${i}.pdb" || echo "failed to make pg2T_TT_${i}.pdb"
	pymol -c temp.pml &> /dev/null
	rm temp.pml \#* &> /dev/null
	sed -i '' '/CONECT.*/d' pg2T_TT_${i}.pdb
done

for i in $(seq -175 5 180)
do
	obabel -ipdb pg2T_TT_${i}.pdb -ogjf > pg2T_TT_${i}.gjf
	sed -i '' '1,3d' pg2T_TT_${i}.gjf
	sed -i '' '1s/^/\n/' pg2T_TT_${i}.gjf
	sed -i '' '1s/^/\# opt=modredundant wb97xd\/6-311\+g\(d,p\) \n/' pg2T_TT_${i}.gjf
	sed -i '' '1s/^/\%nprocshared=8 \n/' pg2T_TT_${i}.gjf
	sed -i '' '1s/^/\%mem=10GB \n/' pg2T_TT_${i}.gjf
       	echo "D 2 3 7 8 F" >> pg2T_TT_${i}.gjf
	echo "" >> pg2T_TT_${i}.gjf	
done
