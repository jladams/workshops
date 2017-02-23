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
df <- read_csv("./20170222_cleaning/data/gapminder_wide.csv")

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


# Quick plot
ggplot(gdpPercap_tidy, aes(x = year, y = value)) +
  geom_line(aes(group = country, color = continent))
