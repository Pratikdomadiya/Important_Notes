########################  DATA VISUALIZATION (edx course)####################################
#################################################################################

# The most basic statistical summary of a list of objects is its distribution.
# We will learn ways to visualize and analyze distributions in the upcoming videos.
# In some cases, data can be summarized by a two-number summary: the average and standard deviation.
# We will learn to use data visualization to determine when that is appropriate.

# Categorical data are variables that are defined by a small number of groups.
  # Ordinal categorical data have an inherent order to the categories (mild/medium/hot, for example).
  # Non-ordinal categorical data have no order to the categories.
# Numerical data take a variety of numeric values.
  # Continuous variables can take any value.
  # Discrete variables are limited to sets of specific values.

# A distribution is a function or description that shows the possible values of a variable and 
  # how often those values occur.
# For categorical variables, the distribution describes the proportions of each category.
# A frequency table is the simplest way to show a categorical distribution. Use prop.table() 
  # to convert a table of counts to a frequency table. Barplots display the distribution of 
  # categorical variables and are a way to visualize the information in frequency tables.
# For continuous numerical data, reporting the frequency of each unique entry is not an effective summary as many or most values are unique. Instead, a distribution function is required.
# The cumulative distribution function (CDF) is a function that reports the proportion of data below a value  a  for all values of  a :  F(a)=Pr(x???a) .
# The proportion of observations between any two values  a  and  b  can be computed from the CDF as  F(b)???F(a) .
# A histogram divides data into non-overlapping bins of the same size and plots the counts of number of values that fall in that interval.

# make a table of category proportions
prop.table(table(heights$sex))

# The CDF is essential for calculating probabilities related to continuous data. In a continuous dataset,
# the probability of a specific exact value is not informative because most entries are unique. For example, 
# in the student heights data, only one individual reported a height of 68.8976377952726 inches, but many 
# students rounded similar heights to 69 inches. If we computed exact value probabilities, we would find
# that being exactly 69 inches is much more likely than being a non-integer exact height, which does 
# not match our understanding that height is continuous. We can instead use the CDF to obtain a useful
# summary, such as the probability that a student is between 68.5 and 69.5 inches. 
# 
# For datasets that are not normal, the CDF can be calculated manually by defining a function to compute
# the probability above. This function can then be applied to a range of values across the range of the 
# dataset to calculate a CDF. Given a dataset my_data, the CDF can be calculated and plotted like this:
a <- seq(min(my_data), max(my_data), length = 100)    # define range of values spanning the dataset
cdf_function <- function(x) {    # computes prob. for a single value
  mean(my_data <= x)
}
cdf_values <- sapply(a, cdf_function)
plot(a, cdf_values)

# histograms are much more useful for analysis of the data
# Smooth density plots can be thought of as histograms where the bin width is extremely or infinitely small. 
  #The smoothing function makes estimates of the true continuous trend of the data given the available sample of data points.
# The degree of smoothness can be controlled by an argument in the plotting function. (We will learn functions
  #for plotting later.)
# While the histogram is an assumption-free summary, the smooth density plot is shaped by assumptions and 
  #choices you make as a data analyst.
