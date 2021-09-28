source ~/.zshrc

# remove existing data file
rm MD_scan_on.txt

# turn on potential in the forcefield
sed -i '' '73s/.*/ OT     CBB     CBB     1       127.4  860/g' OBT.ff/ffOBT.itp
sed -i '' '74s/.*/ CAA    CBB     OT      1       119.1  860/g' OBT.ff/ffOBT.itp

# Loop over the different angle restraints
for i in $(seq 113 0.25 125.5)
do

	# correct angle to take 180-angle
	b=$(echo "scale=3; 180-$i" | bc)
	
	gmx editconf -f mon.pdb -o mon.gro -box 5 5 5
	echo "1" | gmx pdb2gmx -f mon.gro
	
	# generate top file with angle restraint (20,000 Kj/mol)
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
	 1 2 2 6            1       $b         4400  1
	EOF
	) > topol.top
	
	rm posre.itp

	# perform EM
	gmx grompp -f EM.mdp -c mon.gro -p topol.top -o EM.tpr -maxwarn 1
	gmx mdrun -s EM.tpr -deffnm EM	

	# take out parameters and record in data file
	a=$(grep "Potential Energy" EM.log | awk '{print $4}')
	echo "$i     $a" >> MD_scan_on.txt	
	rm \#*

done

# Remove unnecessary files
rm EM.edr EM.gro EM.log EM.tpr EM.trr conf.gro mdout.mdp mon.gro 
