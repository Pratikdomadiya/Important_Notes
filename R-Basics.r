 #To assign a value to a variable, use the <- sign.
 print(name)

 #To combine both text and a variable, R uses comma (,):
 text<- "language"
 paste("R is", text)

# Assign the same value to multiple variables in one line
var1 <- var2 <- var3 <- "Orange"
###################################################################################
Basic Data Types
    Basic data types in R can be divided into the following types:

        numeric - (10.5, 55, 787)
        integer - (1L, 55L, 100L, where the letter "L" declares this as an integer)
        complex - (9 + 3i, where "i" is the imaginary part)
        character (a.k.a. string) - ("k", "R is exciting", "FALSE", "11.5")
        logical (a.k.a. boolean) - (TRUE or FALSE)
We can use the class() function to check the data type of a variable:
    class(x) #WHERE X IS SOME VARIABLE.

Numbers
    There are three number types in R:
        numeric-A numeric data type is the most common type in R, and contains any number with or without a decimal, like: 10.5, 55, 787:
        integer-Integers are numeric data without decimals. This is used when you are certain that you will never create a variable that should contain decimals.
                 To create an integer variable, you must use the letter L after the integer value:
        complex-A complex number is written with an "i" as the imaginary part:

You can convert from one type to another with the following functions:
    as.numeric(x)

**MATH function**---> MAX,MIN,ABS,SQRT,CEILING,FLOOR..

str <- "Hello World!" 
grepl("H", str)# CHECK IF CHAR "H" IS PRESENT IN STR OR NOT.
paste(str1, str2)#COMBINE TWO STRINGS

R divides the operators in the following groups:

    Arithmetic operators-  +(Addition),-,/,*,^(EXPONENT),%%(MODULAS),%/%(INTEGER DIVISER)
    Assignment operators- <<-(GLOBAL ASSIGNEER),<- OR ->(ASSIGNEER)
    Comparison operators- ==,!=,<,>,<=,>=
    Logical operators- &,&&,|,||,!
    Miscellaneous operators-     ":"	Creates a series of numbers in a sequence	x <- 1:10
                                %in%	Find out if an element belongs to a vector	x %in% y
                                %*%	    Matrix Multiplication	                    x <- Matrix1 %*% Matrix2



*****LOOPS********

1. IF....ELSE...
    if (b > a) {
    print("b is greater than a")
    } else if (a == b) {
    print("a and b are equal")
    } else {
    print("a is greater than b")
    }

2. WHILE...
    i <- 1
    while (i < 6) {
    print(i)
    i <- i + 1
    }

    With the break statement, we can stop the loop even if the while condition is TRUE:
    With the next statement, we can skip an iteration without terminating the loop:(JUST LIKE "pass" KEYWORD IN PYTHON)

3. FOR LOOP.....
    for (x in 1:10) {  print(x) }   OR   for (x in fruits) {  print(x) }# FRUITS IS LIST

#######################################
CREATE A FUNCTION
    my_function <- function("pass arguments here") {#DEFINE FUNCTION WITH function() keyword
        print("Hello World!")
        return("something you want to return")
        }

    my_function() # call the function named my_function

    my_function <- function(country = "Norway") {# default parameter value
        paste("I am from", country)
        }
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ R DATA STRUCTURES $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

1. Vectors
    A vector is simply a list of items that are of the same type.
    To combine the list of items to a vector, use the c() function and separate the items by a comma.
    function c(), which stands for concatenate, is useful for creating vectors.
    To find out how many items a vector has, use the length() function:
    To sort items in a vector alphabetically or numerically, use the sort() function:
    You can access the vector items by referring to its index number inside brackets []. 
        The first item has index 1, the second item has index 2, and so on:
    You can also access multiple elements by referring to different index positions with the c() function:
        EX. fruits[c(1, 3)]
    # Access all items except for the first item
        fruits[c(-1)]
    # Vector of strings
        fruits <- c("banana", "apple", "orange")
    # Vector with numerical values in a sequence
        numbers <- 1:10
    To repeat vectors, use the rep() function:
        repeat_each <- rep(c(1,2,3), each = 3) # O/P : 111222333
        repeat_times <- rep(c(1,2,3), times = 3) #O/P : 123123123
        repeat_indepent <- rep(c(1,2,3), times = c(5,2,1)) #O/P: 11111223
    The seq() function has three parameters: from is where the sequence starts, 
        to is where the sequence stops, and by is the interval of the sequence.
        EX. numbers <- seq(from = 0, to = 100, by = 20)
