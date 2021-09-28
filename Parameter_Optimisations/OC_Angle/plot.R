library('tidyverse')

Harmonic <- function(theta0,k,v0,Angle){
	V <- (1/2) * k * (theta0 - Angle)^2 + v0
	return(V)
}

Harmonic_fit <- function(D) {
	nls(Energy~Harmonic(theta0,k,v0,Angle), 
		start=list(theta0=110,k=1,v0=0), 
		data=D) 
}

bin <- function(D,n){
	binned <- data.frame(Energy=0, Angle=0, SD=0)	
	bin_size <- as.integer(nrow(D)/n)
	for (i in 1:n){
		j <- i*bin_size - bin_size
		index <- full_seq(c(j,j+bin_size),1) 
		binned[i,"Angle"] <- mean(D[ index , "Angle" ]) 
		binned[i,"Energy"] <- mean(D[ index , "Energy" ])
		binned[i,"SD"] <- sd(D[ index , "Energy" ])	
	}
	return(binned)
}

gaussian_b3lyp <- read.table("/Users/nicholassiemons/Dropbox/OBT/0016/b3lyp_with_methyl_hd.txt") %>% 
	rename(Angle=V1, Energy=V2) %>% 
	mutate(Method="B3LYP") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(fit = predict(Harmonic_fit(.))) %>%
	mutate(Energy = Energy - min(fit), fit = fit-min(fit))

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_scan_potential_off") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(fit = predict(Harmonic_fit(.))) %>%
	mutate(Energy = Energy - min(fit), fit = fit-min(fit))

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_scan_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(fit = predict(Harmonic_fit(.))) %>%
	mutate(Energy = Energy - min(fit), fit = fit-min(fit))
	
bind_rows(gaussian_b3lyp, MD_scan_off,MD_scan_on) %>% 
	dplyr::filter(Energy < 4) %>%
	ggplot(aes(x=Angle, y=Energy, color=Method)) + 
		geom_point() + 
		geom_smooth(size=0.8, se=FALSE, span=0.3) + 
		labs(y="E (KJ/mol)", x=expression(theta~'(CAA-CBB-OT) / '*degree*'')) +
		theme_classic(base_size=25) + 
		theme(legend.position = "none")
	ggsave("Energy_scans.pdf", width=8) 

