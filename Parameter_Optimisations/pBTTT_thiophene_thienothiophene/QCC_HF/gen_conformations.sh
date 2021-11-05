source ~/.zshrc

for i in $(seq -175 5 180)
do
	(
	cat <<- EOF
	load mon.pdb
	set retain_order, 1
	set pdb_retain_ids,[0,1]
	set_dihedral id 2, id 3, id 9, id 10, ${i}
	save pBTTT_${i}.pdb
	EOF
	) > temp.pml && echo "made pBTTT_${i}.pdb" || echo "failed to make pBTTT_${i}.pdb"
	pymol -c temp.pml &> /dev/null
	rm temp.pml \#* &> /dev/null
	sed -i '' '/CONECT.*/d' pBTTT_${i}.pdb
done

for i in $(seq -175 5 180)
do
	obabel -ipdb pBTTT_${i}.pdb -ogjf > pBTTT_${i}.gjf
	sed -i '' '1,3d' pBTTT_${i}.gjf
	sed -i '' '1s/^/\n/' pBTTT_${i}.gjf
	sed -i '' '1s/^/\# opt=modredundant hf\/aug-cc-pvdz \n/' pBTTT_${i}.gjf
	sed -i '' '1s/^/\%nprocshared=8 \n/' pBTTT_${i}.gjf
	sed -i '' '1s/^/\%mem=100GB \n/' pBTTT_${i}.gjf
       	echo "D 2 3 9 10 F" >> pBTTT_${i}.gjf
	echo "" >> pBTTT_${i}.gjf	
done
