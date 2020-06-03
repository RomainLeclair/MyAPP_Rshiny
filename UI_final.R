shinyUI=(fluidPage(theme = shinytheme("yeti"), # On change le thème de l'interface
                   titlePanel("Analyse du climat en France"), # Nom de l'interface 
                   
                   sidebarLayout(
                     sidebarPanel("Choix de la Ville", # Permet de sélectionner les villes 
                                  
                                  selectInput(inputId = "mes_villes",
                                              label = "Selectionner une ville :",
                                              choices = list("Nantes"="Nantes",
                                                             "Nice"="Nice",
                                                             "Lille"="Lille",
                                                             "Clermont-Ferrand"="Clermont-Ferrand"),
                                              selected = 1), # On laisse qu'une possibilité de choix
                                  
                                  
                                  sliderInput(inputId = "mes_dates",label = "Slider",min = 1973,max = 2016,
                                              value = c(1973,2016)), # Bouton pour sélectionner notre plage de date 
                                  submitButton("Valider !") # Valider le choix avant modification 
                     ),
                     mainPanel(h2("Resultat"), # Nom du cadre où seront les résultats
                               
                               tabsetPanel(id="mes onglets", # Permet d'ajouter des onglets à notre panneau d'affichage 
                                           tabPanel("Texte", textOutput("mon_resultat")),
                                           tabPanel("Tableau",dataTableOutput("mon_tableau")),
                                           tabPanel("Graphique",amChartsOutput("mon_graph")),
                                           tabPanel("Carte",leafletOutput("ma_carte")),
                                           tabPanel("Episode Neigeux", amChartsOutput("mon_pie"))
                                           
                               )
                     )
                     
                     
                   )
))

