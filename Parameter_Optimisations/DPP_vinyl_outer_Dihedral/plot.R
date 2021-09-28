library('tidyverse')

gaussian_b3lyp <- read.table("/Users/nicholassiemons/Dropbox/OBT/0064/Vinyl_outer_dihedral_attempt2/DPP.txt") %>% 
	rename(Angle=V1, Energy=V2) %>% 
	mutate(Method="B3LYP") %>%
	mutate(Energy= Energy*27211.4) %>%
	mutate(Energy = Energy - min(Energy)) %>%	
        mutate( Angle = ifelse(Angle>0 , Angle-360, Angle) ) %>%
	mutate( Angle = Angle + 180 ) 

gaussian_b3lyp %>%
	write.table("gaussian_scan.tsv")

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy = (Energy - min(Energy))*10.36 ) 

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = (Energy - min(Energy))*10.36 )  

Data <- bind_rows(gaussian_b3lyp, MD_scan_off, MD_scan_on)

Data %>% dplyr::filter(Energy < 2000) %>%  
	ggplot(aes(x=Angle, color=Method)) +
		geom_point(aes(y=Energy)) +
		geom_line(aes(y=Energy), size=1.2) +
#		geom_smooth(aes(y=Energy), size=0.8, se=FALSE, span=0.15) + 
		theme_classic(base_size=25) +
		scale_x_continuous(breaks=seq(-160,160,40)) +
		labs(x=expression('CBB-CE-CR-SR ('*degree*')'), y="E (meV)")
	ggsave("Energy_MD.pdf", width=12) 
