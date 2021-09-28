

data1 <- read_pdb2("alk3.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("alk3.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Part=="Terminal")) %>%
	dplyr::filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red",
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2.25), range=c(0,8)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("alk3.pdf")


		 
data1 <- read_pdb2("gly3.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("gly3.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Part=="Terminal")) %>%
	dplyr::filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red", 
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("gly3.pdf")


data1 <- read_pdb2("AB.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("AB.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Part=="Terminal")) %>%
	dplyr::filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red", 
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2), range=c(0,7)) + 
		coord_fixed() +
		stripped() +
		xlim(-5,5) + 
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("AB.pdf")


data1 <- read_pdb2("met3.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("met3.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red", 
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("met3.pdf")


data1 <- read_pdb2("eth3.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("eth3.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red", 
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("eth3.pdf")



data1 <- read_pdb2("pro3.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("pro3.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red", 
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("pro3.pdf")


data1 <- read_pdb2("but3.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("but3.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red", 
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("but3.pdf")


data1 <- read_pdb2("gly3.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("gly3.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Part=="Terminal")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red", 
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
#		geom_text(aes(label=Element), color="white", size=3)
	ggsave("gly3_with_h.pdf")
