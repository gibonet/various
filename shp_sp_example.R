
load("data/shp_sp.rda")

class(shp_sp)
length(shp_sp)

unique(sapply(shp_sp, class))

# Every element of the list is a SpatialPolygonsDataFrame
names(shp_sp)

# Give a look at one of these SpatialPolygonsDataFrames
s <- shp_sp[["g1k15"]]

library(sp)
str(s)

plot(s)
