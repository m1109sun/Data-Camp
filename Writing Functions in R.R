# A quick refresher

## Three parts of a function
add <- function(x, y = 1) {
  x + y
}

formals(add)
body(add)
environment(add)

## Output : return value
## The last expression evaluated in a function is the return value 
## return(value) forces the function to stop execution and return value
## return value is the last executed expression, or the first executed return() statement
f <- function(x) {
  if (x < 0) {
    -x
  } else {
    x
  }
}
f(-5)
f(15)

## Functions are objects
f2 <- f # function을 그대로 copy한 거나 마찬가지
function(x) { x + 1 } # function을 한 줄에 쓸 수 있음
(function(x) { x + 1 })(2)

## Arguments
## ?mean을 하면 mean(x, trim = 0, na.rm = FALSE)가 나옴(밑에 처럼 적는게 바람직함)
mean(c(1:9, NA), trim = 0.1, na.rm = TRUE)

## Function output
## If the test_expression is TRUE, the statement gets executed. But if it’s FALSE, nothing happens.
f <- function(x) {
  if (TRUE) {
    return(x + 1)
  }
  x
}
f(2) # 3

f <- function(x) {
  if (FALSE) {
    return(x + 1)
  }
  x
}
f(2) # 2

## Difference
## 1
f <- function() {
  x <- 1
  y <- 2
  c(x, y)
}
f() # 1 2

## 2
g <- function() {
  y <- 1
  c(x, y)
}
g() # Error in g() : object 'x' not found

## 3
x <- 2
g <- function() {
  y <- 1
  c(x, y)
}
g() # 2 1

## Scoping describes where, not when, to look for a value
f <- function() x
x <- 15
f()

x <- 20
f()

## Lookup works the same for functions
m <- function() {
  l <- function(x) x * 2
  l(10)
}
m()

## Each call to a function has its own clear environment
j <- function() {
  if (!exists("a")) {
    a <- 1
  } else {
    a <- a + 1
  }
  print(a)
}
j() # 1
a # object 'a' not found

## Summary
## When you call a function, a new environment is made for the function to do its work
## The new environment is populated with the argument values
## Objects are looked for first in this environment
## If they are not found, they are looked for in the environment that the function was created in

## Every vector has two key properties
typerof(letters) # character
typeof(1:10) # integer
length(letters) # 26
x <- list("a", "b", 1:10)
length(x) # 3

## Missing values
## NULL often used to indicate the absence of a vector
## NA used to indicate the absence of a value in a vector, a.k.a. a missing value
typeof(NULL) # NULL
length(NULL) # 0
typeof(NA) # logical
length(NA) # 1

## NAs inside vectors
x <- c(1, 2, 3, NA, 5)
is.na(x)

## Missing values are contagious
10 == NA # NA
NA == NA # NA

## Lists
## Useful because they can contain heterogeneous objects
## Complicated return objects are often lists, i.e. from lm()
## Created with list()
## Subset with [, [[, or $
## [ extracts a sublist
## [[ and $ extract elements, remove a level of hierarchy

## Subsetting lists
a <- list(
  a = 1:3,
  b = "a string",
  c = pi,
  d = list(-1, -5)
)
str(a[4])
str(a[[4]])

## Subset the wt element
tricky_list[["model"]][["coefficients"]][["wt"]] # tricky_list가 없어서 돌아가지는 않음

## A safer way to create the sequence
## Replace the (i in 1:ncol(df)) sequence with (i in seq_along(df)) 
df <- data.frame(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
) 
for (i in seq_along(df)) {
  print(median(df[[i]]))
}

## Keeping output
df <- data.frame(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
output <- vector("double", ncol(df)) # Create new double vector: output
for (i in seq_along(df)) { # Alter the loop
  # Change code to store result in output
  output[[i]] = median(df[[i]])
}
output # Print output

# When and how you should write a function

## Function names 
### should generally be verbs and
### should be descriptive
### ex) impute_mising, collapse_years

## Argument names 
### should generally be nouns
### use very common short names when appropriate
### x, y, z : vectors
### df : data frame
### i, j : numeric indicies of rows and columns respectively
### n, p : length or rows and columns respectively

## Argument Order 
### Data arguments first, the data to be used for the calculation
### Detail arguments next, ex) confidence level
### Detail arguments should have sensible defaults
### Use an intuitive argumnet order

# Functional programming

## Function example  
col_median <- function(df) {
  output <- numeric(length(df))
  for (i in seq_along(df)) {
    output[[i]] <- median(df[[i]])
  }
  output
}

## Introducing purrr
## purrr is a functional programming toolset for r 
### purr vignette
## It has a bunch of functions for mapping functions to data
## The map functions all work like this 
### Loop over a vector .x
### Apply the function .f to each element
### Return the results
## There is one map function for each type 
### map returns a list
### map_dbl returns a vector of doubles
### map_lgl returns a vector of logicals
### map_int same for integers
### map_chr same for characters
## It can handle different types of inputs 
### For data frames it will iterate over the columns
### For lists it will iterate over the elements
### For vectos it will iterate over the elements
## Advantages 
### Handy shortcuts for specifying .f
### More consistent than sapply, lapply functions

## The map functions
library(purrr)
head(df)
map_dbl(df, mean) # Use map_dbl() to find column means
map_dbl(df, median) # Use map_dbl() to column medians
map_dbl(df, sd) # Use map_dbl() to find column standard deviations

## Picking the right map function(df3은 존재하지 않아서 돌리면 error가 남)
map_lgl(df3, is.numeric) # Find the columns that are numeric
map_chr(df3, typeof) # Find the type of each column
map(df3, summary) # Find a summary of each column

## Specifying .f
map(df, function(x) sum(is.na(x))) # or
map(df, ~ sum(is.na(.)))

## Shortcuts when .f is [[
list_of_results <- list(
  list(a = 1, b = "A"),
  list(a = 2, b = "C"),
  list(a = 3, b = "D")
)

map_dbl(list_of_results, function(x) x[["a"]]) # or
map_dbl(list_of_results, "a") # or
map_dbl(list_of_results, 1)

## Using an anonymous function
map(cyl, function(df) lm(mpg ~ wt, data = df))


## Using a formula
map_dbl(cyl, function(df) mean(df$disp)) # or
map_dbl(cyl, ~ mean(.$disp))

# Advanced inputs and outputs

## Other adverbs for unusual output
## safely() captures the successful result or the error, always returns a list
## possibly() always succeeds, you give it a default value to return when there is an error
## quietly() captures printed output, messages, and warnings instead of capturing errors

## 

# Robust functions

