# %% [markdown] {"_execution_state":"idle","execution":{"iopub.status.busy":"2023-02-15T12:18:44.900684Z","iopub.execute_input":"2023-02-15T12:18:44.903008Z","iopub.status.idle":"2023-02-15T12:18:45.030333Z"}}
# ---
# 
# ## Google Data Analysis: Estudo de Caso Cyclistic
# 
# #### Autor: "Hebert Santana"
# 
# ---

# %% [markdown] {"execution":{"iopub.status.busy":"2023-02-15T17:38:29.884436Z","iopub.execute_input":"2023-02-15T17:38:29.886362Z","iopub.status.idle":"2023-02-15T17:38:29.900566Z"}}
# # Índice
# 
# * [Introdução](#introducao)
# * [Etapa 1: Perguntar](#perguntar)
# * [Etapa 2: Preparar](#preparar)
# * [Etapa 3: Processar](#processar)
# * [Etapa 4: Analisar](#analisar)
# * [Etapa 5: Compartilhar](#compartilhar)
# * [Etapa 6: Agir](#agir)

# %% [markdown]
# <a id="introducao"></a>
# # Introdução
# 
# Esse notebook é um projeto de conclusão de curso da [Certificação Profissional de Análise de Dados do Google](https://www.credly.com/badges/acaeb11a-f68c-4265-9005-3a1843152155/public_url).
# 
# O projeto é um estudo de caso sobre a empresa *Cyclistic*, uma empresa de compartilhamento de bicicletas da cidade de Chicago.
# 
# A Cyclistic possui uma frota de aproximadamente 6000 bicicletas e uma rede de quase 700 estações em Chicago. A empresa possui dois modelos de oferta de serviço: passes diários - passe de viagem única ou passe de dia inteiro - e assinaturas anuais.
# 
# * Os assinantes anuais são chamados de "**membros Cyclistic**".
# * As pessoas que usam as bicicletas através dos dois tipos de passes diários são chamados de "**usuários casuais**".
# 
# Os analistas financeiros da Cyclistic concluíram que membros anuais são mais lucrativos do que os usuários casuais. Lily Moreno (Diretora de marketing da Cyclistic) acredita que maximizar o número de membros anuais será a chave para o crescimento futuro da empresa. **Em vez de criar uma campanha de marketing voltada para captação de novos clientes, ela acredita que há uma boa chance de converter passageiros casuais em membros**. Ela observa que os ciclistas casuais já estão cientes do programa Cyclistic e escolheram a Cyclistic para suas necessidades de mobilidade.
# 
# Para guiar a análise dos dados, seguirei as seis etapas de análise de dados preconizadas pelo Google: perguntar, preparar, processar, analisar, compartilhar e agir.

# %% [markdown]
# ---
# <a id="perguntar"></a>
# # Etapa 1: Perguntar (entendendo o problema)
# 
# Objetivo: Entender como membros Cyclistic e os usuários casuais usam as bicicletas de maneira diferente.
# 
# Público: As partes interessadas são a diretoria de marketing e a equipe executiva da Cyclistic.

# %% [markdown]
# ---
# <a id="preparar"></a>
# # Etapa 2: Preparando os Dados
# 
# #### Os dados
# 
# Usei os dados históricos de trajetos da Cyclistic para analisar e identificar tendências. 
# Para isso fiz o download dos [dados de trajetos da Cyclistic no ano de 2022](https://divvy-tripdata.s3.amazonaws.com/index.html) que foram disponibilizados conforme este [contrato de licença](https://ride.divvybikes.com/data-license-agreement).
# 
# * Os dados estão divididos em 12 arquivos, cada um referente a um mês do ano (jan/22 a dez/22). 
# 
# * Os arquivos possuem a extensão .csv e representam os registros de viagem utilizando as bicicletas da empresa. 
# 
# * Em sintese, o registro de cada viagem é composto por um ID (único) da viagem, horário do início e término da viagem, localização das estações de início e término da viagem, tipo de bicicleta utilizada e tipo de usuário que realizou a viagem (casual ou membro).
# 
# Iniciei minha análise instalando os pacotes que vou utilizar durante o projeto.
# 
# #### Instalando pacotes de R:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:04:09.584109Z","iopub.execute_input":"2023-02-17T21:04:09.585802Z","iopub.status.idle":"2023-02-17T21:05:13.173036Z"}}
install.packages("plyr", lib = "/kaggle/working")
install.packages("tidyverse", lib = "/kaggle/working")
install.packages("lubridate", lib = "/kaggle/working")
install.packages("ggplot2", lib = "/kaggle/working")

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:05:13.175331Z","iopub.execute_input":"2023-02-17T21:05:13.202817Z","iopub.status.idle":"2023-02-17T21:05:13.914917Z"}}
library(plyr, lib = "/kaggle/working") # Usado para realizar operações.
library(tidyverse, lib = "/kaggle/working") # Usado para manipular e explorar os dados.
library(lubridate, lib = "/kaggle/working") # Usado para trabalhar com datas e horas.
library(ggplot2, lib = "/kaggle/working") # Usado para criação de gráficos.

# %% [markdown]
# #### Carregando os Dados
# 
# Atribui os arquivos dos dados à variáveis para cada mês do ano e transformei todas as tabelas em um único dataframe que chamei de *cyclistic_2022*.
# 
# Importando os dados:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:05:13.916878Z","iopub.execute_input":"2023-02-17T21:05:13.918421Z","iopub.status.idle":"2023-02-17T21:06:58.886140Z"}}
jan <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202201-divvy-tripdata.csv")
fev <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202202-divvy-tripdata.csv")
mar <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202203-divvy-tripdata.csv")
abr <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202204-divvy-tripdata.csv")
mai <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202205-divvy-tripdata.csv")
jun <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202206-divvy-tripdata.csv")
jul <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202207-divvy-tripdata.csv")
ago <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202208-divvy-tripdata.csv")
set <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202209-divvy-tripdata.csv")
out <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202210-divvy-tripdata.csv")
nov <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202211-divvy-tripdata.csv")
dez <- read.csv("/kaggle/input/google-capstone-cyclistic-2022/202212-divvy-tripdata.csv")

