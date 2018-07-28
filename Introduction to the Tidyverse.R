# Data wrangling

## Arranging observation by life expectancy
library(gapminder)
library(dplyr)
gapminder %>% arrange(lifeExp) # 오름차순
gapminder %>% arrange(desc(lifeExp)) # 내림차순

# Data visualization

## Putting the x-axis on a log scale
library(ggplot2)
gapminder_1952 <- gapminder %>%
  filter(year == 1952)
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point()
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10()
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()

## Adding color to a scatter plot
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()

## Adding size and color to a plot
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent,
                           size = gdpPercap)) +
  geom_point() +
  scale_x_log10()

## Creating a subgraph for each continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) + 
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent)

## Faceting by year
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, 
                      size = pop)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ year)

# Grouping and summarizing

## Visualizing median GDP per capita per continent over time
by_year_continent <- gapminder %>%
  group_by(continent, year) %>%
  summarise(medianGdpPercap = median(gdpPercap))
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, 
                              color = continent)) +
  geom_point() +
  expand_limits(y = 0) # to make sure the plot's y-axis includes zero

# Types of visualizations 

## Create a bar plot showing medianGDP by continent
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarise(medianGdpPercap = median(gdpPercap))
ggplot(by_continent, aes(x = continent, y = medianGdpPercap)) +
  geom_col()

## Create a histogram of population (pop), with x on a log scale
gapminder_1952 <- gapminder %>%
filter(year == 1952)
ggplot(gapminder_1952, aes(x = pop)) +
  geom_histogram() +
  scale_x_log10()

## Create a boxplot comparing gdpPercap among continents
gapminder_1952 <- gapminder %>%
filter(year == 1952)
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10() +
  ggtitle("gdp among continents") + # for the main title 
  xlab("conti") + # for the x axis label
  ylab("gdp") # for the y axis label

