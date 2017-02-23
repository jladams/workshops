
library(tidyverse)


df <- read_csv("~/Downloads/gapminder_wide-csv.csv")

ggplot(df, aes(x = year, y = value)) +
  geom_line(aes(group = country, color = continent))