2. Lists
    A list in R can contain many different data types inside it. A list is a collection of data which is ordered and changeable.
    To create a list, use the list() function:
        thislist <- list("apple", "banana", "cherry")
    You can access the list items by referring to its index number, inside brackets. The first item has index 1, the second item has index 2, and so on:
    To find out how many items a list has, use the length() function:
    To find out if a specified item is present in a list, use the %in% operator: EX. "apple" %in% thislist
    To add an item to the end of the list, use the append() function: EX. append(thislist, "orange")
    To add an item to the right of a specified index, add "after=index number" in the append() function: EX: append(thislist, "orange", after = 2)
    
    list3 <- c(list1,list2)#JOIN TWO LIST TOGETHER

3. Matrices
    A matrix is a two dimensional data set with columns and rows.
    NOTE : Matrix in R filled column wise. 
    A column is a vertical representation of data, while a row is a horizontal representation of data.
    A matrix can be created with the matrix() function. Specify the nrow and ncol parameters to get the amount of rows and columns:
    
    EX : thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)
    O/P :      [,1]     [,2]    
        [1,] "apple"  "cherry"
        [2,] "banana" "orange"
    
    You can access the items by using [ ] brackets. The first number "1" in the bracket specifies the row-position, while the second number "2" specifies the column-position:
    
    thismatrix[2,]# FOR ACCESING WHOLE ROW
    thismatrix[,2]# FOR ACCESING WHOLE COLUMN
    thismatrix[c(1,2),] #ACCESING MORE THAN ONE ROW
    thismatrix[, c(1,2)]#ACCESING MORE THAN ONE COLUMN

    Use the cbind() function to add additional columns in a Matrix:
        newmatrix <- cbind(thismatrix, c("strawberry", "blueberry", "raspberry"))
    Use the rbind() function to add additional rows in a Matrix:
        newmatrix <- rbind(thismatrix, c("strawberry", "blueberry", "raspberry"))
    note : The cells in the new row/column must be of the same length as the existing matrix.

    Use the c() function to remove rows and columns in a Matrix:
        #Remove the first row and the first column
            thismatrix <- thismatrix[-c(1), -c(1)]
    To find out if a specified item is present in a matrix, use the %in% operator: ex: "apple" %in% thismatrix
    Use the dim() function to find the amount of rows and columns in a Matrix: ex: dim(thismatrix)
    Use the length() function to find the dimension of a Matrix:

    Again, you can use the rbind() or cbind() function to combine two or more matrices together:
        # Adding it as a rows
            Matrix_Combined <- rbind(Matrix1, Matrix2)
        # Adding it as a columns
            Matrix_Combined <- cbind(Matrix1, Matrix2)

4.Arrays
    Compared to matrices, arrays can have more than two dimensions.
    We can use the array() function to create an array, and the dim parameter to specify the dimensions:
    
    ex.: multiarray <- array(thisarray, dim = c(4, 3, 2))
        In the example above we create an array with the values 1 to 24.
        How does dim=c(4,3,2) work?
        The first and second number in the bracket specifies the amount of rows and columns.
        The last number in the bracket specifies how many dimensions we want.

    multiarray[2, 3, 2]#access the element from array: array[row position, column position, matrix level
    To find out if a specified item is present in an array, use the %in% operator:
    Use the dim() function to find the amount of rows and columns in an array:
    Use the length() function to find the dimension of an array:

