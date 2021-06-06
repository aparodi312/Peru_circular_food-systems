# R code for the article: Challenges, opportunities, and research needs to improve circularity in the Peruvian food system
# Code elaborated by Alejandro Parodi

# Activate packages
library(networkD3)                # For sankey
library(webshot)                  # To convert the sankey html to pdf 
webshot::install_phantomjs()      # Needed when webshot is used for the first time

# Set working directory
setwd("/Users/lupuna/Documents/short communication/rfigures/final")

# Figure 1 - Fisheries

# Import data
links_fisheries <- read.csv("links_fisheries.csv")
# Contains the flows among the element of the sankey
# Data was obtained from PRODUCE. Anuario Estadístico, Pesquero y Acuícola 2018. (2018).
# Explanation of column names:
# [1] from - Name of the node from where the flow starts
# [2] to - Name of the node to where the flow arrives
# [3] value - Value of the flow  (in thousand tonnes)
# [4] Reference - Where the data was obtained from 
# [5] source - Numeric value of the from [1] column
# [6] type - Numeric value of the to [2] column


nodes_fisheries <- read.csv("nodes_fisheries.csv")    
# Contains the labels and numeric code of each flow used in the links file.
# Explanation of column names:
# [1] name - List of unique values from columns [1] and [2]. The numeric flows were calculated apart and added in parenthesis
# [2] to - numeric value of each name. 
 
# Plot
sankeyNetwork(Links = links_fisheries, Nodes = nodes_fisheries,
              Source = "source", Target = "type",
              Value = "value", NodeID = "name", 
              fontSize= 13,  nodeWidth = 4, nodePadding = 15, sinksRight=TRUE, height=450, width=900)

# Important note:
# Some nodes do not fit because during processing (reduction, canning, freezing, curing) water and biomass (e.g., organs) are lost.
# For instance, before canning the fish biomass was 100 kg, and after canning it was 50 kg (values are not real)
# Therefore, it was assumed that during the processing 50 kg of water and offal biomass was lost. 
# Inkscape was used to manually modify the flows to make them match accouting for such losses.


# To convert it to pdf:
# Save the image as html (in the viewer tab, click on export - save as webpage)
# Open the file in a browser(google chrome, explorer, etc)
# Copy the URL of the file (e.g., ) below and run the code

webshot("paste here the path to the html file" , "Sankey_pesqueriaperu.pdf", delay = 0.2)
# The pdf will be saved in the working directory. The open source Inkscape software was used for post-edition





# Figure 2 - Agriculture
# Panel A - Treemap

# Import data
treemap_landuseperu <- read.csv("treemap_landuseperu.csv")
# Contains the surface area of each Peruvian geographical region (Coast, Andes, Amazon) and the land use in each of them.
# Data corresponding to the area of each region was obtained in the page 17 of the document found at from https://www.inei.gob.pe/media/MenuRecursivo/publicaciones_digitales/Est/Lib1140/cap01.pdf
# Data corresponding to the use of agricultural land was obtained from Cenagro 2012 at http://censos.inei.gob.pe/Cenagro/redatam/#
# Non-agricultural area was calculated by difference

# Explanation of column names:
# [1] country - Name of the country (Peru)
# [2] region - Name of the region (Coast, Andes, Amazon)
# [3] type - Type of area (agricultural or non agricultural area)
# [4] type2 - Second level of type of area (non agricultural, crop land, fallow land, grasslands, etc)
# [5] ha - Number of hectares (in thousand) of the type2 categorization


# Set manually the colors 
mycolors <- c("#36661C", "#955F2D", "#DFCE83")

#Plot treemap
treemap(treemap_landuseperu, index=c("region", "type", 'type2'), vSize="ha", 
        
        type="categorical",                         # How you color the treemap. type help(treemap) for more info
        vColor = "region",                          # Set the variable that will determine the color
        title="Land use Peru",                      # Customize your title
        palette = mycolors,                         # Indication to use the manually created palette 'mycolors'
        fontsize.title=12,                          # Size of the title
        fontsize.legend = 14,                       # Size of the legend
        bg.labels=c("transparent"),                 # Background color of labels
        align.labels=list(
          c("center", "center"), 
          c("right", "center")
        ),                                          # Where to place labels in the rectangle?
        overlap.labels=1,                           # Number between 0 and 1 that determines the tolerance of the overlap between labels. 0 means that labels of lower levels are not printed if higher level labels overlap, 1  means that labels are always printed. In-between values, for instance the default value .5, means that lower level labels are printed if other labels do not overlap with more than .5  times their area size.
        inflate.labels=F,                           # If true, labels are bigger when rectangle is bigger.
        border.col=c("black","black", "black"),     # Color of borders of groups, of subgroups, of subsubgroups ....
        border.lwds=c(3, 6, 3))


# Save treemap
ggsave("treemap.pdf", dpi=300, width = 20, height=15, units = "cm")
# Inkscape was used to do post-edition of the figure.


# Panel B - Sankey

# Import data
links_agriculture <- read.csv("links_agriculture.csv")
# Contains the flows among the element of the sankey.
# Data was obtained from INEI. IV Censo Nacional Agropecuario 2012 - Base de Datos REDATAM. IV Censo Nacional Agropecuario 2012 http://censos.inei.gob.pe/Cenagro/redatam/# (2012)
# Perenial and annual crops were summed
# Explanation of column names:
# [1] from - Name of the node from where the flow starts
# [2] to - Name of the node to where the flow arrives
# [3] value - Value of the flow  (in thousand hectares)
# [4] source - Numeric value of the from [1] column
# [5] type - Numeric value of the to [2] column


nodes_agriculture <- read.csv("nodes_agriculture.csv")    
# Contains the labels and numeric code of each flow used in the links file.
# Explanation of column names:
# [1] name - List of unique values from columns [1] and [2]. The numeric flows were calculated apart and added in parenthesis
# [2] to - numeric value of each name. 



# Plot Sankey
sankeyNetwork(Links = links_agriculture, Nodes = nodes_agriculture,
              Source = "source", Target = "type",
              Value = "value", NodeID = "name", 
              fontSize= 13,  nodeWidth = 4, nodePadding = 25, sinksRight=TRUE, height=450, width=900)