# %% [markdown]
# #### Analisando os dataframes
# 
# Verificando se as colunas são iguais em todos os conjuntos de dados:
# 
# - Se TRUE, os nomes das colunas são iguais.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:06:58.887999Z","iopub.execute_input":"2023-02-17T21:06:58.889142Z","iopub.status.idle":"2023-02-17T21:06:58.946377Z"}}
identical(names(dez), names(nov))
identical(names(dez), names(out))
identical(names(dez), names(set))
identical(names(dez), names(ago))
identical(names(dez), names(jul))
identical(names(dez), names(jun))
identical(names(dez), names(mai))
identical(names(dez), names(abr))
identical(names(dez), names(mar))
identical(names(dez), names(fev))
identical(names(dez), names(jan))

# %% [markdown]
# Verificando como os dados estão estruturados:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:06:58.948184Z","iopub.execute_input":"2023-02-17T21:06:58.949277Z","iopub.status.idle":"2023-02-17T21:06:59.195430Z"}}
str(jan)
str(fev)
str(mar)
str(abr)
str(mai)
str(jun)
str(jul)
str(ago)
str(set)
str(out)
str(nov)
str(dez)

# %% [markdown]
# Analisando a saída foi possível verificar visualmente que todas as variáveis estão estruturadas da mesma forma.
# 
# Para ter certeza vou utilizar a função *compare_df_cols()* do pacote *janitor* para verificar se os nomes e o tipo de dados dos dataframes e especifiquei para retornar apenas as diferenças encontradas.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:06:59.197921Z","iopub.execute_input":"2023-02-17T21:06:59.199203Z","iopub.status.idle":"2023-02-17T21:06:59.357586Z"}}
janitor::compare_df_cols(dez, nov, return = "mismatch")
janitor::compare_df_cols(dez, out, return = "mismatch")
janitor::compare_df_cols(dez, set, return = "mismatch")
janitor::compare_df_cols(dez, ago, return = "mismatch")
janitor::compare_df_cols(dez, jul, return = "mismatch")
janitor::compare_df_cols(dez, jun, return = "mismatch")
janitor::compare_df_cols(dez, mai, return = "mismatch")
janitor::compare_df_cols(dez, abr, return = "mismatch")
janitor::compare_df_cols(dez, mar, return = "mismatch")
janitor::compare_df_cols(dez, fev, return = "mismatch")
janitor::compare_df_cols(dez, jan, return = "mismatch")

# %% [markdown] {"execution":{"iopub.status.busy":"2023-02-15T12:42:43.584681Z","iopub.execute_input":"2023-02-15T12:42:43.586516Z","iopub.status.idle":"2023-02-15T12:42:43.606148Z"}}
# Não houve retorno de diferenças (0 rows) entre os dataframes.
# 
# #### Unindo os dataframes e gerando um dataframe único com todos os dados
# 
# Após a análise prévia dos meus dados, vou gerar um dataframe (*cyclistic_2022*) unindo todos o nosso conjunto de dados. Assim ficará mais prático nosso processo de análise e manipulação dos dados.
# Para isso usei a função *bind_rows()* para unir os dataframes dos dados e atibui o resultado à *cyclistic_2022)*.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:06:59.359786Z","iopub.execute_input":"2023-02-17T21:06:59.361078Z","iopub.status.idle":"2023-02-17T21:07:09.843564Z"}}
cyclistic_2022 <- bind_rows(jan, fev, mar, abr, mai, jun, jul, ago, set, out, nov, dez)

# %% [markdown]
# ---
# <a id="processar"></a>
# # Etapa 3: Processando os Dados
# 
# Essa é a etapa de limpar os dados e prepará-los para a análise.
# 
# #### Visualizando algumas informações sobre os dados:
# 
# Visualizando parte do dataframe:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:09.846222Z","iopub.execute_input":"2023-02-17T21:07:09.847715Z","iopub.status.idle":"2023-02-17T21:07:09.878798Z"}}
head(cyclistic_2022)

# %% [markdown]
# Verificando a quantidade de registros (linhas) do dataframe:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:09.881851Z","iopub.execute_input":"2023-02-17T21:07:09.883242Z","iopub.status.idle":"2023-02-17T21:07:09.897516Z"}}
nrow(cyclistic_2022)

# %% [markdown]
# Há, portanto, **5667717 registros**.
# 
# Visualizando algumas informações do dataframe:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:09.900035Z","iopub.execute_input":"2023-02-17T21:07:09.901242Z","iopub.status.idle":"2023-02-17T21:07:09.929956Z"}}
str(cyclistic_2022)

# %% [markdown]
# #### Renomeando colunas:
# 
# Optei por renomear as colunas para ficar mais inteligível as manipulações que farei futuramente:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:09.932359Z","iopub.execute_input":"2023-02-17T21:07:09.933630Z","iopub.status.idle":"2023-02-17T21:07:09.943681Z"}}
names(cyclistic_2022)<- c("passeio_id", "tipo_bicicleta", "data_hora_saida", "data_hora_chegada", "estacao_saida_nome", "estacao_saida_id", "estacao_chegada_nome", "estacao_chegada_id", "lat_saida", "long_saida", "lat_chegada", "long_chegada", "tipo_usuario")

# %% [markdown]
# #### Limpando valores `NA`:
# 
# Agora utilizei a função *drop_na()* para eliminar registros no dataframe que possuam campos de variáveis vazios. Lembrando que quando utilizamos a função *nrows()* para contar a quantidade de registros que havia no dataframe, a função retornou um total de **5667717 registros**. Após limpar os registros com valores `NA`, vou rodar novamente a função *nrows()* e comparar qual foi a quantidade de registros eliminados do dataframe.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:09.946220Z","iopub.execute_input":"2023-02-17T21:07:09.947432Z","iopub.status.idle":"2023-02-17T21:07:28.195503Z"}}
cyclistic_2022 <- drop_na(cyclistic_2022)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:28.197556Z","iopub.execute_input":"2023-02-17T21:07:28.198808Z","iopub.status.idle":"2023-02-17T21:07:28.212492Z"}}
nrow(cyclistic_2022)

# %% [markdown]
# * Antes da remoção de valores `NA`: 5667717 registros.
# * Após remoção de valores `NA`: 5661859 registros.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:28.214527Z","iopub.execute_input":"2023-02-17T21:07:28.215772Z","iopub.status.idle":"2023-02-17T21:07:28.232816Z"}}
registros_com_na = 5667717 - 5661859
porcentual_valores_na = (registros_com_na / 5667717) * 100
print(registros_com_na)
print(porcentual_valores_na)

# %% [markdown]
# * Foi removido um total de 5858 registros. Isso corresponde apenas a 0,1% dos registros do dataframe inicial.
# 
# Vou verificar se todos os IDs de viagens são realmente únicos:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:28.234879Z","iopub.execute_input":"2023-02-17T21:07:28.236018Z","iopub.status.idle":"2023-02-17T21:07:29.148516Z"}}
length(unique(cyclistic_2022$passeio_id))

