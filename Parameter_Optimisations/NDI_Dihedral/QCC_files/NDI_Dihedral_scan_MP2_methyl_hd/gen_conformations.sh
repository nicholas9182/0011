source ~/.zshrc


for i in $(seq -175 5 180)
do
	obabel -ipdb NDI_${i}_b3lyp.pdb -ogjf > NDI_${i}.gjf
	sed -i '' '1,3d' NDI_${i}.gjf
	sed -i '' '1s/^/\n/' NDI_${i}.gjf
	sed -i '' '1s/^/\# mp2\/aug-cc-pvdz MaxDisk=400GB \n/' NDI_${i}.gjf
	sed -i '' '1s/^/\%nprocshared=40 \n/' NDI_${i}.gjf
	sed -i '' '1s/^/\%mem=480GB \n/' NDI_${i}.gjf
       	echo "D 8 9 32 33 F" >> NDI_${i}.gjf # fix the dihedral over which we are scanning
	echo "" >> NDI_${i}.gjf	
done
