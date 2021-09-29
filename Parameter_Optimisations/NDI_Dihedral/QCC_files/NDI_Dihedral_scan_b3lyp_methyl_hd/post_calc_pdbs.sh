source ~/.zshrc

for i in $(seq -175 5 180)
do

	obabel -ilog NDI_$i.log -opdb > NDI_${i}_b3lyp.pdb

done

