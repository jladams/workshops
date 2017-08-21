
# Etherpad at dartgo.org/qbs-etherpad

setwd("./20170821_qbs/")


# INSTALL TIDYVERSE, EVERYONE


# Start off with Iris dataset, subsetting in base R
data(iris)

View(iris)

# Store it as a separate thing
df <- iris

# All three of these are the same
df$Sepal.Length
df[1]
df[,1]

# Rows
df[1,]

# We can get more than just one row or column
df[1:10,]
df[1:10, 1:2]

# We can do negative selection
df[1:10, -1]
df[1:10, -(1:3)]

# We can add columns
df$id <- 1:nrow(df)


# Let's try subsetting using a condition
which(df$Species == "virginica")

# If we just use the numbers, it looks like this
df[101:150,]

# Replace it with the which() function we used before
df[which(df$Species == "virginica"), ]

# Save it as a new data frame
test <- df[which(df$Species == "virginica"), ]

# Try it numerically (name, petal width, and ID of all which have a Sepal Length less than 6)
test <- df[which(df$Sepal.Length < 6), 4:6]



# dplyr to do these same things
library(tidyverse)

filter()
select()
mutate()

# A couple of other things we'll talk about later
group_by()
summarize()


# getting started
setosas <- filter(df, Species == "setosa")
setosas_sepal <- select(setosas, Sepal.Length, Species, id)

setosas <- select(filter(df, Species == "setosa"), Sepal.Length, Species, id)


# Using the Pipe

foo_foo <- little_bunny()

bop(scoop_up(hop_through(foo_foo, forest), field_mouse), head)

foo_foo %>%
  hop_through(forest) %>%
  scoop_up(field_mouse) %>%
  bop(head)



setosas <- df %>%
  filter(Species == "setosa")

setosas <- df %>%
  filter(Species == "setosa") %>%
  select(Sepal.Length, Species, id)

df2 <- iris %>%
  mutate(id = row_number())


# TALK ABOUT TIDY DATA NOW

# Tidying the iris dataset
tidy <- df %>%
  gather(key = variable, value = value, Sepal.Length:Petal.Width)

# Trying it with something a little messier
wide <- read_csv("http://dartgo.org/qbs_iris")

tidy <- wide %>%
  gather(key = bad_id, value = value, setosa_1:ncol(wide))

tidy <- wide %>%
  gather(key = bad_id, value = value, setosa_1:ncol(wide)) %>%
  separate(col = bad_id, into = c("species", "id"), sep = "_")

# Getting back to our original dataset
df_normal <- wide %>%
  gather(key = bad_id, value = value, setosa_1:ncol(wide)) %>%
  separate(col = bad_id, into = c("species", "id"), sep = "_") %>%
  spread(key = variable, value = value)

# Using group_by and summarize
# Split - Apply - Combine
species_means <- df %>%
  group_by(Species) %>%
  summarize(pl = mean(Petal.Length), pw = mean(Petal.Width), sl = mean(Sepal.Length), sw = mean(Sepal.Width))

# Using a Star Wars Example
View(starwars)

sw_heights <- starwars %>%
  group_by(homeworld, species) %>%
  summarize(mean_height = mean(height))


