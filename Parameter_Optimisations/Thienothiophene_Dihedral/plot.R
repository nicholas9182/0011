library('tidyverse')

gaussian_b3lyp <- read.table("~/Dropbox/OBT/0013/thienothiophene_dihedral/inner.txt") %>% 
	rename(Angle=V1, Energy=V2) %>% 
	mutate(Method="B3LYP") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) 

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy = Energy - min(Energy)) 

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy) )  

Data <- bind_rows(gaussian_b3lyp, MD_scan_off, MD_scan_on)

Data %>% dplyr::filter(Energy < 50) %>%  
	ggplot(aes(x=Angle, color=Method)) +
		geom_point(aes(y=Energy)) +
		#geom_line(aes(y=Energy), size=0.8) +
		geom_smooth(aes(y=Energy), size=0.8, se=FALSE, span=0.2) + 
		theme_classic(base_size=25) +
		scale_x_continuous(breaks=seq(-160,160,40)) +
		labs(x=expression('CBB-CE-CRR-SRR ('*degree*')'), y="E (KJ/mol)")
	ggsave("Energy_MD.pdf", width=12) 
