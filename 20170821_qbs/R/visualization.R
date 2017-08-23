setwd("./20170821_qbs/")

# Clear working environment to start
rm(list = ls())


plot(x = iris$Petal.Length, y = iris$Petal.Width, col = iris$Species)


# Load tidyverse
library(tidyverse)


# Messing with irises again
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point()

ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) 

ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point()

ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point() 

ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species)) +
  geom_smooth(method = "lm")


# Looking at a new dataset
View(diamonds)

# Start simple
# Histograms
ggplot(diamonds, aes(x = carat)) +
  geom_histogram()

# Adjust binwidth as necessary
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(bins = 40)

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(bins = 10)

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(bins = 15)

# Quick color adjustment
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(bins = 15, color = "black", fill = "steelblue")


# Categorical Variables
# Bar plots, defaults to stat = "count"
ggplot(diamonds, aes(x = cut)) +
  geom_bar()

ggplot(diamonds, aes(x = cut)) +
  geom_bar(stat = "count")

# Using some of the dplyr we learned Monday
diamonds %>%
  group_by(cut) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = cut, y = count)) +
  geom_col() +
  geom_text(aes(label = count))

# Boxplots
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

# Violin plots
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_violin()

# Creating basic scatterplots
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point()

# Layering geometry
# Points created first, line drawn on top
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth()

# Line created first, points drawn on top
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_smooth() + 
  geom_point() 

# How to use color
# This applies the color to everything - global ggplot call carries to all geom_*
ggplot(diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point() +
  geom_smooth()

# If we want to color the points based on the cut of the diamond
# This doesn't work.
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(color = cut) +
  geom_smooth()

# This does! Using the data to color the data requires the aes() function
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = cut)) +
  geom_smooth()

# This changes all of the points
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(color = "orange") +
  geom_smooth()

# This creates a color based on one value, "orange." It doesn't involve the color "orange" at all.
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = "orange")) +
  geom_smooth()

# Colors can be continuous, also
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) 

# Labels
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption")

# Legend label, and color customization
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(guide = guide_colorbar(title = "Table of Diamond"))

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond"))

# Using built-in themes
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_dark()

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_bw()

# Customizing themes further
# Moving Legend
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_bw() +
  theme(legend.position = "bottom")

# Changing Font Family
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(family = "mono"))

# Changing font for specific elements
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(family = "mono"), plot.title = element_text(family = "sans"))

# Facets / Small Multiples
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(family = "mono"), plot.title = element_text(family = "sans")) +
  facet_wrap(~clarity)

# Facet in specific directions
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(family = "mono"), plot.title = element_text(family = "sans")) +
  facet_grid(cut~.)

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(family = "mono"), plot.title = element_text(family = "sans")) +
  facet_grid(.~cut)

# Facet in both directions
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(family = "mono"), plot.title = element_text(family = "sans")) +
  facet_grid(color~cut)

# Saving
p <- ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = table)) +
  labs(x = "Carat", y = "Price (USD)", title = "Price vs. Carat", subtitle = "Data from ggplot2", caption = "This is a caption") +
  scale_color_continuous(low = "yellow", high = "blue", guide = guide_colorbar(title = "Table of Diamond")) +
  theme_bw() +
  theme(legend.position = "bottom", text = element_text(family = "mono"), plot.title = element_text(family = "sans")) +
  facet_grid(color~cut)

# Lots of file formats, for instance:
ggsave(plot = p, filename = "./images/diamonds.png")
ggsave(plot = p, filename = "./images/diamonds.svg")
ggsave(plot = p, filename = "./images/diamonds.eps")


# Other options, too. Remember that width and height are defined in inches by default
ggsave(plot = p, filename = "./images/diamonds.png", dpi = 1200, width = 8, height = 6)