# The y-axis is scaled so that the area under the density curve sums to 1. This means that interpreting 
` #values on the y-axis is not straightforward. To determine the proportion of data in between two values, 
``#compute the area under the smooth density curve in the region between those values.
# An advantage of smooth densities over histograms is that densities are easier to compare visually.

# A further note on histograms
  # Note that the choice of binwidth has a determinative effect on shape. There is no "correct" choice for 
  #binwidth, and you can sometimes gain insights into the data by experimenting with binwidths.

# define x as vector of male heights
library(tidyverse)
library(dslabs)
data(heights)
index <- heights$sex=="Male"
x <- heights$height[index]

# calculate the mean and standard deviation manually
average <- sum(x)/length(x)
SD <- sqrt(sum((x - average)^2)/length(x))

# built-in mean and sd functions - note that the audio and printed values disagree
average <- mean(x)
SD <- sd(x)
c(average = average, SD = SD)

# calculate standard units
z <- scale(x)

# calculate proportion of values within 2 SD of mean
mean(abs(z) < 2)
# Standard units describe how many standard deviations a value is away from the mean. The z-score, or number of standard deviations an observation  x  is away from the mean  ?? :
# Compute standard units with the scale() function.
# Important: to calculate the proportion of values that meet a certain condition, use the mean() function on a logical vector. Because TRUE is converted to 1 and FALSE is converted to 0, taking the mean of this vector yields the proportion of TRUE.
#The normal distribution is associated with the 68-95-99.7 rule. This rule describes the probability of observing events within a certain number of standard deviations of the mean. 

# We can estimate the probability that a male is taller than 70.5 inches with:
x <- heights$height[index]
1 - pnorm(70.5, mean(x), sd(x))

#Definition of quantiles
#Quantiles are cutoff points that divide a dataset into intervals with set probabilities. The  q th quantile is the value at which  q % of the observations are equal to or less than that value.
quantile(data,q)#given a dataset data and desired quantile q, you can find the qth quantile of data with
#The summary() function returns the minimum, quartiles and maximum of a vector.

# Definition of qnorm
# The qnorm() function gives the theoretical value of a quantile with probability p of observing a value equal to or less than that quantile value 
  # given a normal distribution with mean mu and standard deviation sigma:
qnorm(p, mu, sigma)
# By default, mu=0 and sigma=1. Therefore, calling qnorm() with no arguments gives quantiles for the standard normal distribution.
#qnorm() and pnorm() are inverse functions:

# Quantile-quantile plots, or QQ-plots, are used to check whether distributions are well-approximated by a normal distribution.
# Given a proportion  p , the quantile  q  is the value such that the proportion of values in the data below  q  is  p .
# In a QQ-plot, the sample quantiles in the observed data are compared to the theoretical quantiles expected from the normal distribution. If the
  # data are well-approximated by the normal distribution, then the points on the QQ-plot will fall near the identity line (sample = theoretical).
# Calculate sample quantiles (observed quantiles) using the quantile() function.
# Calculate theoretical quantiles with the qnorm() function. qnorm() will calculate quantiles for the standard normal distribution ( ??=0,??=1 ) by 
  # default, but it can calculate quantiles for any normal distribution given mean() and sd() arguments.
# define x and z
library(tidyverse)
library(dslabs)
data(heights)
index <- heights$sex=="Male"
x <- heights$height[index]
z <- scale(x)

# proportion of data below 69.5
mean(x <= 69.5)

# calculate observed and theoretical quantiles
p <- seq(0.05, 0.95, 0.05)
observed_quantiles <- quantile(x, p)
theoretical_quantiles <- qnorm(p, mean = mean(x), sd = sd(x))

# make QQ-plot
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)

# make QQ-plot with scaled values
observed_quantiles <- quantile(z, p)
theoretical_quantiles <- qnorm(p)
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)

# When data do not follow a normal distribution and cannot be succinctly summarized by only the mean and standard deviation, an alternative is to report a five-number summary: range (ignoring outliers) and the quartiles (25th, 50th, 75th percentile).
# In a boxplot, the box is defined by the 25th and 75th percentiles and the median is a horizontal line through the box. The whiskers show the range excluding outliers, and outliers are plotted separately as individual points.
#Boxplots are particularly useful when comparing multiple distributions.

# If a distribution is not normal, it cannot be summarized with only the mean and standard deviation. Provide a histogram, smooth density or boxplot instead.
# A plot can force us to see unexpected results that make us question the quality or implications of our data.

#################################### ggplot2 #########################################
######################################################################################

# Plots in ggplot2 consist of 3 main components:
  #  Data: The dataset being summarized
  # Geometry: The type of plot (scatterplot, boxplot, barplot, histogram, qqplot, smooth density, etc.)
  # Aesthetic mapping: Variables mapped to visual cues, such as x-axis and y-axis values and color
# There are additional components:
  # Scale
  # Labels, Title, Legend
  # Theme/Style
library(tidyverse)
library(dslabs)
data(murders)
ggplot(data = murders)

murders %>% ggplot()

p <- ggplot(data = murders)
class(p)
p
# In ggplot2, graphs are created by adding layers to the ggplot object:
#   DATA %>% ggplot() + LAYER_1 + LAYER_2 + ... + LAYER_N
# The geometry layer defines the plot type and takes the format geom_X where X is the plot type.
# # Aesthetic mappings describe how properties of the data connect with features of the graph (axis position, color, size, etc.) Define aesthetic
#   mappings with the aes() function.
# aes() uses variable names from the object component (for example, total rather than murders$total).
# geom_point() creates a scatterplot and requires x and y aesthetic mappings. 
# geom_text() and geom_label() add text to a scatterplot and require x, y, and label aesthetic mappings.
# To determine which aesthetic mappings are required for a geometry, read the help file for that geometry.
# You can add layers with different aesthetic mappings to the same graph.

murders %>% ggplot() + geom_point(aes(x = population/10^6, y = total))

# add points layer to predefined ggplot object
p <- ggplot(data = murders)
p + geom_point(aes(population/10^6, total))

# add text layer to scatterplot
p + geom_point(aes(population/10^6, total)) + geom_text(aes(population/10^6, total, label = abb))
help("murders")

# Global aesthetic mappings apply to all geometries and can be defined when you initially call ggplot(). All the geometries added as layers will default to this mapping. Local aesthetic mappings add additional information or override the default mappings.
# change the size of the points
p + geom_point(aes(population/10^6, total), size = 3) + geom_text(aes(population/10^6, total, label = abb))

# move text labels slightly to the right
p + geom_point(aes(population/10^6, total), size = 3) +
  geom_text(aes(population/10^6, total, label = abb), nudge_x = 1)

# simplify code by adding global aesthetic
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
p + geom_point(size = 3) +
  geom_text(nudge_x = 1.5)

# local aesthetics override global aesthetics
p + geom_point(size = 3) +
  geom_text(aes(x = 10, y = 800, label = "Hello there!"))

# Convert the x-axis to log scale with scale_x_continuous(trans = "log10") or scale_x_log10(). Similar functions exist for the y-axis.
# Add axis titles with xlab() and ylab() functions. Add a plot title with the ggtitle() function.
# Add a color mapping that colors points by a variable by defining the col argument within aes(). To color all points the same way, define col outside of aes().
# Add a line with the geom_abline() geometry. geom_abline() takes arguments slope (default = 1) and intercept (default = 0). Change the color with col or color and line type with lty.
# Placing the line layer after the point layer will overlay the line on top of the points. To overlay points on the line, place the line layer before the point layer.
# There are many additional ways to tweak your graph that can be found in the ggplot2 documentation, cheat sheet, or on the internet. For example, you can change the legend title with scale_color_discrete().
data(murders)
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))

# log base 10 scale the x-axis and y-axis
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.05) +
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10")

# efficient log scaling of the axes
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.075) +
  scale_x_log10() +
  scale_y_log10()
#Code: Add labels and title
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.075) +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")
# redefine p to be everything except the points layer
p <- murders %>%
  ggplot(aes(population/10^6, total, label = abb)) +
  geom_text(nudge_x = 0.075) +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")

# make all points blue
p + geom_point(size = 3, color = "blue")

# color points by region
p + geom_point(aes(col = region), size = 3)
#Code: Add a line with average murder rate
# define average murder rate
r <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^6) %>%
  pull(rate)
r
# basic line with average murder rate for the country
p + geom_point(aes(col = region), size = 3) +
  geom_abline(intercept = log10(r))    # slope is default of 1

# change line to dashed and dark grey, line under points
p + 
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col = region), size = 3)
#Code: Change legend title
p <- p + scale_color_discrete(name = "Region")    # capitalize legend title

# The style of a ggplot graph can be changed using the theme() function.
# The ggthemes package adds additional themes.
# The ggrepel package includes a geometry that repels text labels, ensuring they do not overlap with each other: geom_text_repel().
#Code: Adding themes
# theme used for graphs in the textbook and course
library(dslabs)
ds_theme_set()
# install.packages("ggthemes")
install.packages("ggrepel")
# themes from ggthemes
library(ggthemes)
p + theme_economist()    # style of the Economist magazine
p + theme_fivethirtyeight()    # style of the FiveThirtyEight website
#Code: Putting it all together to assemble the plot
# load libraries
library(tidyverse)
library(ggrepel)
library(ggthemes)
library(dslabs)
data(murders)

# define the intercept
r <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^6) %>%
  .$rate

# make the plot, combining all elements
murders %>%
  ggplot(aes(population/10^6, total, label = abb)) +
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col = region), size = 3) +
  geom_text_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010") +
  scale_color_discrete(name = "Region") +
  theme_economist()


# geom_histogram() creates a histogram. Use the binwidth argument to change the width of bins, the fill argument to change the bar fill color, and the col argument to change bar outline color.
# geom_density() creates smooth density plots. Change the fill color of the plot with the fill argument.
# geom_qq() creates a quantile-quantile plot. This geometry requires the sample argument. By default, the data are compared to a standard normal distribution with a mean of 0 and standard deviation of 1. This can be changed with the dparams argument, or the sample data can be scaled.
# Plots can be arranged adjacent to each other using the grid.arrange() function from the gridExtra package. First, create the plots and save them to objects (p1, p2, ...). Then pass the plot objects to grid.arrange().
#Code: Histograms in ggplot2
# load heights data
library(tidyverse)
library(dslabs)
data(heights)

# define p
p <- heights %>%
  filter(sex == "Male") %>%
  ggplot(aes(x = height))

# basic histograms
p + geom_histogram()
p + geom_histogram(binwidth = 1)

# histogram with blue fill, black outline, labels and title
p + geom_histogram(binwidth = 1, fill = "blue", col = "black") +
  xlab("Male heights in inches") +
  ggtitle("Histogram")
#Code: Smooth density plots in ggplot2
p + geom_density()
p + geom_density(fill = "blue")
# Code: Quantile-quantile plots in ggplot2
# basic QQ-plot
p <- heights %>% filter(sex == "Male") %>%
  ggplot(aes(sample = height))
p + geom_qq()

# QQ-plot against a normal distribution with same mean/sd as data
params <- heights %>%
  filter(sex == "Male") %>%
  summarize(mean = mean(height), sd = sd(height))
p + geom_qq(dparams = params) +
  geom_abline()

# QQ-plot of scaled data against the standard normal distribution
heights %>%
  ggplot(aes(sample = scale(height))) +
  geom_qq() +
  geom_abline()
#Code: Grids of plots with the gridExtra package
# define plots p1, p2, p3
p <- heights %>% filter(sex == "Male") %>% ggplot(aes(x = height))
p1 <- p + geom_histogram(binwidth = 1, fill = "blue", col = "black")
p2 <- p + geom_histogram(binwidth = 2, fill = "blue", col = "black")
p3 <- p + geom_histogram(binwidth = 3, fill = "blue", col = "black")

# arrange plots next to each other in 1 row, 3 columns
library(gridExtra)
grid.arrange(p1, p2, p3, ncol = 3)
