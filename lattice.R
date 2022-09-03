# Load libraries
library(lattice)

# Load data
data(environmental)

# Plot ozone and radiation relationship
xyplot(ozone ~ radiation, data = environmental, main = "Ozone vs. Radiation")

# Plot ozone and radiation relationship, faceted by temperature
temp_cut <- equal.count(environmental$temperature, 4)

xyplot(ozone ~ radiation | temp_cut, 
       data = environmental, layout = c(1, 4), 
       as.table = TRUE,
       pch = 20,
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         fit <- lm(y ~ x)
         panel.abline(fit, lwd = 2)
       }, xlab = "Solar Radiation", ylab = "Ozone (ppb)",
       main = "Ozone vs. Solar Radiation")

# Plot ozone and radiation relationship, faceted by temperature and wind
wind_cut <- equal.count(environmental$wind, 4)

xyplot(ozone ~ radiation | temp_cut * wind_cut, 
       data = environmental, 
       as.table = TRUE,
       pch = 20,
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         fit <- lm(y ~ x)
         panel.abline(fit, lwd = 2)
       }, xlab = "Solar Radiation", ylab = "Ozone (ppb)",
       main = "Ozone vs. Solar Radiation")

# Save png
png(filename = "ozone-and-solar-radiation.png", width = 600, height = 600)

# Basic histogram
histogram(~ ozone | temp_cut * wind_cut, data = environmental)
