# Mapeando Número de bikes em Paris


library(ggmap)
library(ggplot2)

# Obtendo os dados
url <- "http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte3/paris.zip"
arquivo <- "paris.zip"
download(url, arquivo)
unzip("paris.zip")

# Gerando o dataframe
df2 <- read.csv("paris.txt", sep = ",", header = T) 
str(df)
dim(df)

# Criando o mapa
map.paris <- qmap("paris", source="stamen", zoom=12, maptype="toner", darken=c(.3, "#BBBBBB")) 

# Unindo mapa e camada de dados
map.paris +
  geom_point(data = df2, aes(x = longitude, y = latitude, 
                             size = available_bike_stands, 
                             color = available_bike_stands), 
             alpha = .9, na.rm = T) +
  scale_color_gradient(low = "#33CC33", high = "#003300", name = "Número de Bikes disponiveis") +
  scale_size(range=c(1,11) , guide="none") + 
  ggtitle("Numero de bikes em Paris") +
  theme(text = element_text(family = "Trebuchet MS", color = "#666666")) +
  theme(plot.title = element_text( size = 32, face = "bold", hjust = 0, vjust = .5))