5.Data Frames
    Data Frames are data displayed in a format as a table.
    Data Frames can have different types of data inside it. While the first column can be character, the second and third 
        can be numeric or logical. However, each column should have the same type of data.
    Use the data.frame() function to create a data frame:
        # Create a data frame
        Data_Frame <- data.frame (
        Training = c("Strength", "Stamina", "Other"),
        Pulse = c(100, 150, 120),
        Duration = c(60, 30, 45)
        )
    Use the summary() function to summarize the data from a Data Frame:
        #find out statistical information of each data column(only numeric data types column)
    We can use single brackets [ ], double brackets [[ ]] or $ to access columns from a data frame:
        Data_Frame[1]
        Data_Frame[["Training"]]
        Data_Frame$Training
    Use the rbind() function to add new rows in a Data Frame:
        ex: New_row_DF <- rbind(Data_Frame, c("Strength", 110, 110))
    Use the cbind() function to add new columns in a Data Frame:
        ex: New_col_DF <- cbind(Data_Frame, Steps = c(1000, 6000, 2000))
    # Remove the first row and column
        Data_Frame_New <- Data_Frame[-c(1), -c(1)]
    Use the dim() function to find the amount of rows and columns in a Data Frame:
    You can also use the ncol() function to find the number of columns and nrow() to find the number of rows:
    Use the length() function to find the number of columns in a Data Frame (similar to ncol()):
    Use the rbind() function to combine two or more data frames in R vertically:
        New_Data_Frame <- rbind(Data_Frame1, Data_Frame2)
    And use the cbind() function to combine two or more data frames in R horizontally:

6. Factors
    Factors are used to categorize data. Examples of factors are:
        Demography: Male/Female
        Music: Rock, Pop, Classic, Jazz
        Training: Strength, Stamina
    To create a factor, use the factor() function and add a vector as argument:ex: 
        ex: music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))
    To only print the levels, use the levels() function:
        levels(music_genre) # unique values in factor
    Use the length() function to find out how many items there are in the factor:
    To access the items in a factor, refer to the index number, using [] brackets:
    To change the value of a specific item, refer to the index number:

$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ R Graphics $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

1.Plot
    The plot() function is used to draw points (markers) in a diagram.
    The function takes parameters for specifying points in the diagram.
    Parameter 1 specifies points on the x-axis.
    Parameter 2 specifies points on the y-axis.
    At its simplest, you can use the plot() function to plot two numbers against each other:
        x <- c(1, 2, 3, 4, 5)
        y <- c(3, 7, 8, 9, 12)
        plot(x, y)
        plot(1:10)#plot sequence of ppoints
    The plot() function also takes a type parameter with the value l to draw a line to connect all the points in the diagram:
        plot(1:10, type="l")
    The plot() function also accept other parameters, such as main, xlab and ylab if you want to customize the graph with a main title and different labels for the x and y-axis:
        plot(1:10, main="My Graph", xlab="The x-axis", ylab="The y axis")
    Use col="color" to add a color to the points: ex: plot(1:10, col="red")
    Use cex=number to change the size of the points (1 is default, while 0.5 means 50% smaller, and 2 means 100% larger):
        plot(1:10, cex=2)
    Use pch with a value from 0 to 25 to change the point shape format:
        plot(1:10, pch=25, cex=2) # note : pch may range from 1 to 25

2. Line Graphs
    A line graph has a line that connects all the points in a diagram.
    To create a line, use the plot() function and add the type parameter with a value of "l":
        plot(1:10, type="l")
        plot(1:10, type="l", col="blue")
    To change the width of the line, use the "lwd" parameter (1 is default, while 0.5 means 50% smaller, and 2 means 100% larger):
        plot(1:10, type="l", lwd=2)
    The line is solid by default. Use the "lty" parameter with a value from 0 to 6 to specify the line format.
        plot(1:10, type="l", lwd=5, lty=3)
            0 removes the line
            1 displays a solid line
            2 displays a dashed line
            3 displays a dotted line
            4 displays a "dot dashed" line
            5 displays a "long dashed" line
            6 displays a "two dashed" line
    To display more than one line in a graph, use the plot() function together with the lines() function:
        line1 <- c(1,2,3,4,5,10)
        line2 <- c(2,5,7,8,9,10)
        plot(line1, type = "l", col = "blue")
        lines(line2, type="l", col = "red")

