##################################### ANÁLISIS DE CÁMARAS TRAMPA ####
rm(list = ls())

library(camtrapR)
library(lubridate)
library(overlap)
library(readr)
library(tidyr)
library(dplyr)
library(tidyverse) 
library(ggtext) 
library(rphylopic)
library(cowplot) 
library(png) 

setwd("C:/Users/silvi/OneDrive/Escritorio/Ilán/Tesis/Archivos_R")
getwd()


datastation <- read.csv("datastation_final.csv", header = TRUE, sep = ",") 


# 3? Usando exiftool y recordTable() genero mi tabla con los metadatos de mis 
# fotos previamente etiquetadas con DigiKam. Si las etiquet? con ExifPro el 
# programa directamente genera la tabla, la subo a R como csv.


## Le voy a decir a R donde estan los datos de mi estudio
#miestudio <-createStationFolders(inDir = "M1",
#                                 stations = as.character(datastation$Station),
#                                 createinDir = FALSE)
# Le digo que no me genere carpetas de estaciones en mi computadora poniendo 
# FALSE, porque ya est?n armadas de antemano.

exiftooldir <- "D:/TESIS/Archivos_R"  #Justo lo puse en el mismo directorio
exiftoolPath(exiftooldir)
#Ahora que tengo exiftool puede leer la metadata de las fotos.

##################################### CERRAR - CORRECCIÓN DE FECHA Y HORA DE LAS FOTOS #######


### Pruebo hacerlo para cada c?mara del M1: (s?lo hay que corregir la 3)

#timeShift_M1C3 <- read.csv("timeShift_M1C3.csv",header = TRUE, sep = ";")
#Ac? corrijo porque se carg? mal el nombre de la columna
#timeShift_M1C3 <- rename(timeShift_M1C3, Station = ?..Station )


#fotos_correcM1C3 <- file.path("cambio_fechaM1C3")
#fotos_corregidasM1C3 <- timeShiftImages(inDir= fotos_correcM1C3,
#                                    timeShiftTable = timeShift_M1C3,
#                                    stationCol= "Station",
#                                    hasCameraFolders = FALSE,
#                                    timeShiftColumn = "timeshift",
#                                    timeShiftSignColumn = "sign"
#                                    )

## Ahora corrijo el resto de los muestreos, de a una c?mara a la vez:

#timeShift_M2C7 <- read.csv("timeShift_M2C7.csv",header = TRUE, sep = ";")
#timeShift_M2C7 <- rename(timeShift_M2C7, Station = ?..Station )

#timeShift_M3C7 <- read.csv("timeShift_M3C7.csv",header = TRUE, sep = ";")
#timeShift_M3C7 <- rename(timeShift_M3C7, Station = ?..Station )

#timeShift_M4C7 <- read.csv("timeShift_M4C7.csv",header = TRUE, sep = ";")
#timeShift_M4C7 <- rename(timeShift_M4C7, Station = ?..Station )

#timeShift_M5C7 <- read.csv("timeShift_M5C7.csv",header = TRUE, sep = ";")
#timeShift_M5C7 <- rename(timeShift_M5C7, Station = ?..Station )

#timeShift_M6C7 <- read.csv("timeShift_M6C7.csv",header = TRUE, sep = ";")
#timeShift_M6C7 <- rename(timeShift_M6C7, Station = ?..Station )

### Muestreo 2, c?mara 7:
#fotos_correcM2C7 <- file.path("cambio_fechaM2C7")
#fotos_corregidasM2C7 <- timeShiftImages(inDir= fotos_correcM2C7,
#                                        timeShiftTable = timeShift_M2C7,
#                                        stationCol= "Station",
#                                        hasCameraFolders = FALSE,
#                                       timeShiftColumn = "timeshift",
#                                        timeShiftSignColumn = "sign"
#)

## M#uestreo 3, c?mara 7:
#fotos_correcM3C7 <- file.path("cambio_fechaM3C7")
#fotos_corregidasM3C7 <- timeShiftImages(inDir= fotos_correcM3C7,
#                                        timeShiftTable = timeShift_M3C7,
#                                        stationCol= "Station",
#                                        hasCameraFolders = FALSE,
#                                        timeShiftColumn = "timeshift",
#                                        timeShiftSignColumn = "sign"
#)

