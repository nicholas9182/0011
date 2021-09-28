library('tidyverse')


RB <- function(C0,C1,C2,C3,C4,C5,Angle){
	V <-    C0*cos(Angle*0.0174533)^0 + 
		-C1*cos(Angle*0.0174533)^1 + 
		C2*cos(Angle*0.0174533)^2 + 
		-C3*cos(Angle*0.0174533)^3 + 
		C4*cos(Angle*0.0174533)^4 + 
		-C5*cos(Angle*0.0174533)^5
	return(V)
}

RB_fit <- function(D) {
	nls(Energy~RB(C0,C1,C2,C3,C4,C5,Angle), 
		start=list(C0=0,C1=300,C2=-30,C3=0,C4=10,C5=10), 
		data=D,
		#weights=abs((1/(Angle^(2)+0.0001))),
		nls.control(maxiter=1000)) 
}

range <- 140

gaussian <- read.table("~/Dropbox/OBT/0014/b3lyp_with_methyl.txt") %>% 
	as_tibble() %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>% 
	mutate(Method="b3lyp") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle) %>%
	rename(Energy_w = Energy) %>%
	arrange(Angle) %>% as_tibble() %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>% 
	filter(abs(Angle) <= range) %>% 
	arrange(Angle) %>% as_tibble()   %>% print()

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	as_tibble() %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	rename(Energy_MD_off = Energy) %>%
	arrange(Angle) %>%
	filter(Angle >= -range, Angle <= range) %>% as_tibble() %>% print()

MD_scan_off %>%
	mutate(Energy_w = gaussian$Energy_w) %>%
	mutate(Energy = Energy_w - Energy_MD_off ) %>%
	mutate(fit = predict(RB_fit(.))) %>% 
	ggplot(aes(x=Angle , y=Energy)) + 
		geom_point() + 
		geom_line(aes(y=fit)) +
		theme_classic()
	ggsave("Difference.pdf")

MD_scan_off %>%
	mutate(Energy_w = gaussian$Energy_w) %>%
	mutate(Energy = Energy_w - Energy_MD_off ) %>%
	select(Angle, Energy) %>%	
	RB_fit(.) 




	
