# Setup
library(ggplot2)
library(tidyr)
library(raster)

# Load data
climate <- getData('worldclim', var = 'bio', res = 2.5)
climate <- crop(climate, extent(-82, -34, -60, 15))
plot(climate)

# User precipitation data
raster <- climate$bio12
s_america <- rnaturalearth::ne_countries(continent = 'south america', returnclass = 'sf')
plot(s_america)

# Wrangle data
rasdf <- as.data.frame(raster, xy = TRUE) %>% drop_na()

head(rasdf)

# Plot
ggplot() +
  geom_raster(aes(x = x, y = y, fill = bio12), data = rasdf) +
  geom_sf(fill = 'transparent', data = s_america) +
  scale_fill_viridis_c(name = 'mm/year', direction = -1) +
  labs(x = 'Longitude', y = 'Lattitude',
       title = 'South America Climate Map',
       subtitle = 'Annual precipitation',
       caption = 'Source: WorldClim (2020)') +
  theme_classic() +
  theme(panel.grid.major = element_line(colour = 'black',
                                        linetype = 'dashed',
                                        size = 0.5),
        panel.grid.minor = element_blank(),
        panel.ontop = TRUE,
        panel.background = element_rect(fill = NA, colour = 'black'))