## Muestreo 4, c?mara 7:
#fotos_correcM4C7 <- file.path("cambio_fechaM4C7")
#fotos_corregidasM4C7 <- timeShiftImages(inDir= fotos_correcM4C7,
#                                        timeShiftTable = timeShift_M4C7,
#                                        stationCol= "Station",
#                                        hasCameraFolders = FALSE,
#                                        timeShiftColumn = "timeshift",
#                                        timeShiftSignColumn = "sign"
#)

## Muestreo 5, c?mara 7: 
#fotos_correcM5C7 <- file.path("cambio_fechaM5C7")
#fotos_corregidasM5C7 <- timeShiftImages(inDir= fotos_correcM5C7,
#                                        timeShiftTable = timeShift_M5C7,
#                                        stationCol= "Station",
#                                        hasCameraFolders = FALSE,
#                                        timeShiftColumn = "timeshift",
#                                        timeShiftSignColumn = "sign"
#)

## Muestreo 6, c?mara 7: 
#fotos_correcM6C7 <- file.path("cambio_fechaM6C7")
#fotos_corregidasM6C7 <- timeShiftImages(inDir= fotos_correcM6C7,
#                                        timeShiftTable = timeShift_M6C7,
#                                        stationCol= "Station",
#                                        hasCameraFolders = FALSE,
#                                        timeShiftColumn = "timeshift",
#                                        timeShiftSignColumn = "sign"
#)


##################################### CERRAR - DATACAM - TABLA DE IMÁGENES/ESPECIES ######

datacam <- recordTable(inDir = "M_todas",
                      IDfrom = "directory",
                      outDir = "D:/TESIS/Archivos_R",
                      minDeltaTime = 60,  # datos independientes definidos cada 60 min. POR DEFINIR
                      timeZone = "America/Montevideo",
                      writecsv = T) #Acá le puedo poner T para que me descargue el .CSV
datacam$DateTimeOriginal <- as.factor(datacam$DateTimeOriginal)

##################################### CERRAR - DATACAM2 - TABLA DE IMÁGENES/ESPECIES ######
# Armé estas líneas para que no me tenga que leer todas las fotos cada vez que corro el scipt!!! #
datacam <- read.csv("datacam.csv", 
                     header = T,
                     sep = ",",
                     row.names = 1)
datacam$DateTimeOriginal <- as.factor(datacam$DateTimeOriginal)

##################################### DATACAM3 PARA FILTRAR ####
datacam_muestreo <- read.csv("datacam_muestreo.csv", 
                    header = T,
                    sep = ";",
                    row.names = 1)
datacam_muestreo$DateTimeOriginal <- as.factor(datacam_muestreo$DateTimeOriginal)

datacam_abril <- datacam_muestreo[datacam_muestreo$Muestreo %in% c("ab17","ab18"),]
datacam_julio <- datacam_muestreo[datacam_muestreo$Muestreo %in% c("jl17","jl18"),]
datacam_verano <- datacam_muestreo[datacam_muestreo$Muestreo %in% c("nv17","fb18","di18"),]


##################################### CERRAR - Comentarios y demás cosas ###############
#ACLARACIONES:
# - IDfrom puedo poner directory si salen de carpetas o metadata si son fotos
#   etiquetadas (y tengo que agregar abajo:  metadataSpeciesTag = "Species")
# - inDir = es la carpeta (por ejemplo el muestreo 1) que contiene subcarpetas 
#           de cada estaci?n de muestreo, que tienen las fotos adentro.
# - Si pongo FALSE en el comando wrtitecsv no lo guarda como csv, solo me 
#   aparece dentro de R como un objeto llamado datacam
# - Con diferentes comandos puedo modificar esta tabla para focalizarme en ciertas
#   especies o para que tome un determinado tiempo entre fotos para considerarlas
#   independientes, etc. 

