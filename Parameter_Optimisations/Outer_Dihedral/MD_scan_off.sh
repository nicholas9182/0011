source ~/.zshrc

# remove existing data file
rm MD_scan_off.txt

# turn off potential in the forcefield
sed -i '' '167s/.*/ CBB    CAA     CAA     ST     3 0 0 0 0 0 0/g' OBT.ff/ffOBT.itp

# Loop over the different angle restraints
for i in $(seq -170 10 180)
do
	
	gmx editconf -f mon.pdb -o mon.gro -box 5 5 5
	echo "1" | gmx pdb2gmx -f mon.gro
	rm posre.itp

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
	3 4 12 13 1 $i 0 500

	EOF
	) > topol.top
	
	gmx grompp -f EM.mdp -r mon.gro -p topol.top -o EM.tpr -maxwarn 1
	gmx mdrun -s EM.tpr -deffnm EM	

	mv EM.gro EM_$i.gro 

	a=$(grep "Potential Energy" EM.log | awk '{print $4}')
	echo "$i     $a" >> MD_scan_off.txt	
	rm \#*

done

# Remove unnecessary files
rm EM.edr EM.gro EM.log EM.tpr EM.trr conf.gro mdout.mdp mon.gro topol.top ener.edr md.log  
