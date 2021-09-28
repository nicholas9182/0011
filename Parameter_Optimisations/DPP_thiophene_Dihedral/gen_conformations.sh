source ~/.zshrc

for i in $(seq -175 5 180)
do
	(
	cat <<- EOF
	load mon.pdb
	set retain_order, 1
	set_dihedral id 2, id 1, id 11, id 12, ${i}
	save pre_eq_pdb/mon_${i}.pdb
	EOF
	) > temp.pml

	pymol -c temp.pml &> /dev/null
	gmx editconf -f pre_eq_pdb/mon_${i}.pdb -o pre_eq_pdb/mon_${i}.pdb -box 10 10 10 &> /dev/null && \
		echo "made mon_${i}.pdb" || \
		echo "faileed to make mon_${i}.pdb"

	rm temp.pml pre_eq_pdb/\#* &> /dev/null

done



for i in -5
do
	(
	cat <<- EOF
	load mon.pdb
	set retain_order, 1
	set_dihedral id 2, id 1, id 11, id 12, -15
	save pre_eq_pdb/mon_${i}.pdb
	EOF
	) > temp.pml

	pymol -c temp.pml &> /dev/null
	gmx editconf -f pre_eq_pdb/mon_${i}.pdb -o pre_eq_pdb/mon_${i}.pdb -box 10 10 10 &> /dev/null && \
		echo "made mon_${i}.pdb" || \
		echo "faileed to make mon_${i}.pdb"

	rm temp.pml pre_eq_pdb/\#* &> /dev/null

done





for i in 180
do
	(
	cat <<- EOF
	load mon.pdb
	set retain_order, 1
	set_dihedral id 2, id 1, id 11, id 12, 160
	save pre_eq_pdb/mon_${i}.pdb
	EOF
	) > temp.pml

	pymol -c temp.pml &> /dev/null
	gmx editconf -f pre_eq_pdb/mon_${i}.pdb -o pre_eq_pdb/mon_${i}.pdb -box 10 10 10 &> /dev/null && \
		echo "made mon_${i}.pdb" || \
		echo "faileed to make mon_${i}.pdb"

	rm temp.pml pre_eq_pdb/\#* &> /dev/null

done