### Una vez que tengo toda mi data cargada la preparo y comienzo a analizar ###


# Ambas tablas deben estar en formato dataframe
#datacam$DateTimeOriginal <- as.character(datacam$DateTimeOriginal)
#datacam <- as.data.frame(datacam)
#datastation <- as.data.frame(datastation)
# Es bueno que la columna de Estaci?n en ambas tablas est? nombrada igual, 
# porque es la que los vincula. 

# Corrijo el formato de la fecha y la hora para que tambi?n coincida: 

#datastation$Setup <- as.character(datastation$Setup)
#datastation$Setup <- as.Date(datastation$Setup, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"))

#datastation$Retrieval <- as.character(datastation$Retrieval)
#datastation$Retrieval <- as.Date(datastation$Retrieval, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"))

##################################### CERRAR - CAM.OP No funciona ###################
# Una vez pronto todo, puedo crear el "cam.op", que va a contener todo sobre el 
# funcionamiento de las c?maras para hacer los c?lculos.
cam.op <- cameraOperation(CTtable = datastation,
                          stationCol = "Station",
                          setupCol = "Setup",
                          retrievalCol = "Retrieval",
                          writecsv = F,
                          hasProblems = F,
                          dateFormat = "%Y-%m-%d")

#NO PUEDE HABER CELDAS CON NA, las reemplazo por 0:

cam.op %>% is.na() %>% table() #me dice cu?ntos valores son NA.

#cam.op %>% replace_na() #No lo pude hacer andar
#yo, Isabel, pruebo otra forma de reemplazar los nas.
cam.op[is.na(cam.op)] = 0
cam.op <- data.frame(cam.op)
##################################### Activity histogram ###################################
hist.activ.all <- activityHistogram (recordTable = datacam_muestreo, 
                                    recordDateTimeCol = "DateTimeOriginal" ,
                                    species = "axis",
                                    allSpecies = FALSE,
                                    plotR = TRUE)

# activityHistogram es la funci?n que va a mirar los datos en mi recordTable 
#que se llama datacam, mirando la columna Time, para todas las especies

## Activity Density Plot based on Kernel Density Estimation of Diel Activity
ActDens.all <- activityDensity(recordTable = datacam_muestreo, 
                               allSpecies = TRUE,
                               writePNG = FALSE, #le puse TRUE una vez para tener los gráficos en mi compu
                               #plotDirectory = "D:/TESIS/Densidad_actividad",
                               recordDateTimeCol = "DateTimeOriginal")

# activityDensity es la funci?n que va a mirar los datos en mi recordTable que 
#se llama datacam, mirando las columnas Time y Species, para todas las especies. 
#Las dem?s opciones son que me muestre el gr?fico y que me lo guarde como im?gen.

##################################### ACTIVITY DENSITY ##################################################
## Gr?ficos de actividad para diferentes especies:

ActDens.axis <- activityDensity(recordTable = datacam,
                               species = "axis",
                               allSpecies = FALSE,
                               writePNG = FALSE,
                               recordDateTimeCol = "DateTimeOriginal")

ActDens.zorro <- activityDensity(recordTable = datacam,
                                species = "canidae",
                                allSpecies = FALSE,
                                writePNG = FALSE,
                                recordDateTimeCol = "DateTimeOriginal")

ActDens.cingulata <- activityDensity(recordTable = datacam,
                                     species = "cingulata",
                                     allSpecies = FALSE,
                                     writePNG = FALSE,
                                     recordDateTimeCol = "DateTimeOriginal")

ActDens.carpincho <- activityDensity(recordTable = datacam,
                                 species = "hydrochoerus",
                                 allSpecies = FALSE,
                                 writePNG = FALSE,
                                 recordDateTimeCol = "DateTimeOriginal")

ActDens.leopardus <- activityDensity(recordTable = datacam,
                                     species = "leopardus",
                                     allSpecies = FALSE,
                                     writePNG = FALSE,
                                     recordDateTimeCol = "DateTimeOriginal")

