# Vector

## Naming a vector (1)
poker_vector <- c(140, -50, 20, -120, 240)
names(poker_vector) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

## Naming a vector (2)
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
names(poker_vector) <- days_vector

## Advanced selection
selection_vector <- poker_vector > 0
poker_winning_days <- poker_vector[selection_vector]

# Matrix

## Calculating the worldwide box office
box_office <- c(460.998, 314.4, 290.475, 247.900, 309.306, 165.8)
star_wars_matrix <- matrix(box_office, nrow = 3, byrow = TRUE,
                           dimnames = list(c("A New Hope", "The Empire Strikes Back", "Return of the Jedi"), 
                                           c("US", "non-US")))
worldwide_vector <- rowSums(star_wars_matrix)

# Factor

## Factor levels
temperature_vector <- c("High", "Low", "High","Low", "Medium")
factor_temperature_vector1 <- factor(temperature_vector, order = TRUE, levels = c("Low", "Medium", "High")) # or
factor_temperature_vector1 <- factor(temperature_vector, ordered = TRUE, levels = c("Low", "Medium", "High"))
factor_temperature_vector1
temperature_vector <- c("High", "Low", "High","Low", "Medium")
factor_temperature_vector2 <- factor(temperature_vector, levels = c("Low", "Medium", "High"))
factor_temperature_vector2

survey_vector <- c("M", "F", "F", "M", "M")
factor_survey_vector <- factor(survey_vector)
levels(factor_survey_vector) <- c("Female", "Male")
factor_survey_vector

# Data frame

## Selection of data frame elements(특정 컬럼에서 몇 개만 추출하는 방법)
mtcars[1:5, "mpg"] # mpg 변수에서 1:5번째 값 추출

mt <- data.frame(name = c("A", "B", "C", "D", "E", "F"), car = c(20, 50, -10, 30, 15, 40), val1 = c(TRUE, TRUE, FALSE, FALSE, TRUE, FALSE))
val2 <- c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE)
mt[val, "name"] # mt에서 name 변수가 val이 TRUE인 값만 추출 # or
mt[val,] # mt에서 val이 TRUE인 전체 추출

subset(mt, subset = val1) 
subset(mt, subset = car < 25)

## Sorting
car_order <- order(mt$car)
mt[car_order, ]

# List

## Creating a named list
my_vector <- 1:10 
my_matrix <- matrix(1:9, ncol = 3)
my_df <- mtcars[1:10,]
my_list1 <- list(my_vector, my_matrix, my_df)
names(my_list1) <- c("vec", "mat", "df") # or
my_list2 <- list(vec = my_vector, mat = my_matrix, df = my_df)

## Selecting elements from a list
my_list1[["vec"]]
my_list1$vec

## Adding more movie information to the list
my_list3 <- list(my_list1, year = 1980)

