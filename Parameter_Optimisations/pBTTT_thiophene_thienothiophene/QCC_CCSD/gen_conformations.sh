source ~/.zshrc

for i in $(seq 0 20 180)
do
	obabel -ilog ../QCC_HF/pBTTT_${i}.log -opdb > pBTTT_${i}.pdb
done

