library(srvyr)
library(survey)
library(dplyr)
library(readr)

ticdom_dic_url <-'http://cetic.br/media/microdados/154/ticdom_2017_domicilios_dicionario_de_variaveis_v1.1.xlsx'
download.file(ticdom_dic_url, "ticdom_dic.xlsx")
ticdom_dic <- readxl::read_excel("ticdom_dic.xlsx")

ticdom_url <- "http://cetic.br/media/microdados/153/ticdom_2017_domicilios_base_de_microdados_v1.1.csv"

ticdom <- ticdom_url %>%
  read_csv2()
str(ticdom)
head(ticdom$variables$id_domicilio)

ticdom %>%
  as_survey_design(strata = ESTRATO, ids = UPA) %>%
  group_by(TV_ASSINATURA) %>%
  summarise(n = n())

dstrata <- ticdom %>%
  as_survey_design(strata = stype, weights = pw)

desenho <- svydesign(id = ~UPA,
                     strata = ~ESTRATO,
                     data = ticdom)

ticdom %>%
  group_by(grau_instrucao) %>%
  summarize(n = n() )
