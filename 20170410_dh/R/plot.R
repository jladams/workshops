library(tidyverse)

df <- data_frame(x = rnorm(50, mean = 25, sd = 7), 
                 y = rnorm(50, mean = 25, sd = 7), 
                 size = c(rep(5L, 49), 6),
                 plot = rep(c(1, 2), 25))

ggplot(df, aes(x = x, y = y, size = size)) +
  geom_point(color = "steelblue") +
  facet_grid(.~plot) +
  theme(text = element_blank(), 
        legend.position = "none", 
        line = element_blank(), 
        plot.background = element_rect(fill = "black")) +
  scale_size_continuous(range = c(2,5))
