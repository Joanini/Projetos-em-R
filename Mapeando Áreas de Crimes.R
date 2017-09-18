# Mapeando Áreas de Crimes

install.packages('downloader')
library(ggmap)
library(downloader)
library(ggplot2)

# Download e unzip do arquivo
url <- 'http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte3/crimes.zip'
arquivo <- 'crimes.zip'
download(url, arquivo)
unzip('crimes.zip')

# Criando o dataframe
df <- read.csv('crimes.txt')
head(df)
str(df)
dim(df)

# Criando o pot
mapa <- qmap('seattle', zoom = 11, source = 'stamen',
             maptype = 'toner', darken = c(.3,"#BBBBBB"))

mapa

# Mapeando os dados
mapa + geom_point(data = df, aes(x = Longitude, y = Latitude))


# Mapeando os dados e ajustando a escala
mapa + geom_point(data=df, aes(x = Longitude, y = Latitude),
                  color = 'dark green', alpha = .03, size = 1.1)

# Mapeando os dados e definindo uma camada de intensidade
mapa +
  stat_density2d(data = df, aes(x = Longitude, y = Latitude,
                                color = ..density..,
                                size = ifelse(..density..<=1,0,..density..),
                                alpha= ..density..), geom = 'tile',contour = F)+
  scale_color_continuous(low = 'orange', high='red',guide = 'none')+
  scale_size_continuous(range = c(0,3),guide = 'none')+
  scale_alpha(range = c(0,.5), guide ='none')+
  ggtitle("Crimes em Seattle")+
  theme(plot.title = element_text(family = 'Trebuchet MS', size = 
                                    36, face = 'bold', hjust = 0))
  
