source ~/.zshrc

for i in $(seq -170 10 180)
do
	obabel -ipdb OBT_$i.pdb -ogjf > OBT_$i.gjf
	gsed -i "s/\!Put Keywords Here, check Charge and Multiplicity./\%mem=10GB\n%nprocshared=4/g" OBT_$i.gjf
	gsed -i "s/\#/\# opt=modredundant b3lyp\/6-311+g(d,p)/g" OBT_$i.gjf
	echo "D 5 1 8 9 F" >> OBT_$i.gjf
	echo "" >> OBT_$i.gjf
done
