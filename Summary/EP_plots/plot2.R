

data1 <- read_pdb_OBT("DPP_T.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("DPP_T.txt"))[[1]]) %>%
	mutate(radius = 6 ) %>% print() %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point(size=16) + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red",
			limits=c(-0.7,0.7)
		) +
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=AtomName), color="white", size=3)
	ggsave("DPP_T.pdf")


data1 <- read_pdb_OBT("DPP_T_T.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("DPP_T_T.txt"))[[1]]) %>%
	mutate(radius = 6 ) %>% print() %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point(size=16) + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red",
			limits=c(-0.7,0.7)
		) +
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=AtomName), color="white", size=3)
	ggsave("DPP_T_T.pdf")

data1 <- read_pdb_OBT("DPP_v.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("DPP_v.txt"))[[1]]) %>%
	mutate(radius = 6 ) %>% print() %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point(size=14) + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red",
			limits=c(-0.7,0.7)
		) +
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=AtomName), color="white", size=3)
	ggsave("DPP_v.pdf")

