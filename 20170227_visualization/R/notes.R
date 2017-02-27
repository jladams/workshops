
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
  cat("My integer is ",my_int," and your integer is ",your_int) # Prints out a result telling us each our numbers
}

new_fun(4) # Try it out with any number


# Install Packages We'll Use
install.packages("tidyverse")
install.packages("gapminder")

library(tidyverse)
library(gapminder)

data(gapminder)

# Write data
write_csv(gapminder, "./20170227_visualization/data/gapminder.csv")

# Read data
df <- read_csv("./20170227_visualization/data/gapminder.csv")

# Plotting with ggplot2
ggplot(data = df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Base plot
ggplot(data = df, aes(x = gdpPercap, y = lifeExp))

# CHALLENGE: Modify the example so that it shows how life expectancy has changed over time
ggplot(data = df, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

# Let's bring in a little color
ggplot(data = df, aes(x = year, y = lifeExp, color=continent)) +
  geom_point()

# Lines instead of points
ggplot(data = df, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_line()

# Demonstrate how we build things up by layers
ggplot(data = df, aes(x=year, y=lifeExp, by=country)) +
  geom_line(aes(color=continent)) + 
  geom_point()

# Changing the order matters
ggplot(data = df, aes(x=year, y=lifeExp, by=country)) +
  geom_point() +
  geom_line(aes(color=continent))


# We can do some statistical modelling as well - let's go back to our first example
ggplot(data = df, aes(x = gdpPercap, y = lifeExp, color=continent)) +
  geom_point()

# Hard to see relationship among points because of outliers, so let's adjust the scale
ggplot(data = df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10()

# Now we can demonstrate a relationship with a linear model
ggplot(data = df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  geom_smooth(method="lm")

# We can use locally weighted regression, as well
ggplot(data = df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  geom_smooth(method="loess")

# We can mess around with the aesthetics of the line, too - talk about why this doesn't have to go in aes()
ggplot(data = df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  geom_smooth(method="lm", size=1.5)

# CHALLENGE - using your knowledge of how to assign aesthetics, how would you turn all of the points orange and set their size to 3?
ggplot(data = df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5)

# Solution
ggplot(data = df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(size=3, color="orange") + scale_x_log10() +
  geom_smooth(method="lm", size=1.5)

# CHALLENGE - How would you assign colors based on continent, and also give each continent a geom_smooth() with the appropriate color?
ggplot(data = df, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5)

# Faceting / Multi-panel figures
# This is a way to demonstrate more variables than you might able to put on just one chart
asia <- df %>%
  filter(continent == "Asia")

ggplot(asia, aes(x = year, y = lifeExp, color = country)) +
  geom_line() +
  facet_wrap( ~ country)

# Remove the legend
ggplot(asia, aes(x = year, y = lifeExp, color = country)) +
  geom_line() +
  facet_wrap( ~ country) +
  scale_color_discrete(guide = FALSE)

# We can define how we want to facet in certain directions
# Facets along Y axis
ggplot(data = df, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5) +
  facet_grid(continent~.)

# Facets along X axis
ggplot(data = df, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5) +
  facet_grid(.~continent)

# Both
ggplot(data = df, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5) +
  facet_grid(year~continent)

# Customizing with themes
ggplot(data = df, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5) +
  facet_grid(year~continent) +
  theme_bw()


# Other Resources
# ggplot2 cheat sheet: https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
# RStudio cheat sheet: https://www.rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf
# Data wrangling (tidyr and dplyr) cheat sheet: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

