source ~/.zshrc

for i in $(seq -175 5 180)
do
	obabel -ilog ../QCC_HF/pBTTT_${i}.log -opdb > pBTTT_${i}.pdb
done

for i in $(seq -175 5 180)
do
	obabel -ipdb pBTTT_${i}.pdb -ogjf > pBTTT_${i}.gjf
	sed -i '' '1,3d' pBTTT_${i}.gjf
	sed -i '' '1s/^/\n/' pBTTT_${i}.gjf
	sed -i '' '1s/^/\# opt=modredundant mp2\/aug\-cc\-pvdz \n/' pBTTT_${i}.gjf
	sed -i '' '1s/^/\%nprocshared=8 \n/' pBTTT_${i}.gjf
	sed -i '' '1s/^/\%mem=100GB \n/' pBTTT_${i}.gjf
       	echo "D 2 3 8 9 F" >> pBTTT_${i}.gjf
	echo "" >> pBTTT_${i}.gjf	
done