3.Scatter Plots
    A "scatter plot" is a type of plot used to display the relationship between two numerical variables, and plots one dot for each observation.
    It needs two vectors of same length, one for the x-axis (horizontal) and one for the y-axis (vertical):
        x <- c(5,7,8,7,2,2,9,4,11,12,9,6)
        y <- c(99,86,87,88,111,103,87,94,78,77,85,86)
        plot(x, y, main="Observation of Cars", xlab="Car age", ylab="Car speed")

    To compare the plot with another plot, use the points() function:
        plot(x1, y1, main="Observation of Cars", xlab="Car age", ylab="Car speed", col="red", cex=2)
        points(x2, y2, col="blue", cex=2)

4. pie chart 
    # Create a vector of labels
    mylabel <- c("Apples", "Bananas", "Cherries", "Dates")

    # Create a vector of colors
    colors <- c("blue", "yellow", "green", "black")

    # Display the pie chart with colors
    pie(x, label = mylabel, main = "Pie Chart", col = colors)

    # Display the explanation box
    legend("bottomright", mylabel, fill = colors)
    The legend can be positioned as either:bottomright, bottom, bottomleft, left, topleft, top, topright, right, center

5.Bar Charts
    A bar chart uses rectangular bars to visualize data. Bar charts can be displayed horizontally or vertically. The height or length of the bars are proportional to the values they represent.
    Use the barplot() function to draw a vertical bar chart:
        x <- c("A", "B", "C", "D")
        # y-axis values
        y <- c(2, 4, 6, 8)
        barplot(y, names.arg = x)#names.arg defines the names of each observation in the x-axis
    To change the bar texture, use the "density" parameter:
        barplot(y, names.arg = x, density = 10)
    Use the width parameter to change the width of the bars:
        barplot(y, names.arg = x, width = c(1,2,3,4))
    If you want the bars to be displayed horizontally instead of vertically, use horiz=TRUE:

$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ R STATISTIC $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

Statistics is the science of analyzing, reviewing and conclude data.
Some basic statistical numbers include:
    Mean, median and mode
    Minimum and maximum value
    Percentiles
    Variance and Standard Devation
    Covariance and Correlation
    Probability distributions
The R language was developed by two statisticians. It has many built-in functionalities, in addition to libraries for the exact 
purpose of statistical analysis.

1. Data Set
    A data set is a collection of data, often presented in a table.
    There is a popular built-in data set in R called "mtcars" (Motor Trend Car Road Tests), which is retrieved from the 1974 Motor Trend US Magazine.
    In the examples below (and for the next chapters), we will use the mtcars data set, for statistical purposes:
    
    # Use the question mark to get information about the data set
        ?mtcars
    Use the dim() function to find the dimensions of the data set, and the names() function to view the names of the variables:
    Use the rownames() function to get the name of each row in the first column, which is the name of each car:
    If you want to print all values that belong to a variable, access the data frame by using the $ sign, and the name of the variable (for example cyl (cylinders)):
    To sort the values, use the sort() function:
        Data_Cars <- mtcars
        sort(Data_Cars$cyl)
    we can use the summary() function to get a statistical summary of the data:
    we can use the which.max() and which.min() functions to find the index position of the max and min value in the table:
        Max and min can also be used to detect outliers. An outlier is a data point that differs from rest of the observations.

In statistics, there are often three values that interests us:
    Mean - The average value
    Median - The median value is the value in the middle, after you have sorted all the values.
    Mode - The most common value(R does not have a function to calculate the mode. However, we can create our own function to find it.)

ex: Data_Cars <- mtcars
    mean(Data_Cars$wt)
    median(Data_Cars$wt)
Percentiles are used in statistics to give you a number that describes the value that a given percent of the values are lower than.
    quantile(Data_Cars$wt, c(0.75))# 75th percentile
    quantile(Data_Cars$wt)# all the percentile
    

