
library(jsonlite)
library(leaflet)
library(sp)


updateGeo <- function(){
  geojson <- readLines("https://wanderdrone.appspot.com/", warn = FALSE) %>%
    paste(collapse = "\n") %>%
    fromJSON(simplifyVector = FALSE)
  
  return(geojson)

}

repeat{
leaflet() %>%
  addTiles() %>%
  addGeoJSON(geojson)

geojson <- updateGeo()
Sys.sleep(5)
}
  



