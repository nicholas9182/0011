
# run EM
gmx editconf -f mon.pdb -o mon.gro -box 5 5 5
echo "1" | gmx pdb2gmx -f mon.gro
gmx grompp -f EM.mdp -p topol.top -r mon.gro -o EM.tpr
gmx mdrun -s EM.tpr -deffnm EM

# run NVT 10ps to equilibrate
gmx grompp -f NVT.mdp -p topol.top -r EM.gro -o NVT.tpr
gmx mdrun -s NVT.tpr -deffnm NVT

# run Prod 1000ps tp sample PES
gmx grompp -f Prod.mdp -p topol.top -r NVT.gro -o Prod.tpr 
gmx mdrun -s Prod.tpr -deffnm Prod

# extract the potential energy 
echo "Potential" | gmx energy -f Prod.edr -o Prod_Potential.xvg

# dump the frames containing just the relevant three atoms in the angle, and measure the angle and pass to a file angle.txt
rm MD_NVT_data.txt
for i in $(seq 0 0.01 500)
do
	gmx trjconv -f Prod.xtc -o angle.gro -dump $i -s Prod.tpr -n O_angle.ndx > /dev/null 2>&1
	gmx angle -f angle.gro -n angle.ndx | grep "< angle >" >> MD_NVT_data.txt
	rm \#* 
	echo "done $i"
done

