rm(list = ls())

load("data/shp_df.rda")

class(shp_df)
length(shp_df)

unique(sapply(shp_df, class))

# Every element of the list is a data frame
names(shp_df)

# Give a look at one of these data frames
d <- shp_df[["g1k15"]]

str(d)
head(d)

# These are the coordinates (lon and lat) of swiss cantons (in 2015)

# These can be plotted for example with ggplot2
library(ggplot2)

p <- ggplot(data = d, aes(x = long, y = lat, group = group))

p + geom_path() + coord_equal()


# From that, polygons can be filled with colors, by adding a geom_polygon layer:
p + geom_path() + coord_equal() + geom_polygon(aes(fill = KTNAME), alpha = 0.5)

# Or, geocoded data can be added on the map (with geom_point or other types of layers, as geom_density2d, geom_hexbin, ...)


# The coordinates can be plotted with ggvis too:
library(ggvis)
library(dplyr)  # for group_by (and %>%)
d %>%
  group_by(group) %>%
  ggvis(x = ~long, y = ~lat) %>%
  layer_paths() %>%
  set_options(keep_aspect = TRUE)

# Filling polygons by the maximum altitude
d %>%
  group_by(group) %>%
  ggvis(x = ~long, y = ~lat) %>%
  layer_paths(fill = ~Z_MAX) %>%
  set_options(keep_aspect = TRUE)

# With "little" interactivity
d %>%
  group_by(group) %>%
  ggvis(x = ~long, y = ~lat) %>%
  layer_paths(fill = ~Z_MAX) %>%
  set_options(keep_aspect = TRUE) %>%
  hide_axis("x") %>% hide_axis("y") %>% 
  handle_click(on_click = function(data, ...) {print(data)})
# I took this last example from this link (the handle_click line):
# # http://www.alshum.com/ggvis-maps/


# plotly::ggplotly()
p2 <- ggswissmaps::maps2_(d)
p2 + geom_polygon(aes(fill = KTNAME), alpha = 0.5) + 
  theme(legend.position = "none")
plotly::ggplotly()

centroidi_cantoni <- d %>%
  group_by(KTNAME) %>%
  distinct(X_CNTR, Y_CNTR)

geom_list <- list(
  geom_path(data = d, 
            aes_string(x = "long", y = "lat", group = "group")),
  geom_polygon(data = d, 
               aes(x = long, y = lat, group = group, fill = Z_MAX), 
               colour = "white"),
  geom_text(aes_(x = ~X_CNTR, y = ~Y_CNTR, label = ~KTNAME),
            data = centroidi_cantoni),
  coord_equal(),
  ggswissmaps::theme_white_f()
)
p3 <- ggplot() + geom_list
p3

plotly::ggplotly(p = p3)


