#Packages--------------------------------------------------------------------------------------
library(shiny)
#data

naissance_france <- readRDS(file = "datas/naissances_france.rds")
naissance_region <- readRDS(file = "datas/naissances_region.rds")