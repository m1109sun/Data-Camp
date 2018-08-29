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

## Types of variables in R
## numeric : 23.44, 120, NaN, Inf
## integer : 4L, 1123L
## factor : factor("Hello"), factor(8)
## logical : TRUE, FALSE, NA

## Type conversions
as.numeric(TRUE)

## Dates with lubridate
library(lubridate)
ymd("2015-08-25")
dmy("25 August 2015")
hms("13:33:09")
ymd_hms("2015/08/25 13.33.09")

## Key functions in stringr for cleaning data
library(stringr)
str_trim("   this is a test   ") 
str_pad("24493", width = 7, side = "left", pad = "0")
friends <- c("Sarah", "Tom", "Alice")
str_detect(friends, "Alice")
str_replace(friends, "Alice", "David")

## Other helpful functions in base R
## tolower : make all lowercase
## toupper : make all uppercase
tolower("I AN TALKING LOUDLY!!")
toupper("I an whispering...")

## Trimming and padding strings
str_trim(c("   Filip ", "Nick  ", " Jonathan"))
str_pad(c("23485W", "8823453Q", "994Z"), width = 9, side = "left", pad = "0")

## Missing values
## May be random, but dangerous to assume
## Sometimes associated with variable/outcome of interest
## in R, represented as NA
## May apper in other forms

## Special values
## Inf : Infinite value (indicative of outliers?)
1/0
1/0 + 1/0
33333^33333
## NaN : Not a number (rethink a variable?)
0/0
1/0 - 1/0

## Finding missing values
df <- data.frame(A = c(1, NA, 8, NA),
                 B = c(3, NA, 88, 23),
                 C = c(2, 45, 3, 1))
is.na(df)
any(is.na(df))
sum(is.na(df))

## Dealing with missing values
complete.cases(df) # find rows with no missing values
df[complete.cases(df), ]
na.omit(df)

## Outliers
set.seed(10)
x <- c(rnorm(30, mean = 15, sd = 5), -5, 28, 35)
boxplot(x, horizontal = TRUE)

## Finding outliers and errors
df2 <- data.frame(A = rnorm(100, 50, 10),
                  B = c(rnorm(99, 50, 10), 500),
                  C = c(rnorm(99, 50, 10), -1))
summary(df2)
hist(df2$B, greaks = 20)
boxplot(df2)



aaaaaa