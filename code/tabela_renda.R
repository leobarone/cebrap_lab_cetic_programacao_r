rm(list=ls())
library(tidyverse)
library(srvyr)

ticdom_url <- "http://cetic.br/media/microdados/181/ticdom_2017_individuos_base_de_microdados_v1.3.csv"

ticdom <- read_csv2(ticdom_url)

ticdom_srvy <- ticdom %>%
  as_survey_design(ids = UPA, strata = ESTRATO, weights = PESO)

ticdom_srvy %>%
  mutate(renda = as.factor(RENDA_PESSOAL)) %>% 
  group_by(C1, renda) %>%
  summarise(n = survey_total()) %>% 
  View()

ticdom_srvy %>%
  mutate(renda = as.factor(RENDA_PESSOAL)) %>% 
  group_by(C1, renda) %>%
  summarise(n = survey_total()) %>%
  group_by(renda) %>%
  mutate(prop = n/sum(n)) %>%
  filter(C1==1) 
