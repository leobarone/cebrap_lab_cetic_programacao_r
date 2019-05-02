library(readr)
library(dplyr)
library(ggmap)
url_cadastro <- "http://dados.prefeitura.sp.gov.br/dataset/8da55b0e-b385-4b54-9296-d0000014ddd5/resource/8f37dbaf-dcbd-46cc-9e34-1b4802690485/download/escolasr34abril2017.csv"
download.file(url_cadastro, "base_cadastro.csv")
escolas <- read_delim(file = "base_cadastro.csv", delim = ";")
escolas <- rename(escolas, lat = LATITUDE, lon = LONGITUDE, tipo = TIPOESC)
escolas <- select(escolas, lat, lon, tipo)
escolas <- mutate(escolas, lat = lat / 1000000, lon = lon / 1000000)
escolas <- filter(escolas, tipo == "EMEI")
bbox_sp <- c(left = -46.869803,
             bottom = -23.774462,
             right = -46.4417181,
             top = -23.3921176)
map_sp <- get_stamenmap(bbox_sp, zoom = 12, maptype = "toner")
ggmap(map_sp) +
  geom_point(aes(lon, lat), data = escolas, colour = "darkred")
