source ~/.zshrc

for i in $(seq -175 5 180)
do
	obabel -ilog ../QCC_HF/pg2T_TT_${i}.log -opdb > pgT2_TT_${i}.pdb
done

for i in $(seq -175 5 180)
do
	MD_flip pgT2_TT_${i}
	obabel -ipdb pgT2_TT_${i}.pdb -ogjf > pgT2_TT_${i}.gjf
	sed -i '' '1,3d' pgT2_TT_${i}.gjf
	sed -i '' '1s/^/\n/' pgT2_TT_${i}.gjf
	sed -i '' '1s/^/\# mp2\/aug\-cc\-pvdz \n/' pgT2_TT_${i}.gjf
	sed -i '' '1s/^/\%nprocshared=16 \n/' pgT2_TT_${i}.gjf
	sed -i '' '1s/^/\%mem=100GB \n/' pgT2_TT_${i}.gjf
       	echo "D 2 3 7 8 F" >> pgT2_TT_${i}.gjf
	echo "" >> pgT2_TT_${i}.gjf	
done
