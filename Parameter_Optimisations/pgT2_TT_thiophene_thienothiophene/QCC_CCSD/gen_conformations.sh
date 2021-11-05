source ~/.zshrc

for i in $(seq 0 20 180)
do
	obabel -ilog ../QCC_HF/pg2T_TT_${i}.log -opdb > pgT2_TT_${i}.pdb
done

