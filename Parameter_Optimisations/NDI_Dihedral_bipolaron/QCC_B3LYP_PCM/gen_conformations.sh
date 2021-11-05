source ~/.zshrc

for i in $(seq -175 5 180)
do
	(
	cat <<- EOF
	load mon.pdb
	set retain_order, 1
	set pdb_retain_ids,[0,1]
	set_dihedral id 8, id 9, id 32, id 33, ${i}
	save NDI_${i}.pdb
	EOF
	) > temp.pml && echo "made NDI_${i}.pdb" || echo "failed to make NDI_${i}.pdb"
	pymol -c temp.pml &> /dev/null
	rm temp.pml \#* &> /dev/null
	sed -i '' '/CONECT.*/d' NDI_${i}.pdb
done

for i in $(seq -175 5 180)
do
	obabel -ipdb NDI_${i}.pdb -ogjf > NDI_${i}.gjf
	sed -i '' '1,3d' NDI_${i}.gjf
	sed -i '' '1s/^/\n/' NDI_${i}.gjf
	sed -i '' '1s/^/\# opt=modredundant b3lyp\/6-311\+g\(d,p\) scrf\=\(pcm\, solvent\=water\) \n/' NDI_${i}.gjf
	sed -i '' '1s/^/\%nprocshared=16 \n/' NDI_${i}.gjf
	sed -i '' '1s/^/\%mem=100GB \n/' NDI_${i}.gjf
	sed -i '' 's/0  1/\-2  1/g' NDI_${i}.gjf
       	echo "D 8 9 32 33 F" >> NDI_${i}.gjf
	echo "" >> NDI_${i}.gjf	
done
