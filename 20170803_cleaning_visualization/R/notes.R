setwd("~/projects/workshops/20170803_cleaning_visualization/")

# Getting Started With R
# Variables
new_int <- 4 # 'new_int' is a name we made up - variables can be called whatever is easy for you to remember
new_int

cos(new_int) # Finds the cosine of the value stored in new_int
cos(4)

# Functions
new_fun <- function(x) { # Creates a function called new_fun that takes one argument, "x"
  my_int <- x # Stores "x" as my_int
  your_int <- my_int * 2 # Stores x * 2 as your_int
  cat("My integer is ", my_int, " and your integer is ", your_int) # Prints out a result telling us each our numbers
}

new_fun(4) # Try it out with any number


install.packages("tidyverse")
library(tidyverse)

# Read in our data to use
df <- read_csv("./data/gapminder_wide.csv")

# Subsetting data
# select() and pipe
pop_1952 <- select(df, continent, country, pop_1952)

pop_1952 <- df %>%
  select(continent, country, pop_1952)

pop_1952 <- df %>%
  select(continent, country, pop_1952, pop_1957)


# How the pipe works
foo_foo <- little_bunny()

bop(
  scoop_up(
    hop_through(foo_foo, forest),
    field_mouse),
  head)

foo_foo %>%
  hop_through(forest) %>%
  scoop_up(field_mouse) %>%
  bop(head)


# filter()
high_pop_1952 <- df %>%
  select(continent, country, pop_1952) %>%
  filter(pop_1952 >= 10000000)


# Now to do some tidying
# Gather
df_tidy <- df %>%
  gather(variable, value, gdpPercap_1952:pop_2007)

# Gather + Separate
df_tidy <- df %>%
  gather(variable, value, gdpPercap_1952:pop_2007) %>%
  separate(variable, into = c("variable", "year"))

# Splitting them into separate tables
pop_tidy <- df_tidy %>%
  filter(variable == "pop")

lifeExp_tidy <- df_tidy %>%
  filter(variable == "lifeExp")

gdpPercap_tidy <- df_tidy %>%
  filter(variable == "gdpPercap")


# Plotting with ggplot2
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Base plot
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp))

# CHALLENGE: Modify the example so that it shows how life expectancy has changed over time
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

# Let's bring in a little color
ggplot(data = gapminder, aes(x = year, y = lifeExp, color=continent)) +
  geom_point()

# Lines instead of points
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_line()

# Demonstrate how we build things up by layers
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
  geom_line(aes(color=continent)) + 
  geom_point()

# Changing the order matters
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
  geom_point() +
  geom_line(aes(color=continent))


# We can do some statistical modelling as well - let's go back to our first example
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color=continent)) +
  geom_point()

# Hard to see relationship among points because of outliers, so let's adjust the scale
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10()

# Now we can demonstrate a relationship with a linear model
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  geom_smooth(method="lm")

# We can use locally weighted regression, as well
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  geom_smooth(method="loess")

# We can mess around with the aesthetics of the line, too - talk about why this doesn't have to go in aes()
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  geom_smooth(method="lm", size=1.5)

# CHALLENGE - using your knowledge of how to assign aesthetics, how would you turn all of the points orange and set their size to 3?
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5)

# Solution
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(size=3, color="orange") + scale_x_log10() +
  geom_smooth(method="lm", size=1.5)

# CHALLENGE - How would you assign colors based on continent, and also give each continent a geom_smooth() with the appropriate color?
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5)

# Faceting / Multi-panel figures
# This is a way to demonstrate more variables than you might able to put on just one chart
asia <- gapminder %>%
  filter(continent == "Asia")

ggplot(asia, aes(x = year, y = lifeExp)) +
  geom_line() +
  facet_wrap( ~ country)


# We can define how we want to facet in certain directions
# Facets along Y axis
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5) +
  facet_grid(continent~.)

# Facets along X axis
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5) +
  facet_grid(.~continent)

# Both
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5) +
  facet_grid(year~continent)

# Customizing with themes
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5) +
  facet_grid(year~continent) +
  theme_bw()

# Save Images
ggsave("gapminder.png")
ggsave("gapminder.jpg")
ggsave("gapminder.eps")
ggsave("gapminder.pdf")

# Other Resources
# ggplot2 cheat sheet: https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
# RStudio cheat sheet: https://www.rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf
# Data wrangling (tidyr and dplyr) cheat sheet: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf


