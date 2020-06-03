##### Instalation packahe R shiny et autres utile ####

library(shiny)
library(tidyr)
library(dplyr)
library(DT)
library(rAmCharts)
library(leaflet)
library(shinythemes)
library(colourpicker)
library(shinyBS)
library(shinyWidgets)
library(shinydashboard)
library(rsconnect)

climat= read.csv(file = "Climat.csv",header = TRUE, sep = ";",na.strings = "-")



Application_Leclair_Romain=shinyApp(ui=shinyUI, server=shinyServer)
runApp(Application_Leclair_Romain, display.mode = "showcase")



