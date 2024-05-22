#################################
# Load libraries
# List necessary packages
packages_list<-list("magrittr", "dplyr", "plyr", "this.path", "ggplot2", "raster", "terra", "sf", "pbapply")

# Install necessary packages not installed
packagesPrev<- .packages(all.available = TRUE)
lapply(packages_list, function(x) {   if ( ! x %in% packagesPrev ) { install.packages(x, force=T)}    })

# Load libraries
lapply(packages_list, library, character.only = TRUE)


# Set working directory
dir_work<- this.path::this.path() %>% dirname()
input_folder<- file.path(dir_work, "input")



prec.r<- rast("rem.tif")
prec.r.mean <- mean(prec.r)

restaRaster<- function (x,y) {x - y} #borrar


# raster test
prec.r_raster<- raster(prec.r)
prec.r.mean_raster <- mean(prec.r_raster)
prec.centrar_raster<- overlay (prec.r_raster ,  prec.r.mean_raster, fun=restaRaster) # si fueran raster

# terra test
restaRaster_terra<- function (x,y) {x - y}
prec.r_terra<- prec.r
prec.r.mean_terra <- mean(prec.r_terra)
prec.centrar_terra<- lapply(prec.r.mean_terra, function(x) restaRaster(x, prec.r_terra))
  
  

