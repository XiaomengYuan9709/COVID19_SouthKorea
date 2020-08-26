library(rgdal)
library(rgeos)
library(maptools)
library(ggplot2)
library(surveillance)
library(plyr)
library(latticeExtra)
library(raster)
library(surveillance)

setwd("~/Documents/Career/Skills/Statistics/modeling/nCoV2019/Korea_map/KOR_adm")
drv <- "ESRI Shapefile"
kmap <- readOGR(".", layer = "KOR_adm1")

### Try plot with ggplot2
#kmap2@data$id <- rownames(kmap2@data)
#kdata <- fortify(kmap2, region = "id")
#kd <- merge(kdata, kmap2@data, by = "id")
#head(kd)
#ggkd<- ggplot(kd, aes(x=long, y=lat, group = id, fill=id)) +
    #   geom_polygon() +
    #   scale_fill_hue(l = 40) +
    #  coord_equal() +
    #  theme(legend.position = "none", title = element_blank(),
    #   axis.text = element_blank())

#print(ggkd)


#############################################################
# simplify map to reduce size and speed up plotting
kmap1 <- gSimplify(kmap, tol=.01) # this changes the area of each of the 17 polygons object
kmap2<- SpatialPolygonsDataFrame(kmap1, kmap@data)
saveRDS(kmap2, "kmap2.RDS")

sapply(slot(kmap2, "polygons"), slot, "area") # check areas of each of 17 polygons

# spplot(kmap2) warning: factors need to have identical levels

# calculate the matrix of adjacency orders
korder <- nbOrder(poly2adjmat(kmap2), maxlag = 10)
saveRDS(korder, "korder.RDS")

################population data
#website:http://www.citypopulation.de/php/southkorea-admin.php
pdata<- read.csv("kpop.csv")
saveRDS(pdata, "pdata.RDS")
