##################################################################################
# 
# Description: This script reads in the input data and generates some simple
#              figures to describe the dataset and key variables.
#
# Input: output/input.csv
# Output: output/
#
# Author(s): Kurt Taylor
#
# Date last updated: 21/02/2022
#
##################################################################################

## libraries ----

library('tidyverse')
library('ggplot2')

## import data ----

df_input <- read_csv(
  here::here("output", "input.csv"),
  col_types = cols(patient_id = col_integer(),age = col_double())
)

## PLOT 1 from OS test repo ----

plot_age <- ggplot(data=df_input, aes(df_input$age)) + geom_histogram()

ggsave(
  plot= plot_age,
  filename="descriptive.png", path=here::here("output"),
)

## PLOT 2 histogram ----
# distribution of age stratified by asthma diagnosis

df_input$asthma <- as.factor(df_input$asthma)

hist_asthma <- ggplot(df_input, aes(x=age, fill=asthma)) +
  scale_fill_manual(values = c('red', 'blue')) +
  geom_histogram(alpha=0.2, position="identity")

ggsave(
  plot= hist_asthma,
  filename="hist_asthma.png", path=here::here("output"),
)
