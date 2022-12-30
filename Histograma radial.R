library(tidyverse) # Easily Install and Load the 'Tidyverse'
library(ggtext) # Improved Text Rendering Support for 'ggplot2'
library(rphylopic) # Get 'Silhouettes' of 'Organisms' from 'Phylopic'
library(cowplot) # Streamlined Plot Theme and Plot Annotations for 'ggplot2'
library(png) # Read and write PNG images

registers <- datacam

# Debido a que read_csv detecta que Time es una columna en formato tiempo, hay que convertirla a caracter para aplicar la funciÃ³n
registers$Time <- as.character(registers$Time)

# Esta funciÃ³n divide la columna de tiempo en horas, minutos y segundos y luego aplica la formula para transformar a horas decimales
registers$decimal <- sapply(strsplit(registers$Time,":"), function(x){
   x <- as.numeric(x)
   x[1]+x[2]/60+ x[3]/3600
}
)

## Filtramos la especie que nos interesa
zorrillo1 <- registers %>% 
   filter(Species == "rhea") # En este caso una especie de zorrillo.

ggplot(zorrillo1, aes(x = decimal))+ # Definimos la base de datos y el x
   geom_histogram(breaks = seq(0, 24), # en geometrÃ­a le decimos que un histograma con cortes de 0 a 24
                  fill="steelblue4", # El color de las barras
                  colour = "black", # El color del borde
                  size=0.3) # El tamaÃ±o del borde

ggplot(zorrillo1, aes(x = decimal))+ 
   geom_histogram(breaks = seq(0, 24), 
                  fill="steelblue4", 
                  colour = "black", size=0.3)+
   scale_x_continuous("", limits = c(0, 24), # Que se limite a 0 y 24
                      breaks = seq(0, 24), # Cortes de 0 a 24
                      labels = seq(0, 24)) # Que ponga cada hora

ggplot(zorrillo1, aes(x = decimal))+ 
   geom_histogram(breaks = seq(0, 24), 
                  fill="steelblue4", 
                  colour = "black", size=0.3)+
   scale_x_continuous("", limits = c(0, 24), 
                      breaks = seq(0, 24), 
                      labels = seq(0, 24))+
   annotate("rect", # Sombra de la noche
            xmin = c(18,0), xmax = c(24, 6.5), 
            ymin = 0, ymax = 220, 
            alpha=0.3, # Nivel de transparencia
            fill="grey25")+ 
   annotate("rect", #Sombra del dÃ­a
            xmin=6, xmax = 19,  # Coordenadas en x
            ymin = 0, ymax = 220, # Coordenadas en y
            alpha=0.3, fill="#FFD819") # Color

ggplot(zorrillo1, aes(x = decimal))+ 
   geom_histogram(breaks = seq(0, 24), 
                  fill="steelblue4", 
                  colour = "black", size=0.3)+
   scale_x_continuous("", limits = c(0, 24), 
                      breaks = seq(0, 24), 
                      labels = seq(0, 24))+
   annotate("rect", 
            xmin = c(18,0), xmax = c(24, 6.5),  
            ymin = 0, ymax = 220, 
            alpha=0.3, 
            fill="grey25")+ 
   annotate("rect",
            xmin=6, xmax = 19, 
            ymin = 0, ymax = 220, 
            alpha=0.3, fill="#FFD819")+
   labs(title="Registros de *Axis axis*", # TÃ­tulo
        y= "NÃºmero de registros") # Nombre eje y

ggplot(zorrillo1, aes(x = decimal))+ 
   geom_histogram(breaks = seq(0, 24), 
                  fill="steelblue4", 
                  colour = "black", size=0.3)+
   scale_x_continuous("", limits = c(0, 24), 
                      breaks = seq(0, 24), 
                      labels = seq(0, 24))+
   annotate("rect", 
            xmin = c(18,0), xmax = c(24, 6.5),  
            ymin = 0, ymax = 220, 
            alpha=0.3, 
            fill="grey25")+ 
   annotate("rect",xmin=6, xmax = 19, 
            ymin = 0, ymax = 220, 
            alpha=0.3, fill="#FFD819")+
   labs(title="Registros de *Axis axis*",
        y= "NÃºmero de registros")+
   coord_polar(start = 0) # Hacer circular el grÃ¡fico

plot <- ggplot(zorrillo1, aes(x = decimal))+ 
   geom_histogram(breaks = seq(0, 24), 
                  fill="steelblue4", 
                  colour = "black", size=0.3)+
   scale_x_continuous("", limits = c(0, 24), 
                      breaks = seq(0, 24), 
                      labels = seq(0, 24))+
   annotate("rect",
            xmin = c(18,0), xmax = c(24, 6.5),
            ymin = 0, ymax = 220,
            alpha=0.3,
            fill = "grey25")+
   annotate("rect", xmin=6, xmax = 19,
            ymin = 0, ymax = 220,
            alpha=0.3, fill = "#FFD819")+
   labs(title="Registros de *Rhea americana*",
        y= "NÃºmero de registros") +
   coord_polar(start = 0) +
   theme_minimal()+ # Tipo de tema para quitar el gris de fondo
   theme(text=element_text(size = 13, face = "bold"), # TamaÃ±o y letra en negrilla
         axis.title.x = element_text(margin = unit(c(2, 0, 0, 0), "mm")), # Margenes de x
         axis.title.y = element_text(margin = unit(c(0, 3, 0, 0), "mm")), # Margenes de y
         plot.title = element_markdown()) # Para  hacer la especie en itÃ¡lica

plot

sun <- readPNG("sun.png")
moon <- readPNG("moon.png")

plot2 <- ggdraw(plot)+
   draw_image(sun, x=0.50, y=0.20, # Coordenadas en x y del sol
              width=0.07, height=0.06)+ # Altura y ancho
   draw_image(moon, x=0.50, y=0.76, # Coordenadas en x y de la luna
              width=0.08, height=0.07, # Altura y ancho
              scale = 0.75) # Como la imÃ¡gen de la luna es algo mÃ¡s grande la escalamos para que iguale al sol

plot2
