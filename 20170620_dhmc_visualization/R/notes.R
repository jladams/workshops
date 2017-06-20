
# Data from: https://www.healthdata.gov/dataset/deaths-pnuemonia-and-influneza-and-all-deaths-state-and-region-national-center-health
# Etherpad at http://dartgo.org/2017-06-20-dhmc

setwd("~/projects/workshops/20170620_dhmc_visualization/")

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

# Add tidyverse
library(tidyverse)

# Read in CSV file from URL
df <- read_csv("http://dartgo.org/dhmc_flu")

# Times when it's fine for data not to be perfectly tidy
regional <- df %>%
  filter(geoid == "Region" & age == "All")

ggplot(regional, aes(x = flu, y = pneumonia)) +
  geom_point()

ggplot(regional, aes(x = flu, y = pneumonia))

ggplot(regional, aes(x = flu, y = pneumonia)) +
  geom_point(color = "red")

ggplot(regional, aes(x = flu, y = pneumonia)) +
  geom_point(aes(color = region))

ggplot(regional, aes(x = flu, y = pneumonia)) +
  geom_point(aes(color = region)) +
  scale_x_log10()

ggplot(regional, aes(x = flu, y = pneumonia)) +
  geom_point(aes(color = region)) +
  scale_x_log10() +
  geom_smooth(method = "lm")

# Other times when it's easier for it to be so
national <- df %>%
  filter(geoid == "National" & age == "All")

national_seasons <- national %>%
  group_by(season_start) %>%
  summarize(flu = sum(flu), pneumonia = sum(pneumonia), all_deaths = sum(all_deaths))

p <- ggplot(national_seasons) +
  geom_line(aes(x = season_start, y = flu)) +
  geom_text(aes(x = season_start, y = flu, label = flu)) +
  geom_line(aes(x = season_start, y = pneumonia)) +
  geom_text(aes(x = season_start, y = pneumonia, label = pneumonia)) +
  geom_line(aes(x = season_start, y = all_deaths)) +
  geom_text(aes(x = season_start, y = all_deaths, label = all_deaths))

print(p)

# A little bit of tidyr here.
national_tidy <- national_seasons %>%
  gather(variable, value, flu:all_deaths)

p <- ggplot(national_tidy) +
  geom_line(aes(x = season_start, y = value, group = variable, color = variable)) +
  geom_text(aes(x = season_start, y = value, label = value))

print(p)

national_age <- df %>%
  filter(geoid == "National" & age != "All") %>%
  group_by(season_start, age) %>%
  summarize(flu = sum(flu), pneumonia = sum(pneumonia)) %>%
  gather(illness, deaths, flu:pneumonia)


p_age <- ggplot(national_age, aes(x = illness, y = deaths)) +
  geom_bar(aes(fill = illness), stat = "identity") +
  facet_grid(age~season_start) 

print(p_age)
