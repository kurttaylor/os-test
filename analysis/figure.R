library('tidyverse')

setwd("/Users/kt17109/OneDrive - University of Bristol/ehr_postdoc/os_test/os-test")

df_input <- read_csv(
  here::here("output", "input.csv"),
  col_types = cols(patient_id = col_integer(),age = col_double())
)

plot_age <- ggplot(data=df_input, aes(df_input$age)) + geom_histogram()

ggsave(
  plot= plot_age,
  filename="descriptive.png", path=here::here("output"),
)

# add new line