# %% [markdown]
# * É o mesmo que encontramos para o número de registros, logo, cada ID de viagem (*passseio_id*) é único.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:29.151122Z","iopub.execute_input":"2023-02-17T21:07:29.152648Z","iopub.status.idle":"2023-02-17T21:07:37.863310Z"}}
any(is.na(cyclistic_2022)) #verificando se restou registro com dado faltante

# %% [markdown]
# * Não há nenhum registro com dados faltantes.
# 
# 
# Portanto, nesse momento, temos o dataframe base *cyclistic_2022* com as colunas no formato que usaremos para trabalhar, sem registros com valor nulo e sem duplicatas na coluna de ID.
# 
# Vou iniciar agora a criação de novas variáveis que serão úteis durante a análise.
# 
# 
# ## Dados que vou querer na análise
# 
# Para entender a diferença do modo de utilização das bicicletas pelo grupo de membros em comparação com o grupo de usuários casuais, vou querer entender alguns aspectos com base nos meus dados:
# 
# * Qual a duração média das viagens de cada grupo?
# 
# * A duração média varia conforme os dias da semana ou meses do ano?
# 
# * Qual o número total de viagens de cada grupo?
# 
# * O número total de viagens varia conforme os dias da semana ou meses do ano?
# 
# Para responder essas perguntas vou manusear o dataframe para conseguir as respostas.
# 
# 
# #### Criando novas colunas:
# 
# Vou criar novas colunas baseadas nas informações da coluna de Data e Hora de saída (**data_hora_saida**). Para trabalhar com data e hora usei o pacote *lubridate*.
# 
# Vou criar as seguintes colunas:
# 
# * **hora_saida**: representa o horário em que a bicicleta saiu da base.
# 
# * **mes_saida**: representa o mês em que a bicicleta saiu da base.
# 
# * **dia_saida**: representa o dia em que a bicicleta saiu da base.
# 
# * **dia_da_semana_saida**: representa o dia da semana - de segunda a domingo - em que a bicicleta saiu da base.
# 
# * **duracao**: representa a duração da viagem.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:07:37.865838Z","iopub.execute_input":"2023-02-17T21:07:37.867067Z","iopub.status.idle":"2023-02-17T21:08:07.216068Z"}}
cyclistic_2022$hora_saida <- lubridate:: hour(cyclistic_2022$data_hora_saida)
cyclistic_2022$mes_saida <- format(as.Date(cyclistic_2022$data_hora_saida), "%b")
cyclistic_2022$dia_saida <- format(as.Date(cyclistic_2022$data_hora_saida), "%d")
cyclistic_2022$dia_da_semana_saida <- format(as.Date(cyclistic_2022$data_hora_saida), "%A")

# %% [markdown]
# A duração (*duracao*) é a diferença entre **data_hora_chegada** e **data_hora_saida**. Para esse cálculo usei a função *difftime()*:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:08:07.218663Z","iopub.execute_input":"2023-02-17T21:08:07.219989Z","iopub.status.idle":"2023-02-17T21:08:37.917999Z"}}
cyclistic_2022$duracao <- difftime(cyclistic_2022$data_hora_chegada, cyclistic_2022$data_hora_saida)

# %% [markdown]
# Dando uma nova observada no dataframe para verificar como ficou após a inserção das novas colunas.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:08:37.920034Z","iopub.execute_input":"2023-02-17T21:08:37.921268Z","iopub.status.idle":"2023-02-17T21:08:37.953771Z"}}
head(cyclistic_2022)

# %% [markdown]
# #### Convertendo o tipo da coluna de duração (*duracao*) das viagens:
# 
# A coluna *duracao* não é numerica; conforme observado na ultima consulta ao dataframe, *duracao* está classificada como sendo do tipo *drtn*. 
# Sendo assim, a converti para uma coluna numérica utilizando a função *as.numeric()* e verifiquei se a conversão foi bem sucedida usando *is.numeric()*.
# A função *is.numeric()* retornará TRUE se a coluna for do tipo número.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:08:37.955775Z","iopub.execute_input":"2023-02-17T21:08:37.956947Z","iopub.status.idle":"2023-02-17T21:08:44.398310Z"}}
cyclistic_2022$duracao <- as.numeric(as.character(cyclistic_2022$duracao))
is.numeric(cyclistic_2022$duracao)

# %% [markdown]
# #### Removendo dados que não terão utilidade:
# 
# Vou fazer uma nova limpeza nos dados, agora eliminando dados que não sejam úteis na análise. 
# No caso optei por remover *duracao* quando esta for menor que zero ou vazia.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:08:44.401690Z","iopub.execute_input":"2023-02-17T21:08:44.403107Z","iopub.status.idle":"2023-02-17T21:08:59.646199Z"}}
cyclistic_2022 <- cyclistic_2022[!(cyclistic_2022$duracao <= 0 | cyclistic_2022$duracao == ""),]

# %% [markdown]
# Agora vamos dar uma nova verificada no número de registros (linhas) do dataframe para ver quantos registros foram eliminados após nossa última limpeza.
# Lembrando que antes da última limpeza o dataframe era composto por **5661859 registros**.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:08:59.648201Z","iopub.execute_input":"2023-02-17T21:08:59.649429Z","iopub.status.idle":"2023-02-17T21:08:59.663160Z"}}
nrow(cyclistic_2022)

# %% [markdown]
# Nessa última limpeza, portando, pouco mais de 500 registros foram removidos do dataframe e agora possuimos **5661328 registros**.

# %% [markdown]
# ---
# <a id="analisar"></a>
# ## Etapa 4: Analisando os Dados
# 
# Agora vamos iniciar a fase de análise dos dados e descrobrir quais histórias os dados contam sobre como é o modo que cada grupo de usuários utiliza as bicicletas da Cyclistic.
# 
# #### Dados estatísticos básicos da duração das viagens
# 
# Iniciando tendo uma visão geral (incluindo os dois grupos de usuários) da média de duração das viagens, a mediana, o tempo máximo de duração de um passeio e o tempo mínimo de duração.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:08:59.665019Z","iopub.execute_input":"2023-02-17T21:08:59.666128Z","iopub.status.idle":"2023-02-17T21:08:59.870369Z"}}
mean(cyclistic_2022$duracao) / 60
median(cyclistic_2022$duracao) /60
max(cyclistic_2022$duracao) /60
min(cyclistic_2022$duracao)

