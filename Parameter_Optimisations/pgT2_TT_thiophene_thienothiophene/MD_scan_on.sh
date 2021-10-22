source ~/.zshrc

# remove existing data file
rm MD_scan_on.txt

# turn off potential in the forcefield
sed -i '' 's/CR CR CRR SRR.*/CR CR CRR SRR 3 8.40013981 5.55256639 -24.06376760 0.03981426 12.35093921 -0.26746390  /g' OBT.ff/ffOBT.itp

gmx pdb2gmx -f pre_eq_pdb/mon_0.pdb -ff OBT &> /dev/null
rm posre.itp
top_itp topol.top mon mon

# Loop over the different angle restraints
for i in $(seq -175 5 180)
do
	(
	cat <<- EOF 
	#include "OBT.ff/forcefield.itp"
	#include "mon.itp"
	
	[ system ]
	Struc
	
	[ molecules ]
	mon	1
	
	[ dihedral_restraints ]
	; ai   aj    ak    al   type  phi  dphi  kfac
	3 4 8 14 1 $i 0 200
	EOF
	) > topol.top
	
	gmx grompp -f EM.mdp -c pre_eq_pdb/mon_${i}.pdb -p topol.top -o EM_$i.tpr -maxwarn 1 &> /dev/null
	gmx mdrun -s EM_$i.tpr -deffnm EM_$i	&> /dev/null && echo "Ran $i EM" || echo  "failed to run $i EM"
	mv EM_$i.gro MD_on_gros

	a=$(grep "Potential Energy" EM_$i.log | awk '{print $4}')
	[ -z "$a" ] || echo "$i     $a" >> MD_scan_on.txt	
	rm \#* &> /dev/null

done

# Remove unnecessary files
rm EM*.edr EM*.log EM*.tpr EM*.trr conf.gro mdout.mdp mon.gro topol.top ener.edr md.log posre.itp *tpr &> /dev/null

#Rscript plot.R
#open Energy_MD.pdf
