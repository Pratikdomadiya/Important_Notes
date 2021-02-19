install.packages("dslabs")  # to install a single package
install.packages(c("tidyverse", "dslabs")) # to install two packages at the same time
installed.packages() # to see the list of all installed packages

library(tidyverse) # to load installed packages
library(dslabs)

# assigning values to variables
a <-2
b <--1
c <--4

# solving the quadratic equation
(-b + sqrt(b^2 - 4*a*c))/(2*a)
(-b - sqrt(b^2 - 4*a*c))/(2*a)

data()# to see all the dataset available in R for practice
help("package_name,function_name or anything")# see documentation of specific keyword
args('log')#to find out arguments details of "log" function

# loading the dslabs package and the murders dataset
library(dslabs)
data(murders)

# determining that the murders dataset is of the "data frame" class
class(murders)
# finding out more about the structure of the object
str(murders)
# showing the first 6 lines of the dataset
head(murders)

# using the accessor operator to obtain the population column
murders$population
# displaying the variable names/ columns names  in the murders dataset
names(murders)
# determining how many entries are in a vector
pop <- murders$population
length(pop)
# vectors can be of class numeric and character
class(pop)
class(murders$state)

# logical vectors are either TRUE or FALSE
z <- 3 == 2
z
class(z)

# factors are another type of class,Factors are useful for storing categorical data, 
#and are more memory efficient than storing characters.
class(murders$region)
# obtaining the levels of a factor OR all the unique values in that columns.
levels(murders$region)
nlevels(movielens$genres)#no. of different levels/unique values in "genres"


# The function sort() sorts a vector in increasing order.
# The function order() produces the indices needed to obtain the sorted vector, e.g. a result of  2 3 1 5 4 means the sorted vector will be produced by listing the 2nd, 3rd, 1st, 5th, and then 4th item of the original vector.
# The function rank() gives us the ranks of the items in the original vector.
# The function max() returns the largest value, while which.max() returns the index of the largest value. The functions min() and which.min() work similarly for minimum values.
sort(murders$total)

x <- c(31, 4, 15, 92, 65)
x
sort(x)    # puts elements in order

index <- order(x)    # returns index that will put x in order
x[index]    # rearranging by this index puts elements in order
order(x)

murders$state[1:10]
murders$abb[1:10]

index <- order(murders$total)
murders$abb[index]    # order abbreviations by total murders

max(murders$total)    # highest number of total murders
i_max <- which.max(murders$total)    # index with highest number of murders
murders$state[i_max]    # state name with highest number of total murders

x <- c(31, 4, 15, 92, 65)
x
rank(x)    # returns ranks (smallest to largest)

# In R, arithmetic operations on vectors occur element-wise.

# creating a logical vector that specifies if the murder rate in that state is less than or equal to 0.71
index <- murder_rate <= 0.71
# determining which states have murder rates less than or equal to 0.71
murders$state[index]
# calculating how many states have a murder rate less than or equal to 0.71
sum(index)

# creating the two logical vectors representing our conditions
west <- murders$region == "West"
safe <- murder_rate <= 1
# defining an index and identifying states with both conditions true
index <- safe & west
murders$state[index]

# The function which() gives us the entries of a logical vector that are true.
# The function match() looks for entries in a vector and returns the index needed to access them.
# We use the function %in% if we want to know whether or not each element of a first vector is in a second vector.
x <- c(FALSE, TRUE, FALSE, TRUE, TRUE, FALSE)
which(x)    # returns indices that are TRUE

# to determine the murder rate in Massachusetts we may do the following
index <- which(murders$state == "Massachusetts")
index
murder_rate[index]

# to obtain the indices and subsequent murder rates of New York, Florida, Texas, we do:
index <- match(c("New York", "Florida", "Texas"), murders$state)
index
murders$state[index]
murder_rate[index]

x <- c("a", "b", "c", "d", "e")
y <- c("a", "d", "f")
y %in% x

# to see if Boston, Dakota, and Washington are states
c("Boston", "Dakota", "Washington") %in% murders$state

# To change a data table by adding a new column, or changing an existing one, we use the mutate() function.
# To filter the data by subsetting rows, we use the function filter().
# To subset the data by selecting specific columns, we use the select() function.
# We can perform a series of operations by sending the results of one function to another function using the pipe operator, %>%.
# installing and loading the dplyr package
install.packages("dplyr")
library(dplyr)

# adding a column with mutate
library(dslabs)
data("murders")
murders <- mutate(murders, rate = total / population * 100000)

# subsetting with filter
filter(murders, rate <= 0.71)

# selecting columns with select
new_table <- select(murders, state, region, rate)

# using the pipe
murders %>% select(state, region, rate) %>% filter(rate <= 0.71)

# Formerly, the data.frame() function turned characters into factors by default. To avoid this, 
# we could utilize the stringsAsFactors argument and set it equal to false. As of R 4.0, it is no
# longer necessary to include the stringsAsFactors argument, because R no longer turns characters
# into factors by default.

# creating a data frame with stringAsFactors = FALSE
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), 
                     exam_1 = c(95, 80, 90, 85), 
                     exam_2 = c(90, 85, 85, 90),
                     stringsAsFactors = FALSE)


# the ifelse() function works similarly to an if-else conditional
a <- 0
ifelse(a > 0, 1/a, NA)

# the ifelse() function is particularly useful on vectors
a <- c(0,1,2,-4,5)
result <- ifelse(a > 0, 1/a, NA)

# the ifelse() function is also helpful for replacing missing values
data(na_example)
no_nas <- ifelse(is.na(na_example), 0, na_example) 
sum(is.na(no_nas))

# the any() and all() functions evaluate logical vectors
z <- c(TRUE, TRUE, FALSE)
any(z)#it returns "true" if at least one value in z is TRUE
all(z)#it returns "true" if all the values in z is TRUE

# we see that the avg function and the pre-built R mean() function are identical or not
x <- 1:100
identical(mean(x), avg(x))#returns true if identical otherwise false