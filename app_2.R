library(shiny)
library(ggplot2)

# Primer paso: creo solo la UI con un server vacío

library(shiny)
ui <- fluidPage(

    mainPanel(
      plotOutput("plot", hover = "click"), # hover para que al pasar el raton se devuelva información de los puntos
      dataTableOutput(outputId = "resultadoFiltro"),
    
    
  )
)




server <- function(input, output) {
  
  dataset <- reactiveVal({ # creamos un reactiveVal se utiliza para leer y escribir un valor y con programación reactiva
    data.frame(x=rnorm(100), y=rnorm(50)) #creo un data frame con numeros aleatorios
    })
  
  
  output$plot <- renderPlot({
    ggplot(dataset(),   #creo un gráfico ggplot
           aes(x=x, y=y)) +
      geom_point()
    })
  
  output$resultadoFiltro <- renderDataTable({ #Imprime una tabla
    nearPoints(df = dataset(), # dataset tiene qeu ir como función por reactividad
               coordinfo = input$click, #unión con UI. Devuelve las coordenadas al pasar el raton (hover)
               threshold = 5, #maxima distancia de deteccion en píxeles
               maxpoints = 2) # numero maximo de puntos en la tabla
  })

}

shinyApp(ui = ui, server = server)
