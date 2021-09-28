source ~/.zshrc

for i in $(seq -175 5 180)
do
	(
	cat <<- EOF
	load mon.pdb
	set retain_order, 1
	set_dihedral id 3, id 5, id 7, id 13, ${i}
	save pre_eq_pdb/mon_${i}.pdb
	EOF
	) > temp.pml

	pymol -c temp.pml &> /dev/null
	gmx editconf -f pre_eq_pdb/mon_${i}.pdb -o pre_eq_pdb/mon_${i}.pdb -box 10 10 10 &> /dev/null && \
		echo "made mon_${i}.pdb" || \
		echo "faileed to make mon_${i}.pdb"

	rm temp.pml pre_eq_pdb/\#* &> /dev/null

done


