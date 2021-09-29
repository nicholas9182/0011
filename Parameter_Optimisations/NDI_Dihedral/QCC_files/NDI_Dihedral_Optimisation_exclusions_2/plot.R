library('tidyverse')

gaussian_b3lyp <- read.table("~/Dropbox/OBT/0060/NDI_Dihedral_scan_b3lyp_methyl_hd/NDI_modified.txt") %>% 
	rename(Angle=V1, Energy=V2) %>% 
	mutate(Method="B3LYP") %>%
	mutate(Energy= Energy*27211.4) %>%
	mutate(Energy = Energy - min(Energy)) 

gaussian_mp2 <- read.table("~/Dropbox/OBT/0060/NDI_Dihedral_scan_MP2_methyl_hd/NDI_modified.txt") %>% 
	rename(Angle=V1, Energy=V2) %>% 
	mutate(Method="MP2") %>%
	mutate(Energy= Energy*27211.4) %>%
	mutate(Energy = Energy - min(Energy)) 

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy = (Energy - min(Energy))*10.36 ) 

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = (Energy - min(Energy))*10.36 )  

Data <- bind_rows(gaussian_b3lyp, gaussian_mp2, MD_scan_off, MD_scan_on)

Data %>% dplyr::filter(Energy < 2000) %>%  
	ggplot(aes(x=Angle, color=Method)) +
		geom_point(aes(y=Energy)) +
		geom_line(aes(y=Energy), size=1.2) +
#		geom_smooth(aes(y=Energy), size=0.8, se=FALSE, span=0.15) + 
		theme_classic(base_size=25) +
		scale_x_continuous(breaks=seq(-160,160,40)) +
		labs(x=expression('CBB-CE-CR-SR ('*degree*')'), y="E (meV)")
	ggsave("Energy_MD.pdf", width=12) 
