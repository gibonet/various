
load("data/shp_df.rda")

class(shp_df)
length(shp_df)

unique(sapply(shp_df, class))

# Every element of the list is a data frame
names(shp_df)

# Give a look of one of these data frames
d <- shp_df[["g1k15"]]

str(d)
head(d)

# These are the coordinates (lon and lat) of swiss cantons (in 2015)

# These can be plotted for example with ggplot2
library(ggplot2)

p <- ggplot(data = d, aes(x = long, y = lat, group = group))

p + geom_path() + coord_equal()