ActDens.corzuela <- activityDensity(recordTable = datacam,
                                     species = "mazama",
                                     allSpecies = FALSE,
                                     writePNG = FALSE,
                                     recordDateTimeCol = "DateTimeOriginal")

ActDens.niandu <- activityDensity(recordTable = datacam,
                                    species = "rhea",
                                    allSpecies = FALSE,
                                    writePNG = FALSE,
                                    recordDateTimeCol = "DateTimeOriginal")

ActDens.jabali <- activityDensity(recordTable = datacam,
                                  species = "sus",
                                  allSpecies = FALSE,
                                  writePNG = FALSE,
                                  recordDateTimeCol = "DateTimeOriginal")

##################################### OVERLAP ##############################################
# Solapamiento temporal entre especies
library(overlap)

speciesA_for_activity <- "axis"
speciesB_for_activity <- "mazama"

activityOverlap (recordTable = datacam,
                 speciesA = "axis",
                 speciesB = "mazama",
                 writePNG = FALSE,
                 #plotDirectory = "D:/TESIS/Overlap", #estas fila y la de arriba le puse TRUE para que me descargue la foto en mi compu
                 plotR = TRUE,
                 createDir = FALSE,
                 pngMaxPix = 1000,
                 linecol = c("red", "blue"),
                 linewidth = c(3,3),
                 add.rug = TRUE, 
                 recordDateTimeCol = "DateTimeOriginal")

# Para eso lo primero que hago es definir dentro de objetos, cuáles son los nombres de mis especies de interés, para que luego la función activityOverlap las identifique dentro de mi objeto datacam.

##################################### ACTIVITY RADIAL ################
Act.Rad.Todas <- activityRadial(recordTable = datacam, 
                               #species = "axis",
                               allSpecies = TRUE,
                               recordDateTimeCol = "DateTimeOriginal",
                               byNumber = FALSE,
                               plotR = TRUE, 
                               writePNG = F,
                               #plotDirectory = "D:/TESIS/Radial_actividad",
                               #rp.type = "r",
                               #grid.bg = "red",
                               lwd = 2)

##################################### HISTOGRAMA RADIAL!! ####
registers <- datacam_muestreo #Acá el script original llama "registers" a nuestro datacam. Decidí dejarlo así porque toca algunas cosas de la tabla y así no me modifica datacam.

# Debido a que read_csv detecta que Time es una columna en formato tiempo, hay que convertirla a caracter para aplicar la función
registers$Time <- as.character(registers$Time)

# Esta función divide la columna de tiempo en horas, minutos y segundos y luego aplica la formula para transformar a horas decimales
registers$decimal <- sapply(strsplit(registers$Time,":"), function(x){
   x <- as.numeric(x)
   x[1]+x[2]/60+ x[3]/3600})

sun <- readPNG("sun.png")
moon <- readPNG("moon.png")

## Filtramos la especie que nos interesa
especie1 <- registers %>% 
   filter(Species == "axis") #ESPECIE QUE QUIERO

ymax = 2000

(plot_blanco <- ggplot(especie1, aes(x = decimal)) + 
      geom_histogram(breaks = seq(0, 24),
                     #aes(y = stat(count / sum(count))), #Esta línea me pone el eje y en proporción
                     fill = "steelblue4",
                     colour = "black", 
                     size = 0.3) +
      scale_x_continuous("", limits = c(0, 24), breaks = seq(0, 24), labels = seq(0, 24)) +
   labs(title = "Registros de *Axis axis*", 
        #subtitle = "En los muestreos de jl17 y jl18", #NOMBRE DE LA ESPECIE QUE QUIERO
        y = "Número de registros") +
   coord_polar(start = 0) +
   theme_minimal() + # Tipo de tema para quitar el gris de fondo
   theme(text = element_text(size = 13, face = "bold"), # Tamaño y letra en negrilla
         axis.title.x = element_text(margin = unit(c(2, 0, 0, 0), "mm")), # Margenes de x
         axis.title.y = element_text(margin = unit(c(0, 3, 0, 0), "mm")), # Margenes de y
         plot.title = element_markdown()) # Para  hacer la especie en itálica
   )

