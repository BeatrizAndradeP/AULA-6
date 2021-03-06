# Econometria Avan�ada A6

install.packages("readxl") #instalando o pacote readxl
library(readxl) #rodando o pacote readxl
install.packages("ggplot2") #instalando o pacote ggplot2
library(ggplot2) #rodando o p�cote ggplot2
IPCA <- read_excel("C:/Econometria/IPCA.xls") #Mostra o arquivo excel IPCA salvo na Rede
IPCA <- IPCA[,-1] #exclui a primeira coluna da tabela
Infla��o <- ts(IPCA$IPCA, start = 2008-01, frequency = 12) #cria uma s�rie temporal Infla��o
View(Infla��o) # Visualizar os dados sobre a infla��o
write.csv(Infla��o,file = "Infla��o.csv")
autoplot(Infla��o, main="�ndice de Pre�os ao Consumidor Amplo") #novo comando para criar gr�ficos
plot(Infla��o, main="�ndice de Pre�os ao Consumidor Amplo") #cria uma gr�fico comum quando o autoplot n�o funciona

# Informa��es Sobre o Resumo Estat�stico

Resumo_Estat�stico <- summary(Infla��o) #cria um resumo estat�stico para Infla��o
Resumo_Estat�stico #vizualiza o resumo estat�stico

# Criando Analises FAC e FACP, com os dados informadis

acf(IPCA) #cria um gr�fico FAC para o IPCA
pacf(IPCA) #cria uma gr�fico FACP para o IPCA

# Modelos Autoregressivos e de M�dias M�veis

AR1 <- arima(Inflacao, order = c(1,0,0)) #modelo auto regressivo de ordem 1
AR1
MA3 <- arima(Inflacao,order=c(0,0,3)) #modelo de m�dias m�veis de ordem 3
MA3
ARMA13 <- arima(Inflacao,order = c(1,0,3)) #jun��o da AR com a MA
ARMA13
ARMA13$residuals #gera os res�duos da ARMA

# Teste de Ljung-Box - Teste de Autocorrela��o de Erros

TesteJB13 <- Box.test(ARMA13$residuals,lag = 3, type = "Ljung") #teste de Ljung-Box para autocrrela��o de erros do modelo ARMA auto regressivo de m�dias m�veis
TesteJB13

MA1 <- arima(Infla��o,order = c(0,0,1)) #modelo de m�dias m�veis de ordem 1
TesteJB1 <- Box.test(MA1$residuals,lag = 3, type = "Ljung") #teste de Ljung-Box para a MA1
TesteJB1

MA2 <- arima(Infla��o,order = c(0,0,2)) #modelo de m�dias m�veis de ordem 2
TesteJB2 <- Box.test(MA2$residuals,lag = 3, type = "Ljung") #teste de Ljung-Box para a MA2
TesteJB2

MA3 <- arima(Infla��o,order = c(0,0,3)) #modelo de m�dias m�veis de ordem 3
TesteJB3 <- Box.test(MA3$residuals,lag = 3, type = "Ljung") #teste de Ljung-Box para a MA3
TesteJB3

# Tabela de Dados com o Resultado dos Teste

P_Valores <- c(TesteJB1$p.value,TesteJB2$p.value,TesteJB3$p.value) #cria um vetor com os p valores dos testes
Modelos <- c("MA1","MA2","MA3") #cria um vetor com os nomes dos modelos
Resultados <- data.frame(Modelos,P_Valores) #cria uma tabela com os dois vetores criados
View(Resultados)
write.csv(Resultados,file = "Resultados.csv")

#Salvar CNVAZQUEZ