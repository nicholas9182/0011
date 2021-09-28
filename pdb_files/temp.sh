source ~/.zshrc

sed -i '' 's/ M3     / M2     /g' M2.pdb
sed -i '' 's/ E3     / E2     /g' E2.pdb
sed -i '' 's/ P3     / P2     /g' P2.pdb
sed -i '' 's/ U3     / U2     /g' U2.pdb
sed -i '' 's/ N3     / N2     /g' N2.pdb
sed -i '' 's/ H3     / H2     /g' H2.pdb
sed -i '' 's/ S3     / S2     /g' S2.pdb

sed -i '' 's/ M3     / M1     /g' M1.pdb
sed -i '' 's/ E3     / E1     /g' E1.pdb
sed -i '' 's/ P3     / P1     /g' P1.pdb
sed -i '' 's/ U3     / U1     /g' U1.pdb
sed -i '' 's/ N3     / N1     /g' N1.pdb
sed -i '' 's/ H3     / H1     /g' H1.pdb
sed -i '' 's/ S3     / S1     /g' S1.pdb


MD_flip M2
MD_flip E2
MD_flip P2
MD_flip U2
MD_flip N2
MD_flip H2
MD_flip S2

MD_flip M1
MD_flip E1
MD_flip P1
MD_flip U1
MD_flip N1
MD_flip H1
MD_flip S1
