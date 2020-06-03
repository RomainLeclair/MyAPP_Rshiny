library(shinydashboard)

shinyUI=dashboardPage(skin = "red", # personnalisation du thème
              
              # En-tête
              dashboardHeader(title = "Analyse Climat  Fr "),
              
              # Barre de menu
              dashboardSidebar(
                
                # Menu avec la liste des onglets
                sidebarMenu(
                  
                  menuItem("Resultat Textuel", tabName = "onglet1", icon = icon("ad")),
                  menuItem("Tableau", tabName = "onglet2", icon = icon("table")),
    
                  
                  menuItem("Graphique", tabName = "onglet3", icon = icon("eye"),
                           menuSubItem("Barplot", tabName = "test1", icon = icon("chart-bar")),
                           menuSubItem("Pie", tabName = "test2", icon = icon("chart-pie"))),
                  menuItem("Carte", tabName = "onglet4", icon = icon("map")),
                  
                  
                  sidebarPanel("Param�tres modifiables" ),
                  selectInput(inputId = "mes_villes",
                              label = "Selectionner une ville :",
                              choices = list("Nantes"="Nantes",
                                             "Nice"="Nice",
                                             "Lille"="Lille",
                                             "Clermont-Ferrand"="Clermont-Ferrand"),
                              selected = 1),
                  sliderInput(inputId = "mes_dates",label = "Slider",min = 1973,max = 2016,
                              value = c(1973,2016))
                  
                  
                  
                  
                )
              ),
              
              # "Corps" = contenu / sorties
              dashboardBody(
                
                # Contenu de chacun des onglets
                tabItems(
                  
                  tabItem(tabName = "onglet1",
                
                          
                          fluidRow(
                            
                            column(width = 12,
                                   
                                   box(id = "res2", title = "Nombre de jours de Pluie", 
                                       status = "info", solidHeader = TRUE, collapsible = TRUE,
                                       textOutput(outputId = "mon_resultat"))     
                                   
                            )
                            
                          )
                          
                  ),
                  
                  
                  tabItem(tabName = "onglet2",
                          
                          
                          
                          fluidRow(
                          
                          h2("Tableau"), dataTableOutput("mon_tableau"))),
                  
                  tabItem(tabName = "test1",
                         
                          
                          fluidRow(
                          
                          h2("Barplot"), amChartsOutput("mon_graph"))),
                          
                  
                  tabItem(tabName = "test2",
                          
                        h2("Pie"),amChartsOutput("mon_pie")),
                  
                  
                  tabItem(tabName = "onglet4",
                          
                          h2("Carte"),leafletOutput("ma_carte"))
                  
                )
                
                
              )
)
