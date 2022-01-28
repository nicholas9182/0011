source ~/.zshrc

# remove existing data file
rm MD_scan_off.txt

# turn off potential in the forcefield
sed -i '' '309s/.*/  CBB    CE      CRR     SRR     3       0 0 0 0 0 0 /g' OBT.ff/ffOBT.itp

echo "1" | gmx pdb2gmx -f pre_eq_pdb/mon_0.pdb &> /dev/null
rm posre.itp
mv topol.top mon.itp
sed -i -e 1,22d mon.itp
ex -snc '$-11,$d|x' mon.itp
sed -i '' 's/Other.*/mon      3/g' mon.itp

# Loop over the different angle restraints
for i in $(seq -175 5 180)
do
	(
	cat <<- EOF 
	#include "./OBT.ff/forcefield.itp"
	#include "mon.itp"
	
	[ system ]
	Struc
	
	[ molecules ]
	mon	1
	
	[ dihedral_restraints ]
	; ai   aj    ak    al   type  phi  dphi  kfac
	10 11 23 29 1 $i 0 400
	3 2 6 15 1 0 0 20	
	10 9 13 19 1 0 0 20
	EOF
	) > topol.top
	
	gmx grompp -f EM.mdp -c pre_eq_pdb/mon_${i}.pdb -p topol.top -o EM_$i.tpr -maxwarn 1  &> /dev/null
	gmx mdrun -s EM_$i.tpr -deffnm EM_$i	&> /dev/null && echo "Ran $i EM" || echo  "failed to run $i EM"
	mv EM_$i.gro MD_off_gros

	a=$(grep "Potential Energy" EM_$i.log | awk '{print $4}')
	echo "$i     $a" >> MD_scan_off.txt	
	rm \#* &> /dev/null

done

# Remove unnecessary files
rm EM*.edr EM*.log EM*.tpr EM*.trr conf.gro mdout.mdp mon.gro topol.top ener.edr md.log posre.itp *tpr &> /dev/null

Rscript plot.R
open Energy_MD.pdf
