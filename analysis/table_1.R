
# # # # # # # # # # # # # # # # # # # # #
# This script creates a table 1 of baseline characteristics
# # # # # # # # # # # # # # # # # # # # #

# Preliminaries ----

## Import libraries ----
library('tidyverse')
library('here')
library('glue')
library('gt')
library('gtsummary')

# ## import functions ----
# 
# source(here("analysis", "functions", "redaction_functions.R"))

## Import processed data ----
data_cohort <- read_csv(here::here("output", "input.csv"))

###########################################
## Create tableone using gtsummary R package
###########################################

# factorise variables we are stratifying by

data_cohort$asthma <- as.factor(data_cohort$asthma)

# create dunmmy variable and assign 1 for all, because redaction function doesn't work without "by" argument

data_cohort$tbl_dummy <- 1
data_cohort$tbl_dummy <- as.factor(data_cohort$tbl_dummy)

# WHOLE POPULATION

table1_all <- data_cohort %>%
  select(age, sex, bmi, imd, ethnicity_6_sus, asthma, aplastic_anaemia, tbl_dummy) %>%
  tbl_summary(statistic = list(all_continuous() ~ "{mean} ({sd})"))

# table1_all_redacted <- redact_tblsummary(table1_all, 5, "[REDACTED]")

# STRATIFY BY ASTHMA

table1_strata <- data_cohort %>%
  select(age, sex, bmi, imd, ethnicity_6_sus, asthma, aplastic_anaemia) %>%
  tbl_summary(statistic = list(all_continuous() ~ "{mean} ({sd})"),
              by = asthma)

# table1_strata_redacted <- redact_tblsummary(table1_strata, 5, "[REDACTED]")

# Save to CSV files
# write.csv(table1_all$table_body, here::here("output", "descriptive", "tables", "table1.csv"))
# write.csv(table1_strata$df_by, here::here("output", "descriptive", "tables", "table1_asthma.csv"))
# Save to HTML 
gtsave(as_gt(table1_all), here::here("output", "descriptive", "tables", "table1.html"))
gtsave(as_gt(table1_strata), here::here("output", "descriptive", "tables", "table1_asthma.html"))