# %% [markdown]
# * Tempo médio das viagens: 16,3 minutos.
# * Mediana do tempo de viagens: 10,3 minutos.
# * Duração Máxima de uma viagem: 34354 minutos (aproximadamente 24 dias).
# * Menor duração de viagem: 1 segundo.
# 
# 
# #### Comparando a duração da viagem em relação a cada grupo de usuários:
# 
# Com o dataframe (*cyclistic_2022*), agrupei por tipo de usuário (*tipo_usuario*) e usei a função *summarise()* para calcular a duração média (*duracao_media*) e numero total das viagens (*num_viagens*) que cada grupo de usuário realizou.
# Para realizar tudo de uma vez, utilizei o operador pipe (*%>%*). Ele será utilizado mais vezes no decorrer do projeto.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:08:59.872285Z","iopub.execute_input":"2023-02-17T21:08:59.873530Z","iopub.status.idle":"2023-02-17T21:09:00.086465Z"}}
duracao_media_tabela <- cyclistic_2022 %>% 
  group_by(tipo_usuario) %>% 
  summarise(duracao_media = mean(duracao)/60, num_viagens = length(duracao)) # duracao_media em minutos (por isso divisao por 60 para converter segundos em minutos) e num_viagens é o número total de registros no dataframe, no caso para cada grupo
print(duracao_media_tabela)

# %% [markdown]
# #### Análise:
# 
# * A duração média das viagens dos usuários casuais é aproximadamente 22 minutos, enquanto que dos membros Cyclistic é pouco mais de 12 minutos.
# 
# * O número total de passeios realizados por membros Cyclistic é maior do que o número total de viagens dos usuários casuais.
# 
# #### Plotando o gráfico da análise:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:00.088468Z","iopub.execute_input":"2023-02-17T21:09:00.089689Z","iopub.status.idle":"2023-02-17T21:09:00.448602Z"}}
ggplot(duracao_media_tabela, aes(x= duracao_media, y= duracao_media, fill = tipo_usuario)) +
 geom_col(color = "black", linewidth = 0.2) +
  scale_fill_manual(values = c("seagreen3", "orange")) + 
  labs(x= NULL, y = "Duração Média (min)", title = "Duração Média das Viagens (min)", fill="Tipo de Usuário") +  
  theme(axis.text.x = element_blank(), axis.ticks.x=element_blank(),
       axis.title.y = element_text(size = 16, face = "bold"),
       plot.title = element_text(size = 20, face = "bold"),
       legend.title= element_text(size = 16, face = "bold",),
       legend.text = element_text(size = 14))

# %% [markdown]
# ---
# <a id="compartilhar"></a>
# # Compartilhar
# 
# Nessa fase vou trabalhar com os dados analisados para criar visualizações que expliquem o comportamento dos membros Cyclistic e usuários casuais.

# %% [markdown]
# #### Comparando o número total de viagens de cada grupo de usuários

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:00.450649Z","iopub.execute_input":"2023-02-17T21:09:00.451803Z","iopub.status.idle":"2023-02-17T21:09:00.624950Z"}}
num_viagens_tabela <- cyclistic_2022 %>% 
  group_by(tipo_usuario) %>% 
  summarise(num_viagens = length(duracao), porcentual_viagens = (length(duracao)/nrow(cyclistic_2022))*100 )
print(num_viagens_tabela)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:00.626961Z","iopub.execute_input":"2023-02-17T21:09:00.628217Z","iopub.status.idle":"2023-02-17T21:09:00.927584Z"}}
ggplot(num_viagens_tabela, aes(x= tipo_usuario, y = porcentual_viagens, fill = tipo_usuario)) +
  geom_col(color = "black", linewidth = 0.2) +
  scale_fill_manual(values = c("seagreen3", "orange"), name = "Tipo de Usuário", labels = c("Usuario Casual", "Membro Anual")) +
  labs(x= NULL, y = "Porcentual Viagens (%)", title = "Porcentual de Viagens vs. Tipo de Usuário", fill="Tipo de Usuário") +
  theme(axis.text.x = element_blank(), axis.ticks.x=element_blank(),
       axis.title.y = element_text(size = 16, face = "bold"),
       plot.title = element_text(size = 20, face = "bold"),
       legend.title= element_text(size = 16, face = "bold",),
       legend.text = element_text(size = 14))

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:00.929865Z","iopub.execute_input":"2023-02-17T21:09:00.931047Z","iopub.status.idle":"2023-02-17T21:09:01.264100Z"}}
ggplot(num_viagens_tabela, aes(x = "", y = porcentual_viagens, fill = tipo_usuario)) +
    geom_col(color = "black", size = 0.7) +
    coord_polar("y", start = 0) +
    geom_text(aes(label = scales :: percent(porcentual_viagens/100)), position = position_stack(vjust = 0.5), size = 10, fontface = "bold") +
scale_fill_manual(values = c("seagreen3", "orange"), name = "Tipo de Usuário", labels = c("Usuario Casual", "Membro Anual")) +
labs(title = "Total de Viagens vs. Tipo de Usuário") +
theme_void() +
theme(plot.title = element_text(size = 20, face = "bold"),
    legend.title = element_text(size = 16, face = "bold",),
    legend.text = element_text(size = 14))

# %% [markdown]
# #### Análise:
# 
# * O número total de viagens do grupo de membros Cyclistic é de 59% do total de viagens geral; enquanto que dos Usuários Casuais é de 41%.
# 
# * Até o momento sabemos que a maioria das viagens são realizadas por membros, porém a duração das viagens de passageiros casuais é maior.

