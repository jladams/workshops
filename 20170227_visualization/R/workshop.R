
new_fun <- function(x) {
  my_int <- x
  your_int <- x * 2
  cat("My integer is", my_int, "and your integer is", your_int)
}

new_fun(x = 7)


library(tidyverse)
library(gapminder)


data(gapminder)

View(gapminder)

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent)) +
  scale_x_log10()

oceania <- gapminder %>% filter(continent == "Oceania")

ggplot(data = oceania, aes(x = year, y = lifeExp, color = country)) +
  geom_line() +
  facet_wrap( ~ country)

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point() +
  scale_x_log10() +
  facet_grid(year~continent)


