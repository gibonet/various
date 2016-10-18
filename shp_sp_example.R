
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

# The coordinates of the SpatialPolygonsDataFrame can be extracted and
# saved in a "tidy" data frame with ggplot2::fortify or broom::tidy
d <- broom::tidy(s)
str(d)

# In order to properly define regions, look at the data in the 
# SpatialPolygonsDataFrame (s)
str(s@data)

# Packages rgeos and maptools are needed
library(broom)
library(rgeos)
library(maptools)
d <- tidy(s, region = "id")

str(d)
head(d)

# Now the coordinates are in a data frame, that can be plotted for example
# with ggplot2 or ggvis. See some examples in shp_df_example.R

# One further step: adding all columns of the SpatialPolygonsDataFrame
# in the tidy data frame
library(dplyr)
d <- d %>% left_join(s@data, by = "id")

str(d)


# Note that shp_sp was tranformed in a list of data frames with the following
# commands (the first line can take quite a long time):
shp_df <- lapply(shp_sp, function(x) ggplot2::fortify(x, region = "id"))
for(i in seq_along(shp_df)){
  shp_df[[i]] <- left_join(shp_df[[i]], shp_sp[[i]]@data, by = "id")
}

# Since this takes quite a long time (about 10 minutes on my computer)
# I saved the list shp_df in file shp_df.rda in data folder.
