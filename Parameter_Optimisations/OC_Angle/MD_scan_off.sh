source ~/.zshrc

# remove existing data file
rm MD_scan_off.txt

# turn off potential in the forcefield
sed -i '' '73s/.*/ OT     CBB     CBB     1       126.11  0/g' OBT.ff/ffOBT.itp
sed -i '' '74s/.*/ CAA    CBB     OT      1       119.60  0/g' OBT.ff/ffOBT.itp

# Loop over the different angle restraints
for i in $(seq 113 0.25 125.5)
do

	b=$(echo "scale=3; 180-$i" | bc)
	
	gmx editconf -f mon.pdb -o mon.gro -box 5 5 5
	echo "1" | gmx pdb2gmx -f mon.gro
	
	(
	cat <<- EOF 
	#include "./OBT.ff/forcefield.itp"
	#include "mon.itp"
	
	[ system ]
	Struc
	
	[ molecules ]
	mon	1
	
	[ angle_restraints ]
	; i j k l            type    theta0     fc             mult
	 1 2 2 6            1       $b         3500  1
	EOF
	) > topol.top
	
	rm posre.itp
	
	gmx grompp -f EM.mdp -c mon.gro -p topol.top -o EM.tpr -maxwarn 1
	gmx mdrun -s EM.tpr -deffnm EM	

	a=$(grep "Potential Energy" EM.log | awk '{print $4}')
	echo "$i     $a" >> MD_scan_off.txt	
	rm \#*

done

# Remove unnecessary files
rm EM.edr EM.gro EM.log EM.tpr EM.trr conf.gro mdout.mdp mon.gro topol.top ener.edr md.log  
