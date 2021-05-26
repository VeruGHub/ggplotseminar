
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####### SEMINAR OF GGPLOT 26-05-2021 #############
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
############################# Veronica Cruz Alonso

#Packages
c("readxl", "ggplot2", "ggThemeAssist", "patchwork") %in% rownames(installed.packages())
c("promises","mime", "cachem") %in% rownames(installed.packages())

install.packages(c("readxl", "ggplot2", "ggThemeAssist", "patchwork"))
install.packages(c("promises","mime", "cachem"))


# ggplot  basics #########

#Load the data

library(readxl)

#
forests <- read_xlsx(path = "dataset_espelta2020.xlsx", sheet = 1)
#Modified from Espelta et al. 2020
#https://figshare.com/articles/dataset/Diversity_and_functions_of_long-established_and_secondary_broad-leaf_forests/12646400/1
#Rows: focal beech trees
#Columns: 
head(forests)


#The basics

library(ggplot2)

ggplot(data = forests)

ggplot(data = forests, aes(x = Shannon, y = mgrowth)) #variables are mapped to visual properties or aesthetics

ggplot() + 
  geom_point(data = forests, aes(x = Shannon, y = mgrowth)) #geometry (type of graph) 

ggplot(data = forests) + #examples with one variable
  geom_bar(aes(x = Type))

ggplot(data = forests) +
  geom_histogram(aes(x = mgrowth))

#see the cheat sheet!!

#Exercise: represent a violin plot of the mean growth in each forest type 




#Aesthetics vs. arguments

ggplot(data = forests) + 
  geom_point(aes(x = Shannon, y = mgrowth, color = Richness)) 
#Not the same than...
ggplot(data = forests) + 
  geom_point(aes(x = Shannon, y = mgrowth), color = "darkred") #R color chart
?geom_point #Aesthetics + arguments

#Exercise: how would you modify this code to represent the "Type" of forest in 
#different shapes but the points in red color?

ggplot(data = forests) + 
  geom_point(aes(x = Shannon, y = mgrowth))


#
ggplot(data = forests, aes(x = Shannon, y = mgrowth)) + 
  geom_line(color = "red")

ggplot(data = forests) + 
  geom_boxplot(aes(x = Patch, y = mgrowth, fill = Patch), color = "grey50") 


#More aesthetics, more geometries

ggplot(data = forests) + 
  geom_point(aes(x = Shannon, y = mgrowth, size = Herbivory, color = Richness,
                 shape = Type)) 

#
ggplot(data = forests) + 
  geom_point(aes(x = Shannon, y = mgrowth, color = Type))

ggplot(data = forests) + 
  geom_point(aes(x = Shannon, y = mgrowth, color = Type)) +
  geom_smooth(aes(x = Shannon, y = mgrowth, color = Type, fill = Type))


#The extras (part I) #########
#Advanced level!!! 

myplot2 <- ggplot(data = forests) + 
  geom_point(aes(x = Shannon, y = mgrowth, color = Richness))

myplot2 + 
  labs(title = "Diversity vs. mean beech growth", #1 Labels
       x = "Shannon index", y = "Mean growth (mm per year)") 

myplot2 +  #2 Coordinate system
    coord_cartesian(ylim = c(0.5,5)) 
myplot2 +  
  coord_polar() 


# Faceting 
# Facets divide a plot into subplots based on the values of one or more
# discrete variables.
myplot +
  facet_grid(rows = vars(Type))

# Position
#How arrange geometries that would otherwise occupy the same space
ggplot(data = forests) +
  geom_bar(aes(x = factor(Age), fill = Type))

ggplot(data = forests) +
  geom_bar(aes(x = factor(Age), fill = Type),
           position = "dodge")

ggplot(data = forests) +
  geom_bar(aes(x = factor(Age), fill = Type),
           position = "fill")

# The extras (part II): customization #########

myplot + #Customize aesthetics  
  scale_color_manual(values = c("darkgreen", "chartreuse")) +
  scale_fill_manual(values = c("darkgreen", "chartreuse")) +
  scale_y_continuous(breaks = c(1,3), labels = c("a", "b")) 


#theme() #Complete customization of all plot elements
?theme

myplot2 + theme(axis.title.x = element_text(color = "red", face = "bold"))

#Execise: black line representing both axis, no plot background



#
myplot2 + theme_classic()
myplot2 + theme_light()

#GgthemeAssist
myplot2 

# Last functions ####

#Saving satisfactory plots

ggsave(filename = "divxgrowth.jpg", plot = myplot2,
       width = 10, height = 7.5, units = "cm", dpi = 300)

#Patchwork

library(patchwork) #Add plots as "layers"

myplot + myplot2
myplot / myplot2 

#Other arrangements:
#https://patchwork.data-imaginist.com/articles/guides/layout.html

myplot / myplot2 + plot_annotation(tag_levels = "a", tag_suffix = ")")





# Plot in last slide
# myplot2 +
#   labs(title = "Diversity vs. mean beech growth", 
#        x = "Shannon index", y = "Mean growth (mm per year)") +
#   coord_polar() +
#   facet_grid(cols = vars(Type)) +
#   scale_color_gradientn(colors=heat.colors(6)) +
#   theme_light()