(plot_color <- plot_blanco +
   annotate("rect", #Sombreado gris
            xmin = c(18,0), xmax = c(24, 6.5),
            ymin = 0, ymax = ymax, #VARIAR EL VALOR DE YMAX CON LA ESPECIE
            alpha = 0.3, fill = "grey25") + 
   annotate("rect", #Sombreado amarillo
            xmin = 6, xmax = 19,
            ymin = 0, ymax = ymax, #VARIAR EL VALOR DE YMAX CON LA ESPECIE
            alpha = 0.3, fill = "#FFD819"))

ggdraw(plot_color) +
   draw_image(sun, x = 0.493, y = 0.20, # Coordenadas en x y del sol
              width = 0.07, height = 0.06) + # Altura y ancho
   draw_image(moon, x = 0.49, y = 0.76, # Coordenadas en x y de la luna
              width = 0.08, height = 0.07, # Altura y ancho
              scale = 0.75) # Como la imágen de la luna es algo más grande la escalamos para que iguale al sol

##################################### Histograma radial con superposición ##################
registers <- datacam_muestreo #ACÁ HAY QUE CAMBIAR EL DATACAM QUE QUIERO
registers$Time <- as.character(registers$Time)
registers$decimal <- sapply(strsplit(registers$Time,":"), function(x){
   x <- as.numeric(x)
   x[1]+x[2]/60+ x[3]/3600})

sun <- readPNG("sun.png")
moon <- readPNG("moon.png")

especie1 <- registers %>% filter(Species == "mazama")
especie2 <- registers %>% filter(Species == "rhea")
especies = rbind(especie1,especie2)

(plot_blanco <- ggplot(especies, aes(x = decimal, fill = Species)) + 
      geom_histogram(breaks = seq(0, 24),
                     #aes(y = stat(count / sum(count))), 
                     #No funcionó agregar esta línea porque me lo divide por la suma de toda la columna 
                     #y yo quiero que me divida los de Axis por len(df[Species == "Axis"]) y la de mazama 
                     #por len(df[Species=="Mazama"]) (sorry lo puse en python, pero se entiende)
                     colour = "black", 
                     #alpha = 0.5,
                     size = 0.3) +
      scale_x_continuous("", limits = c(0, 24), 
                         breaks = seq(0, 24), 
                         labels = seq(0, 24)) +
      scale_fill_manual(values = c("blue", "red")) +
      labs(title = "Registros de *Rhea Americana* y *Mazama Gouarzoubira*", #NOMBRE DE LA ESPECIE QUE QUIERO
           y = "Número de registros") +
      coord_polar(start = 0) +
      theme_minimal() + # Tipo de tema para quitar el gris de fondo
      theme(text = element_text(size = 13, face = "bold"), # Tamaño y letra en negrilla
            axis.title.x = element_text(margin = unit(c(2, 0, 0, 0), "mm")), # Margenes de x
            axis.title.y = element_text(margin = unit(c(0, 3, 0, 0), "mm")), # Margenes de y
            plot.title = element_markdown()) # Para  hacer la especie en itálica
   )

(plot_color <- plot_blanco +
      annotate("rect", #Sombreado gris
               xmin = c(18,0), xmax = c(24, 6.5),
               ymin = 0, ymax = 2000, #VARIAR EL VALOR DE YMAX CON LA ESPECIE
               alpha = 0.3, fill = "grey25") + 
      annotate("rect", #Sombreado amarillo
               xmin = 6, xmax = 19,
               ymin = 0, ymax = 2000, #VARIAR EL VALOR DE YMAX CON LA ESPECIE
               alpha = 0.3, fill = "#FFD819"))

ggdraw(plot_color) +
   draw_image(sun, x = 0.45, y = 0.20, # Coordenadas en x y del sol
              width = 0.07, height = 0.06) + # Altura y ancho
   draw_image(moon, x = 0.45, y = 0.76, # Coordenadas en x y de la luna
              width = 0.08, height = 0.07, # Altura y ancho
              scale = 0.75) # Como la imágen de la luna es algo más grande la escalamos para que iguale al sol
