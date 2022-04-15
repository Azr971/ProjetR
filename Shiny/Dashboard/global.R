#Packages--------------------------------------------------------------------------------------
library(shiny)
library(apexcharter)
library(shinyWidgets)
library(dplyr)
#data

naissance_france <- readRDS(file = "datas/naissances_france.rds")
naissance_region <- readRDS(file = "datas/naissances_region.rds")
naissance_departement <- readRDS(file = "datas/naissances_departement.rds")

contour_regions <- readRDS(file = "datas/contour_regions.rds")
contour_departement <- readRDS(file = "datas/contour_departements.rds")