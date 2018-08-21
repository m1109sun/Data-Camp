# Introduction and exploring raw data

## Exploring raw data
## Understand the structure of your data
## Look at your data
## Visualize your data

## Visualizing your data
## hist() : View histogram of a single variable
## plot() : View plot of two variables

# Tidying data
library(tidyr)

## Gather columns into key-value pairs
## gather(data, key, value, ...)
## data : a data frame
## key : bare name of new key column
## value : bare name of new value column
## ... : bare names of columns to gather (or not)
wide_df <- data.frame(col = c("X", "Y"), A = c(1, 4), B = c(2, 5), C = c(3, 6))
gather(wide_df, my_key, my_val, -col)

## Spread key-value pairs into columns
## spread(data, key, value)
## data : a data frame
## key : bare name of column containing keys
## value : bare name of column containing values
long_df <- gather(wide_df, my_key, my_val, -col)
spread(long_df, my_key, my_val)

## Separate columns
## separate(data, col, into)
## data : a data frame
## col : bare name of column to separate
## into : character vector of new column names
treatments <- data.frame(patient = rep(c("X", "Y"), times = 3), treatment = rep(c("A", "B"), each = 3), year_mo = rep(c("2010-10", "2012-08", "2014-12"), each = 2), response = c(1, 4, 2, 5, 3, 6))
treatments <- separate(treatments, year_mo, c("year", "month"))

## Unite columns
## unite(data, col, ...)
## data : a data frame, sep = "-"
## col : bara name of new column
## ... : bare names of columns to unite
treatments <- unite(treatments, year_mo, year, month, sep = "-")

# Preparing data for analysis









