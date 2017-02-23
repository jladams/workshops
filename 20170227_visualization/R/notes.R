install.packages(c("tidyverse", "gapminder", "plotly"))

library(tidyverse)
library(gapminder)
library(ggthemes)

data(gapminder)

# Write data
write_csv(gapminder, "./20170227_visualization/data/gapminder.csv")

# Read data
df <- read_csv("./20170227_visualization/data/gapminder.csv")

p <- ggplot(df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) +
  scale_x_log10()

print(p)


# library(plotly)

# ggplotly()
