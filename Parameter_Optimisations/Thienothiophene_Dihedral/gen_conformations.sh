source ~/.zshrc

for i in $(seq -170 10 180)
do
	(
	cat <<- EOF
	load mon.pdb
	set retain_order, 1
	set_dihedral id 12, id 11, id 23, id 24, ${i}
	save pre_eq_pdb/mon_${i}.pdb
	EOF
	) > temp.pml

	pymol -c temp.pml &> /dev/null
	gmx editconf -f pre_eq_pdb/mon_${i}.pdb -o pre_eq_pdb/mon_${i}.pdb -box 10 10 10 &> /dev/null && echo "made mon_${i}.pdb" || echo "faileed to make mon_${i}.pdb"
	rm temp.pml pre_eq_pdb/\#* &> /dev/null

done
