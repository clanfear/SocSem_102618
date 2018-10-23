library(xaringanthemer)
library(dplyr)
library(ggplot2)
library(knitr)
library(tidyr)
library(forcats)

load("../../Experiments/Littering Intervention/data/litter_data.RData")
# load("../../Experiments/Littering Intervention/data/litter_data_indiv.RData")
litter_data %>%
  group_by(condition, confederate) %>%
  count(sanction) %>%
  group_by(condition, confederate) %>%
  summarize(prob_sanction = round(last(n)/first(n),3)) %>%
  mutate(confederate = fct_recode(confederate, `Black<br>Male`="TP", `White<br>Male`="CL", `White<br>Female`="LB")) %>%
  spread(confederate, prob_sanction) %>%
  rename(Condition=condition)

litter_data %>%
  group_by(condition, confederate) %>%
  count(sanction) %>%
  ungroup() %>%
  filter(sanction==1) %>%
  select(-sanction) %>%
  mutate(confederate = fct_recode(confederate, `Black<br>Male`="TP", `White<br>Male`="CL", `White<br>Female`="LB")) %>%
  spread(confederate, n) %>%
  rename(Condition=condition)

litter_data %>%
  group_by(condition, confederate) %>%
  count(throw_away) %>%
  group_by(condition, confederate) %>%
  summarize(prob_throw_away = round(last(n)/first(n),3)) %>%
  mutate(confederate = fct_recode(confederate, `Black<br>Male`="TP", `White<br>Male`="CL", `White<br>Female`="LB")) %>%
  spread(confederate, prob_throw_away) %>%
  rename(Condition=condition)

litter_data %>%
  group_by(condition, confederate) %>%
  count(throw_away) %>%
  ungroup() %>%
  filter(throw_away==1) %>%
  select(-throw_away) %>%
  mutate(confederate = fct_recode(confederate, `Black<br>Male`="TP", `White<br>Male`="CL", `White<br>Female`="LB")) %>%
  spread(confederate, n) %>%
  rename(Condition=condition)

# summary(glm(sanction~condition+confederate, data=litter_data, family=binomial(link="logit")))
# summary(glm(sanction~condition*confederate, data=litter_data, family=binomial(link="logit")))
# summary(glm(sanction~condition+mailed, data=litter_data %>% mutate(mailed = (`Personal Mailed` + `BLM Mailed`)/2 ), family=binomial(link="logit")))
# 
# summary(glm(throw_away~condition+confederate, data=litter_data, family=binomial(link="logit")))
# summary(glm(throw_away~condition+confederate+`Collective Efficacy`, data=litter_data, family=binomial(link="logit")))
# summary(glm(throw_away~mailed, data=litter_data %>% mutate(mailed = (`Personal Mailed` + `BLM Mailed`)/2 ), family=binomial(link="logit")))
# summary(glm(throw_away~`Collective Efficacy`, data=litter_data %>% mutate(mailed = (`Personal Mailed` + `BLM Mailed`)/2 ), family=binomial(link="logit")))

# chisq.test(with(litter_data[litter_data$sanction==1,], table(condition, confederate)))