# %% [markdown] {"execution":{"iopub.status.busy":"2023-02-15T17:27:11.565752Z","iopub.execute_input":"2023-02-15T17:27:11.568333Z","iopub.status.idle":"2023-02-15T17:27:11.586004Z"}}
# #### Comparando a duração média da viagem por grupo de usuários a cada mês:
# 
# Ordenei a coluna *mes_saida* do dataframe usando a função *ordered()*.
# Primeiro me certifiquei quais os dados únicos da coluna *mes_saida*.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:01.266113Z","iopub.execute_input":"2023-02-17T21:09:01.267410Z","iopub.status.idle":"2023-02-17T21:09:01.355428Z"}}
unique(cyclistic_2022$mes_saida)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:01.357294Z","iopub.execute_input":"2023-02-17T21:09:01.358418Z","iopub.status.idle":"2023-02-17T21:09:01.432978Z"}}
# Ordenando a coluna
cyclistic_2022$mes_saida <- ordered(cyclistic_2022$mes_saida, levels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:01.434836Z","iopub.execute_input":"2023-02-17T21:09:01.435939Z","iopub.status.idle":"2023-02-17T21:09:01.675000Z"}}
# Calculando a duracao media
duracao_media_meses <- cyclistic_2022 %>% 
  group_by(tipo_usuario, mes_saida) %>% 
  summarise(duracao_media = mean(duracao)/60, .groups = 'drop')
print(duracao_media_meses)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:01.676844Z","iopub.execute_input":"2023-02-17T21:09:01.677953Z","iopub.status.idle":"2023-02-17T21:09:01.951714Z"}}
# Grafico da duracao media por mes
ggplot(duracao_media_meses, aes(x = mes_saida, y = duracao_media, fill = tipo_usuario)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("seagreen3", "orange")) +
  labs(x= NULL, y = "Duração Média (min)", title = "Duração Média (min) vs. Mês", fill="Tipo de Usuário") +
  theme(axis.title.y = element_text(size = 16, face = "bold"),
       plot.title = element_text(size = 20, face = "bold"),
       legend.title= element_text(size = 16, face = "bold",),
       legend.text = element_text(size = 14))

# %% [markdown]
# 
# #### Análise:
# 
# * A duração média das viagens do grupo de membros Cyclistic foi sempre inferior à duração média do grupo de Usuários Casuais.
# 
# * A variação da duração média das viagens dos membros Cyclistic possuio uma amplitude menor do que a variação da duração média das viagens dos usuários casuais, demonstrando que os membros utilizam as bicicletas de um modo mais pragmático independente do mês do ano.
# 
# #### Comparando o número total de viagens de cada grupo de usuários a cada mês:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:01.954683Z","iopub.execute_input":"2023-02-17T21:09:01.956036Z","iopub.status.idle":"2023-02-17T21:09:02.181833Z"}}
# Calculo do total de viagens a cada mes
duracao_total_tabela <- cyclistic_2022 %>% 
  group_by(tipo_usuario, mes_saida) %>% 
  summarise(num_viagens = length(duracao), .groups = 'drop')
print(duracao_total_tabela)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:02.183749Z","iopub.execute_input":"2023-02-17T21:09:02.184924Z","iopub.status.idle":"2023-02-17T21:09:12.622154Z"}}
# instalando scales para ajudar na edicao dos graficos
install.packages("scales", lib = "/kaggle/working")
library(scales, lib = "/kaggle/working")

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:12.625730Z","iopub.execute_input":"2023-02-17T21:09:12.627236Z","iopub.status.idle":"2023-02-17T21:09:14.146813Z"}}
# Grafico do total de viagens por mes
ggplot(duracao_total_tabela, aes(x = mes_saida, y = num_viagens, fill = tipo_usuario)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("seagreen3", "orange")) +
  scale_y_continuous(breaks = scales:: breaks_width(100000), labels = comma_format(big.mark = ".")) +
  labs(x= NULL, y = "Total de Viagens", title = "Total de Viagens vs. Mês", fill="Tipo de Usuário") +
  theme(axis.title.y = element_text(size = 16, face = "bold"),
       plot.title = element_text(size = 20, face = "bold"),
       legend.title= element_text(size = 16, face = "bold",),
       legend.text = element_text(size = 14))

# %% [markdown]
# #### Análise:
# 
# * Durante os meses de verão no hemisfério norte - entre junho e agosto - ocorre o pico no número de viagens de ambos os grupos de usuários.
# 
# * No período do inverno no hemisfério norte - entre dezembro e março - o número de viagens de usuários casuais fica bastante inferior ao número de viagens de membros, mostrando que usuarios casuais costumam usar as bicicletas principalmente nas épocas de tempo melhor, principalmente na temporada turistica da cidade (entre junho e setembro).

# %% [markdown]
# #### Análise do comportanmento das viagens com relação aos Dias da Semana:
# 

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:14.149713Z","iopub.execute_input":"2023-02-17T21:09:14.151073Z","iopub.status.idle":"2023-02-17T21:09:14.245737Z"}}
# Observando os dados unicos na coluna de dias da semana
unique(cyclistic_2022$dia_da_semana_saida)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:14.247642Z","iopub.execute_input":"2023-02-17T21:09:14.248752Z","iopub.status.idle":"2023-02-17T21:09:14.375263Z"}}
cyclistic_2022$dia_da_semana_saida <- ordered(cyclistic_2022$dia_da_semana_saida, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

# %% [markdown] {"execution":{"iopub.status.busy":"2023-02-15T18:06:34.544574Z","iopub.execute_input":"2023-02-15T18:06:34.547762Z","iopub.status.idle":"2023-02-15T18:06:34.566240Z"}}
# #### Calculando a duração média das viagens por grupo de usuários em cada dia da semana:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:14.377213Z","iopub.execute_input":"2023-02-17T21:09:14.378364Z","iopub.status.idle":"2023-02-17T21:09:14.651075Z"}}
duracao_media_dias <- cyclistic_2022 %>% 
  group_by(tipo_usuario, dia_da_semana_saida) %>% 
  summarise(duracao_media = mean(duracao)/60, .groups = 'drop')
print(duracao_media_dias)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:14.653785Z","iopub.execute_input":"2023-02-17T21:09:14.655207Z","iopub.status.idle":"2023-02-17T21:09:14.935001Z"}}
ggplot(duracao_media_dias, aes(x = dia_da_semana_saida, y = duracao_media, fill = tipo_usuario))+
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("seagreen3", "orange")) +
  labs(x=NULL, y = "Duração Média (min)", title = "Duração Média (min) vs. Dia da Semana", fill="Tipo de Usuário") +
  theme(axis.text.x = element_text(angle = 20, hjust=1, face = "bold"),
        plot.title = element_text(size = 20, face = "bold"),
        axis.title.y = element_text(size = 16, face = "bold"),
        legend.title= element_text(size = 16, face = "bold",),
        legend.text = element_text(size = 14))

# %% [markdown]
# #### Análise:
# 
# * Nos finais de semana a duração média das viagens do grupo de usuários casuais é maior do que em úteis, indicando o uso para passeios de lazer. 
# 
# * A duração média das viagens de membros em dias úteis é semelhante, sempre abaixo de 15 minutos em média, indicando uso pragmático e constante.

# %% [markdown] {"execution":{"iopub.status.busy":"2023-02-15T18:09:28.469401Z","iopub.execute_input":"2023-02-15T18:09:28.472214Z","iopub.status.idle":"2023-02-15T18:09:28.489219Z"}}
# #### Número total de viagens por grupo de usuários em relação em cada dia da semana:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:14.938140Z","iopub.execute_input":"2023-02-17T21:09:14.939435Z","iopub.status.idle":"2023-02-17T21:09:15.177270Z"}}
num_viagens_dias <- cyclistic_2022 %>% 
  group_by(tipo_usuario, dia_da_semana_saida) %>% 
  summarise(num_total_viagens = length(duracao), .groups = 'drop')
print(num_viagens_dias)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:15.179111Z","iopub.execute_input":"2023-02-17T21:09:15.180238Z","iopub.status.idle":"2023-02-17T21:09:15.453792Z"}}
ggplot(num_viagens_dias, aes(x = dia_da_semana_saida, y = num_total_viagens, fill = tipo_usuario)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("seagreen3", "orange")) +
  scale_y_continuous(breaks = scales:: breaks_width(100000), labels = comma_format(big.mark = ".")) +
  labs(x=NULL, y = "Total de Viagens", title = "Total de Viagens vs. Dia da Semana", fill= "Tipo de Usuário") +
  theme(axis.text.x = element_text(angle = 20, hjust=1,face = "bold"),
        plot.title = element_text(size = 20, face = "bold"),
        axis.title.y = element_text(size = 16, face = "bold"),
        legend.title= element_text(size = 16, face = "bold",),
        legend.text = element_text(size = 14))

# %% [markdown] {"execution":{"iopub.status.busy":"2023-02-15T18:10:14.010593Z","iopub.execute_input":"2023-02-15T18:10:14.015231Z","iopub.status.idle":"2023-02-15T18:10:14.028251Z"}}
# #### Análise:
# 
# * O número de viagens dos membros é maior durante os dias úteis, fortalecendo a ideia do uso pragmático, provavelmente para descolar para o serviço. Para concluir vamos em breve analisar quais horários do dia esse tipo de usuário mais utiliza as biciletas. 
# * O número de viagens dos usuários casuais é maior nos finais de semana, fortalecendo a ideia de que o uso é para passeios de lazer.

# %% [markdown]
# #### Duração média das viagens por grupo de usuários em relação ao horário do dia:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:15.455644Z","iopub.execute_input":"2023-02-17T21:09:15.456728Z","iopub.status.idle":"2023-02-17T21:09:15.726289Z"}}
duracao_media_horas <- cyclistic_2022 %>% 
  group_by(tipo_usuario, hora_saida) %>% 
  summarise(duracao_media = mean(duracao)/60, .groups = 'drop')
print(duracao_media_horas)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:15.728129Z","iopub.execute_input":"2023-02-17T21:09:15.729241Z","iopub.status.idle":"2023-02-17T21:09:15.988108Z"}}
ggplot(duracao_media_horas, aes(x = hora_saida, y = duracao_media, fill = tipo_usuario)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("seagreen3", "orange")) +
  labs(x=NULL, y = "Duração Média (min)", title = "Duração Média com relação à Hora do Dia", fill= "Tipo de Usuário") +
  theme(axis.text.x = element_text(face = "bold"),
        plot.title = element_text(size = 20, face = "bold"),
        axis.title.y = element_text(size = 16, face = "bold"),
        legend.title= element_text(size = 16, face = "bold",),
        legend.text = element_text(size = 14))

# %% [markdown]
# 
# #### Análise:
# 
# * A duração média dos passeios de usuários casuais é superior a duração média das viagens dos membros, fortalecendo as evidências de que usuários casuais utilizam as bicicletas para fins de lazer enquanto que membros utilizam de modo mais pragmático e constante, provavelmente para descolar para o serviço.
# 
# A fim de enfatizar o modo como os membros utilizam as bicicletas, vamos verificar qual o horário mais realizam viagens.

# %% [markdown]
# #### Relação entre o número total de passeios e as horas do dia:

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:15.989971Z","iopub.execute_input":"2023-02-17T21:09:15.991116Z","iopub.status.idle":"2023-02-17T21:09:16.234321Z"}}
num_viagens_horas <- cyclistic_2022 %>% 
  group_by(tipo_usuario, hora_saida) %>% 
  summarise(num_total_viagens = length(duracao), .groups = 'drop')
print(num_viagens_horas)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:16.236164Z","iopub.execute_input":"2023-02-17T21:09:16.237278Z","iopub.status.idle":"2023-02-17T21:09:16.506991Z"}}
ggplot(num_viagens_horas, aes(x = hora_saida, y = num_total_viagens, fill = tipo_usuario)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("seagreen3", "orange")) +
  scale_y_continuous(breaks = scales:: breaks_width(100000), labels = comma_format(big.mark = ".")) +
  labs(x=NULL, y = "Total de Viagens", title = "Total de Passeios vs. Hora do Dia", fill= "Tipo de Usuário") +
  theme(axis.text.x = element_text(face = "bold"),
        plot.title = element_text(size = 20, face = "bold"),
        axis.title.y = element_text(size = 16, face = "bold"),
        legend.title= element_text(size = 16, face = "bold",),
        legend.text = element_text(size = 14))

# %% [markdown]
# Pra enxergar os dados sob outro ângulo, criei um mapa de calor para analisar o número de viagens conforme a relação entre dias da semana e horas do dia.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:16.508808Z","iopub.execute_input":"2023-02-17T21:09:16.509943Z","iopub.status.idle":"2023-02-17T21:09:16.773710Z"}}
dia_semana_hora <- cyclistic_2022 %>% 
  group_by(hora_saida, dia_da_semana_saida, tipo_usuario) %>% 
  summarize(num_total_viagens2 = length(duracao), .groups = 'drop')

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:16.775508Z","iopub.execute_input":"2023-02-17T21:09:16.776642Z","iopub.status.idle":"2023-02-17T21:09:17.120440Z"}}
ggplot(dia_semana_hora, aes(x=dia_da_semana_saida, y=hora_saida, fill = num_total_viagens2)) +
  facet_wrap( ~tipo_usuario) +
  geom_tile(color = "white", size = 0.1) +
  scale_fill_gradient(high = "red", low = "blue") +
  scale_y_continuous(trans = "reverse") + 
  labs(x= NULL, y= "Hora do Dia", fill="Total Saidas") + 
  ggtitle("Número de Viagens: Horários vs. Dias") +
  theme(axis.text.x = element_text(size = 8, face = "bold", angle = 90, hjust=1),
          axis.title.y = element_text(size = 14, face = "bold"),
          plot.title = element_text(size = 16, face = "bold"),
          legend.title= element_text(size = 12, face = "bold"),
          legend.text = element_text(size = 14))

# %% [markdown]
# #### Análise:
# 
# * Os gráfico anteriores evidencia que em ambos os grupos de usuários há um expressivo aumento no total de passeios a partir das 6 horas às 9 horas. Porém o aumento para usuários casuais é gradativo até as 17hrs; já para membros há um grande aumento entre as 06hrs e as 08hrs da manhã e um outro forte aumento entre as 16hrs e 17hrs (horários de pico para deslocar para o trabalho), que é o horário de saída para o trabalho e de retorno do trabalho, fortalecendo ainda mais as evidências sobre a finalidade da utilização das biciletas por membros para ir trabalhar.
# 
# * Às 17 horas o gráfico de ambos os tipos de usuários tem seu ponto máximo e então inicia-se um movimento descendente.
# 
# * O mapa de calor evidencia também o maior número de viagens dos usuários casuais aos finais de semana em comparação com os mesmos horários em dias úteis, principalmente entre as 08hrs e 16hrs.

# %% [markdown]
# ---
# 
# ## Análise sobre principais estações utilizadas 
# 
# Aqui analisei as estação onde ocorreu maior número de início de viagens e a respectiva estação de destino, para identificar as rotas mais comuns entre membros e usuários casuais.

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:17.122181Z","iopub.execute_input":"2023-02-17T21:09:17.123232Z","iopub.status.idle":"2023-02-17T21:09:17.134527Z"}}
nrow(cyclistic_2022)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:17.136225Z","iopub.execute_input":"2023-02-17T21:09:17.137305Z","iopub.status.idle":"2023-02-17T21:09:17.231813Z"}}
estacoes_de_saida <- cyclistic_2022 %>% 
  select(estacao_id = estacao_saida_id, 
  estacao_nome = estacao_saida_nome, 
  estacao_lat = lat_saida, 
  estacao_long = long_saida) %>%
    distinct(estacao_id, .keep_all=TRUE)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:17.233777Z","iopub.execute_input":"2023-02-17T21:09:17.234949Z","iopub.status.idle":"2023-02-17T21:09:17.247668Z"}}
nrow(estacoes_de_saida)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:17.249546Z","iopub.execute_input":"2023-02-17T21:09:17.250695Z","iopub.status.idle":"2023-02-17T21:09:17.263916Z"}}
# Certificando que não há valores NA no dataframe estacoes. Mesmo já tendo limpados os dados, acho válido fazer novas verificações no decorrer do projeto.
any(is.na(estacoes_de_saida))

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:17.265806Z","iopub.execute_input":"2023-02-17T21:09:17.266978Z","iopub.status.idle":"2023-02-17T21:09:17.352091Z"}}
estacoes_de_chegada <- cyclistic_2022 %>% 
  select(estacao_id = estacao_chegada_id, 
  estacao_nome = estacao_chegada_nome, 
  estacao_lat = lat_chegada, 
  estacao_long = long_chegada) %>%
    distinct(estacao_id, .keep_all=TRUE)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:09:17.353905Z","iopub.execute_input":"2023-02-17T21:09:17.355023Z","iopub.status.idle":"2023-02-17T21:09:17.368721Z"}}
nrow(estacoes_de_chegada)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:11:37.682723Z","iopub.execute_input":"2023-02-17T21:11:37.684005Z","iopub.status.idle":"2023-02-17T21:11:37.696453Z"}}
any(is.na(estacoes_de_chegada))

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:11:42.087592Z","iopub.execute_input":"2023-02-17T21:11:42.089083Z","iopub.status.idle":"2023-02-17T21:11:42.103096Z"}}
# Unindo os dois dataframes, selecionando IDs unicos de estacao:
estacoes <- union(estacoes_de_saida, estacoes_de_chegada) %>% 
distinct(estacao_id, .keep_all=TRUE)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:12:38.518003Z","iopub.execute_input":"2023-02-17T21:12:38.519278Z","iopub.status.idle":"2023-02-17T21:12:38.531533Z"}}
nrow(estacoes)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:12:41.726717Z","iopub.execute_input":"2023-02-17T21:12:41.727968Z","iopub.status.idle":"2023-02-17T21:13:38.859118Z"}}
rotas <- cyclistic_2022 %>% 
  filter(estacao_saida_id != estacao_chegada_id & estacao_saida_id != "" & estacao_chegada_id != "") %>% # estacao de saida diferente da de chegada, de estacoes de saida e chegada com campo válido de ID
  group_by(lat_saida, long_saida, lat_chegada, long_chegada, tipo_usuario) %>% 
  summarise(total = n(), .groups = "drop")

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:16:23.221281Z","iopub.execute_input":"2023-02-17T21:16:23.222802Z","iopub.status.idle":"2023-02-17T21:16:23.238125Z"}}
nrow(rotas) # total de rotas identificadas

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:16:26.143257Z","iopub.execute_input":"2023-02-17T21:16:26.144586Z","iopub.status.idle":"2023-02-17T21:16:26.168341Z"}}
head(rotas)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:16:28.510386Z","iopub.execute_input":"2023-02-17T21:16:28.511768Z","iopub.status.idle":"2023-02-17T21:16:28.531553Z"}}
max(rotas$total) #maior número de trajetos

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:20:34.781494Z","iopub.execute_input":"2023-02-17T21:20:34.782909Z","iopub.status.idle":"2023-02-17T21:20:34.904061Z"}}
# separando os dados de rotas pelo tipo de usuario
casual_rota <- rotas %>% filter(tipo_usuario == "casual")
membro_rota <- rotas %>% filter(tipo_usuario == "member")

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:20:38.548896Z","iopub.execute_input":"2023-02-17T21:20:38.550235Z","iopub.status.idle":"2023-02-17T21:20:38.574144Z"}}
head(casual_rota)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:20:44.415842Z","iopub.execute_input":"2023-02-17T21:20:44.417184Z","iopub.status.idle":"2023-02-17T21:20:44.436731Z"}}
nrow(casual_rota)
nrow(membro_rota)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:21:01.658986Z","iopub.execute_input":"2023-02-17T21:21:01.660951Z","iopub.status.idle":"2023-02-17T21:21:01.704118Z"}}
casual_rota <- casual_rota %>%
  arrange(desc(total)) %>%
  slice(1:500) #top 500 rotas

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:21:05.100662Z","iopub.execute_input":"2023-02-17T21:21:05.101989Z","iopub.status.idle":"2023-02-17T21:21:05.139837Z"}}
membro_rota <- membro_rota %>%
  arrange(desc(total)) %>%
  slice(1:500) #top 500 rotas

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:21:07.261859Z","iopub.execute_input":"2023-02-17T21:21:07.263234Z","iopub.status.idle":"2023-02-17T21:21:07.281573Z"}}
nrow(casual_rota)
nrow(membro_rota)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:21:18.658767Z","iopub.execute_input":"2023-02-17T21:21:18.660189Z","iopub.status.idle":"2023-02-17T21:21:18.684010Z"}}
head(casual_rota)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:21:21.184057Z","iopub.execute_input":"2023-02-17T21:21:21.185368Z","iopub.status.idle":"2023-02-17T21:21:21.209031Z"}}
head(membro_rota)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:19:31.949717Z","iopub.execute_input":"2023-02-17T21:19:31.951592Z","iopub.status.idle":"2023-02-17T21:19:47.139163Z"}}
# instalando pacote ggmap
install.packages("ggmap", lib = "/kaggle/working")
library(ggmap, lib = "/kaggle/working")

# %% [code] {"_kg_hide-input":true,"execution":{"iopub.status.busy":"2023-02-17T21:19:56.455335Z","iopub.execute_input":"2023-02-17T21:19:56.457010Z","iopub.status.idle":"2023-02-17T21:19:56.467393Z"}}
register_google(key="***************************")

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:21:26.906245Z","iopub.execute_input":"2023-02-17T21:21:26.907678Z","iopub.status.idle":"2023-02-17T21:21:28.469828Z"}}
# principais 500 rotas dos usuarios casuais
casual_rota_mapa <- ggmap(get_googlemap(center=c(lon=-87.6197, lat=41.8888), zoom = 12, maptype="terrain", color="bw"))+
  geom_point(data=estacoes, aes(x=estacao_long, y=estacao_lat), size=0.5, color="red") + 
  geom_curve(casual_rota, mapping = aes(x = long_saida, y = lat_saida, xend = long_chegada, yend = lat_chegada, alpha= total), color="blue", size = 1, curvature = 0.2) +
  coord_cartesian()+labs(title="Principais Rotas de Usuários Casuais", x=NULL, y=NULL, alpha="Total de Viagens") + 
  theme(axis.text.x = element_blank(), axis.ticks.x=element_blank(),
        axis.text.y = element_blank(), axis.ticks.y=element_blank(),
        plot.title = element_text(size=14, face="bold"),
        legend.title= element_text(size = 14, face = "bold"),
        legend.text = element_text(size = 12))
print(casual_rota_mapa)

# %% [code] {"execution":{"iopub.status.busy":"2023-02-17T21:21:33.557654Z","iopub.execute_input":"2023-02-17T21:21:33.558905Z","iopub.status.idle":"2023-02-17T21:21:35.325352Z"}}
# principais 500 rotas dos membros
membro_rota_mapa <- ggmap(get_googlemap(center=c(lon=-87.6197, lat=41.8888), zoom = 13, maptype="terrain", color="bw"))+
  geom_point(data=estacoes, aes(x=estacao_long, y=estacao_lat), size=0.5, color="red") + 
  geom_curve(membro_rota, mapping = aes(x = long_saida, y = lat_saida, xend = long_chegada, yend = lat_chegada, alpha= total), color="blue", size = 1, curvature = 0.2) +
  coord_cartesian()+
  labs(title="Principais Rotas de Membros", x=NULL, y=NULL, alpha= "Total de Viagens") + 
   theme(axis.text.x = element_blank(), axis.ticks.x=element_blank(),
        axis.text.y = element_blank(), axis.ticks.y=element_blank(),
        plot.title = element_text(size=14, face="bold"),
        legend.title= element_text(size = 10, face = "bold"),
        legend.text = element_text(size = 10))
print(membro_rota_mapa)

# %% [markdown]
# #### Análise
# 
# * As principais rotas dos usuários casuais apontam para um fluxo em regiões turísticas e de lazer, como o Olive Park e Piers.
# 
# * As principais rotas dos membros são mais diversificadas e espalhadas, tendo forte fluxo, por exemplo, para a University-Illinois e para o centro da cidade.

# %% [markdown]
# 
# 
# 

# %% [markdown]
# ---
# 
# ## Evidências da diferença da utilização das biciletas
# 
# #### 1. Usuários Membros Clyclistic
# 
# * Têm um maior volume de viagens em dias úteis, com duração pragmática das bicicletas, utilizando-as principalmente como meio de transporte para deslocar para a universidade ou regiões comerciais.
# 
# 
# #### 2. Usuários Casuais
# 
# * Têm um maior número de viagens e tempo de duração das viagens aos finais de semana, usando as bicicletas principalmente como opção de lazer.
# 
# * Apresentam um uso sazonal das bicicletas com pico da demanda entre os meses de Maio e Outubro, apresentando forte queda entre novembro e abril. Esse fato ocorre essencialmente em razão das mudanças climáticas.

# %% [markdown] {"execution":{"iopub.status.busy":"2023-02-15T18:54:45.557363Z","iopub.execute_input":"2023-02-15T18:54:45.559539Z","iopub.status.idle":"2023-02-15T18:54:45.573650Z"}}
# ---
# <a id="Agir"></a>
# # Agir

# %% [markdown]
# ### Orientações de ações a serem tomadas pela Cyclistic:
# 
# 1. Criar uma modalidade de assinatura anual para utilização das bicicletas aos finais de semana. Como a estação com maior adesão de usuários casuais é no verão, o início da divulgação dessa modalidade de assinatura deve ocorrer já na primavera. Para essa campanha recomenda-se a utilização das redes sociais para divulgação (instagram, twitter, facebook) e também com **outdoors nas estações onde há maior fluxo de usuários casuais**.
# 
# 2. **Criar um aplicativo mobile** que vincule os deslocamentos do usuário - através de um ID de usuário - com a viagem realizada - através do ID da viagem - para que os usuários acompanhar e também compartilhar suas viagens nas redes sociais. 
# 
# 3. **Criar um plano de fidelidade** e benefícios para os assinantes com premiações com base na quantidade de Kms percorridos pelo membro.
# 
# 4. **Realizar um estud** o de tempo de percurso de automóvel no centro de Chicago em horários de pico e comparar com o tempo do mesmo percurso utilizando bicicletas para mostrar para usuários casuais que a utilização das bicicletas para deslocar ao serviço pode acabar poupando tempo no dia deles. Caso o estudo for positivo, realizar campanha de marketing em mídias sociais e outdoors divulgando o estudo.