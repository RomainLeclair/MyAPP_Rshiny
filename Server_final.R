shinyServer=(function(input, output){
  
  
  
  climat_filtre= reactive({ # Permet de changer dynamiquement les résultats 
    
    
    
    
    mini= input$mes_dates[1]
    maxi= input$mes_dates[2]
    
    data_sel= climat %>% filter(Ville == input$mes_villes  & Annee %in% mini:maxi) # Permet de filtrer 
    
    return(data_sel)
    
    
  })
  
  output$mon_resultat = renderText({ # Rendertext affiche dynamiquement des sorties textes
    
    ville_sel= input$mes_villes
    
    
    moyenne_brouillard= mean(climat_filtre()$Nombre_de_jours_avec_brouillard, na.rm = TRUE)
    
    
    paste0("Le nombre moyen de jours de brouillard pour  ", ville_sel ," : ", round(moyenne_brouillard),0) # Affichage des résultats 
  })
  
  
  
  output$mon_tableau= renderDataTable({ # Le back du tableau 
    
    datatable(climat_filtre()[,c(1, 2, 5, 6, 12)]) # Selection des colonnes 
  })
  
  
  output$mon_graph <- renderAmCharts({ # Le back du graphiqye 
    
    data_graph <- data.frame(
      Annee = as.character(climat_filtre()$Annee),
      Precipitations = climat_filtre()$Quantite_totale_precipitations) # création jeu de données dynamiques 
    
    amSerialChart(dataProvider = data_graph, categoryField = "Annee") %>%
      addGraph(valueField = "Precipitations", type = "column", # affichage type graph
               fillAlphas = 1,
               lineColor = "#DD1C1A", fillColors = "#DD1C1A",
               balloonText =paste0("En " , "[[category]] : [[value]] mm"," à ", input$mes_villes)) %>% # Affichage dynamique 
      addTitle(text =paste0("Quantité totale de précipitations par an à  ", input$mes_villes , " pour les années ", input$mes_dates[1], "à ", input$mes_dates[2]) , # titre dynamique 
               size = 12, color = "#68838B") %>%
      setCategoryAxis(autoGridCount = FALSE, gridCount = dim(data_graph)[1], 
                      labelRotation = 90, fontSize = 8) %>%
      setExport(enabled = TRUE) # On autorise l'export 
    
    
    
  })
  
  
  output$ma_carte <- renderLeaflet({ # Back de la carte 
    
    mini1 <- input$mes_dates[1]
    maxi1 <- input$mes_dates[2]
    
    data_sel1 <- climat %>% filter(Annee %in% mini1:maxi1)
    
    climat_temperature_max <- data_sel1 %>% group_by(Ville) %>% # Filtre par ville 
      summarise(Latitude = first(Latitude),
                Longitude = first(Longitude),
                temperature_max = round(mean(Max_Temperature_annuelle_moyenne, na.rm = TRUE),2))
    
    couleurs <- colorNumeric("YlOrRd", climat_temperature_max$temperature_max, n = 5)
    
    m <- leaflet(climat_temperature_max) %>% # '~' Permet d'aller chercher dans la base 
      addTiles() %>%
      addCircles(lng = ~Longitude, lat = ~Latitude, weight = 1,
                 radius = ~(temperature_max) *5000 , popup = ~paste(Ville, ":", temperature_max, "°c"),
                 color = ~couleurs(temperature_max), fillOpacity = 0.5) %>%
      addLegend(pal = couleurs, values = ~temperature_max, opacity = 2,
                title = "Temperarture max ") 
    m
    
  })
  
  
  climat_filtre1 <- reactive({ # création nouveau filtre pour le pie 
    
    mini <- input$mes_dates[1]
    maxi <- input$mes_dates[2]
    
    data_sel <- climat %>% filter(Annee %in% mini:maxi) # Ici on ne filtre que les années 
    
    return(data_sel)
    
  })
  
  output$mon_pie <- renderAmCharts({
    
    data_graph1 <- na.omit(climat_filtre1()) %>% group_by(Ville) %>%
      select(Nombre_de_jours_avec_neige) %>%
      summarise(somme = sum(Nombre_de_jours_avec_neige)) # Base dynamique pour le pie 
    
  

    
    
    
    
    
    data_pie <- data.frame(
      label = data_graph1$Ville,
      value = data_graph1$somme)
    amPie(data = data_pie, # création du pie 
          main= paste0("Répartition du nombres de jours de neige pour chaque ville" ,  " pour les années ", input$mes_dates[1], " à ", input$mes_dates[2]), # titre dynamique 
          theme=c("dark"),
          export=TRUE)
    
  })
})  





