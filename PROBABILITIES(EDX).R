
# The probability of an event is the proportion of times the event occurs when we repeat the experiment independently under the same conditions.
#                     Pr(A)=probability of event A 
#                     
# An event is defined as an outcome that can occur when when something happens by chance.
# We can determine probabilities related to discrete variables (picking a red bead, choosing 48 Democrats and 52 Republicans from 100 likely voters) and continuous variables (height over 6 feet)

# Monte Carlo simulations model the probability of different outcomes by repeating a random process a large enough number of times that the results are similar to what would be observed if the process were repeated forever.
# The sample() function draws random outcomes from a set of options.
# The replicate() function repeats lines of code a set number of times. It is used with sample() and similar functions to run Monte Carlo simulations.

beads <- rep(c("red", "blue"), times = c(2,3))    # create an urn with 2 red, 3 blue
beads    # view beads object
sample(beads, 1)    # sample 1 bead at random
B <- 10000    # number of times to draw 1 bead

events <- replicate(B, sample(beads, 1))    # draw 1 bead, B times WITHOUT REPLACEMENT
tab <- table(events)    # make a table of outcome counts
tab    # view count table
prop.table(tab) 

events <- replicate(B, sample(beads, 1,replace = TRUE),)    # draw 1 bead, B times WITH REPLACEMENT
tab <- table(events)    # make a table of outcome counts
tab    # view count table
prop.table(tab) 

set.seed(1, sample.kind="Rounding")    # will make R 3.6 generate a seed as in R 3.5

#In R, applying the mean() function to a logical vector returns the proportion of elements that are TRUE.
mean(beads == "blue")
mean(beads=='red')

# Conditional probabilities compute the probability that an event occurs given information about dependent events. 
#For example, the probability of drawing a second king given that the first draw is a king is:
#   Pr(Card 2 is a king???Card 1 is a king)=3/51 
# If two events  A  and  B  are independent,  Pr(A???B)=Pr(A) .
# To determine the probability of multiple events occurring, we use the multiplication rule.
# Equations
# The multiplication rule for independent events is:Pr(A and B and C)=Pr(A)×Pr(B)×Pr(C) 
# The multiplication rule for dependent events considers the conditional probability of
# both events occurring:Pr(A and B)=Pr(A)×Pr(B???A) 
# We can expand the multiplication rule for dependent events to more than 2 events:

# paste() joins two strings and inserts a space in between.
# expand.grid() gives the combinations of 2 vectors or lists.
# permutations(n,r) from the gtools package lists the different ways that r items can be selected from a set of n options when order matters.
# combinations(n,r) from the gtools package lists the different ways that r items can be selected from a set of n options when order does not matter.
# Code: Introducing paste() and expand.grid()
# joining strings with paste
number <- "Three"
suit <- "Hearts"
paste(number, suit)

# joining vectors element-wise with paste
paste(letters[1:5], as.character(1:5))

# generating combinations of 2 vectors with expand.grid
expand.grid(pants = c("blue", "black"), shirt = c("white", "grey", "plaid"))

#Code: Generating a deck of cards
suits <- c("Diamonds", "Clubs", "Hearts", "Spades")
numbers <- c("Ace", "Deuce", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King")
deck <- expand.grid(number = numbers, suit = suits)
deck <- paste(deck$number, deck$suit)

# probability of drawing a king
kings <- paste("King", suits)
mean(deck %in% kings)
# Code: Permutations and combinations
# Correction: The code shown does not generate all 7 digit phone numbers because phone numbers can have repeated digits. It generates all possible 7 digit numbers without repeats.

library(gtools)
permutations(5,2)    # ways to choose 2 numbers in order from 1:5
all_phone_numbers <- permutations(10, 7, v = 0:9)
n <- nrow(all_phone_numbers)
index <- sample(n, 5)
all_phone_numbers[index,]

permutations(3,2)    # order matters
combinations(3,2)    # order does not matter
# Code: Probability of drawing a second king given that one king is drawn
hands <- permutations(52,2, v = deck)
first_card <- hands[,1]
second_card <- hands[,2]
sum(first_card %in% kings)

sum(first_card %in% kings & second_card %in% kings) / sum(first_card %in% kings)
# Code: Probability of a natural 21 in blackjack
aces <- paste("Ace", suits)
facecard <- c("King", "Queen", "Jack", "Ten")
facecard <- expand.grid(number = facecard, suit = suits)
facecard <- paste(facecard$number, facecard$suit)

hands <- combinations(52, 2, v=deck) # all possible hands

# probability of a natural 21 given that the ace is listed first in `combinations`
mean(hands[,1] %in% aces & hands[,2] %in% facecard)

# probability of a natural 21 checking for both ace first and ace second
mean((hands[,1] %in% aces & hands[,2] %in% facecard)|(hands[,2] %in% aces & hands[,1] %in% facecard))
# Code: Monte Carlo simulation of natural 21 in blackjack
# Note that your exact values will differ because the process is random and the seed is not set.

# code for one hand of blackjack
hand <- sample(deck, 2)
hand

# code for B=10,000 hands of blackjack
B <- 10000
results <- replicate(B, {
  hand <- sample(deck, 2)
  (hand[1] %in% aces & hand[2] %in% facecard) | (hand[2] %in% aces & hand[1] %in% facecard)
})
mean(results)

# duplicated() takes a vector and returns a vector of the same length with TRUE for any elements that have appeared previously in that vector.
# We can compute the probability of shared birthdays in a group of people by modeling birthdays as random draws from the numbers 1 through 365. We can then use this sampling model of birthdays to run a Monte Carlo simulation to estimate the probability of shared birthdays.
# Code: The birthday problem
# checking for duplicated bdays in one 50 person group
n <- 50
bdays <- sample(1:365, n, replace = TRUE)    # generate n random birthdays
any(duplicated(bdays))    # check if any birthdays are duplicated

# Monte Carlo simulation with B=10000 replicates
B <- 10000
results <- replicate(B, {    # returns vector of B logical values
  bdays <- sample(1:365, n, replace = TRUE)
  any(duplicated(bdays))
})
mean(results)    # calculates proportion of groups with duplicated bdays

# Some functions automatically apply element-wise to vectors, such as sqrt() and *.
# However, other functions do not operate element-wise by default. This includes functions we define ourselves.
# The function sapply(x, f) allows any other function f to be applied element-wise to the vector x.
# 
# The probability of an event happening is 1 minus the probability of that event not happening:
#   
#   Pr(event)=1???Pr(no event)
# Code: Function for birthday problem Monte Carlo simulations
# Note that the function body of compute_prob() is the code that we wrote in the previous video. If we write this code as a function, we can use sapply() to apply this function to several values of n.

# function to calculate probability of shared bdays across n people
compute_prob <- function(n, B = 10000) {
  same_day <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}

n <- seq(1, 60)
# Code: Element-wise operation over vectors and sapply
x <- 1:10
sqrt(x)    # sqrt operates on each element of the vector

y <- 1:10
x*y    # * operates element-wise on both vectors

compute_prob(n)    # does not iterate over the vector n without sapply

x <- 1:10
sapply(x, sqrt)    # this is equivalent to sqrt(x)

prob <- sapply(n, compute_prob)    # element-wise application of compute_prob to n
plot(n, prob)
# Code: Computing birthday problem probabilities with sapply
# function for computing exact probability of shared birthdays for any n
exact_prob <- function(n){
  prob_unique <- seq(365, 365-n+1)/365   # vector of fractions for mult. rule
  1 - prod(prob_unique)    # calculate prob of no shared birthdays and subtract from 1
}

# applying function element-wise to vector of n values
eprob <- sapply(n, exact_prob)

# plotting Monte Carlo results and exact probabilities on same graph
plot(n, prob)    # plot Monte Carlo results
lines(n, eprob, col = "red")    # add line for exact prob

#How Many Monte Carlo Experiments are Enough?
  # The larger the number of Monte Carlo replicates  B , the more accurate the estimate.
  # Determining the appropriate size for  B  can require advanced statistics.
  # One practical approach is to try many sizes for  B  and look for sizes that provide stable estimates.
# Code: Estimating a practical value of B
# This code runs Monte Carlo simulations to estimate the probability of shared birthdays using several B values and plots the results. When B is large enough that the estimated probability stays stable, then we have selected a useful value of B.

B <- 10^seq(1, 5, len = 100)    # defines vector of many B values
compute_prob <- function(B, n = 22){    # function to run Monte Carlo simulation with each B
  same_day <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}
prob <- sapply(B, compute_prob)    # apply compute_prob to many values of B
plot(log10(B), prob, type = "l")    # plot a line graph of estimates 

# The addition rule states that the probability of event  A  or event  B  happening is the probability of event  A  plus the probability of event  B  minus the probability of both events  A  and  B  happening together.
#                 Pr(A or B)=Pr(A)+Pr(B)???Pr(A and B) 
# Note that  (A or B)  is equivalent to  (A|B) .

# Monte Carlo simulations can be used to simulate random outcomes, which makes them useful when exploring ambiguous or less intuitive problems like the Monty Hall problem.
# In the Monty Hall problem, contestants choose one of three doors that may contain a prize. Then, one of the doors that was not chosen by the contestant and does not contain a prize is revealed. The contestant can then choose whether to stick with the original choice or switch to the remaining unopened door.
# Although it may seem intuitively like the contestant has a 1 in 2 chance of winning regardless of whether they stick or switch, Monte Carlo simulations demonstrate that the actual probability of winning is 1 in 3 with the stick strategy and 2 in 3 with the switch strategy.

#Code: Monte Carlo simulation of stick strategy
B <- 10000
stick <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))    # puts prizes in random order
  prize_door <- doors[prize == "car"]    # note which door has prize
  my_pick  <- sample(doors, 1)    # note which door is chosen
  show <- sample(doors[!doors %in% c(my_pick, prize_door)],1)    # open door with no prize that isn't chosen
  stick <- my_pick    # stick with original door
  stick == prize_door    # test whether the original door has the prize
})
mean(stick)    # probability of choosing prize door when sticking

# Code: Monte Carlo simulation of switch strategy
switch <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))    # puts prizes in random order
  prize_door <- doors[prize == "car"]    # note which door has prize
  my_pick  <- sample(doors, 1)    # note which door is chosen first
  show <- sample(doors[!doors %in% c(my_pick, prize_door)], 1)    # open door with no prize that isn't chosen
  switch <- doors[!doors%in%c(my_pick, show)]    # switch to the door that wasn't chosen first or opened
  switch == prize_door    # test whether the switched door has the prize
})
mean(switch)    # probability of choosing prize door when switching

# The cumulative distribution function (CDF) is a distribution function for continuous data  x  that reports the proportion of the data below  a  for all values of  a :
#   F(a)=Pr(x???a) 
# The CDF is the probability distribution function for continuous variables. For example, to determine the probability that a male student is taller than 70.5 inches given a vector of male heights  x , we can use the CDF:
#   Pr(x>70.5)=1???Pr(x???70.5)=1???F(70.5) 
# The probability that an observation is in between two values  a,b  is  F(b)???F(a) .

# Code: Cumulative distribution function
# Define x as male heights from the dslabs heights dataset:
library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull

# Given a vector x, we can define a function for computing the CDF of x using:
F <- function(a) mean(x <= a)
1 - F(70)    # probability of male taller than 70 inches

# pnorm(a, avg, s) gives the value of the cumulative distribution function  F(a)  for the normal distribution defined by average avg and standard deviation s.
# We say that a random quantity is normally distributed with average avg and standard deviation s if the approximation pnorm(a, avg, s) holds for all values of a.
# If we are willing to use the normal approximation for height, we can estimate the distribution simply from the mean and standard deviation of our values.
# If we treat the height data as discrete rather than categorical, we see that the data are not very useful because integer values are more common than expected due to rounding. This is called discretization.
# With rounded data, the normal approximation is particularly useful when computing probabilities of intervals of length 1 that include exactly one integer.
# Code: Using pnorm() to calculate probabilities
# Given male heights x:
  
library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)
# We can estimate the probability that a male is taller than 70.5 inches using:
  
  1 - pnorm(70.5, mean(x), sd(x))
# Code: Discretization and the normal approximation
# plot distribution of exact heights in data
plot(prop.table(table(x)), xlab = "a = Height in inches", ylab = "Pr(x = a)")

# probabilities in actual data over length 1 ranges containing an integer
mean(x <= 68.5) - mean(x <= 67.5)
mean(x <= 69.5) - mean(x <= 68.5)
mean(x <= 70.5) - mean(x <= 69.5)

# probabilities in normal approximation match well
pnorm(68.5, mean(x), sd(x)) - pnorm(67.5, mean(x), sd(x))
pnorm(69.5, mean(x), sd(x)) - pnorm(68.5, mean(x), sd(x))
pnorm(70.5, mean(x), sd(x)) - pnorm(69.5, mean(x), sd(x))

# probabilities in actual data over other ranges don't match normal approx as well
mean(x <= 70.9) - mean(x <= 70.1)
pnorm(70.9, mean(x), sd(x)) - pnorm(70.1, mean(x), sd(x))

# The probability of a single value is not defined for a continuous distribution.
# The quantity with the most similar interpretation to the probability of a single value is the probability density function  f(x) .
# The probability density  f(x)  is defined such that the integral of  f(x)  over a range gives the CDF of that range.
# F(a)=Pr(X???a)=???a??????f(x)dx 
# In R, the probability density function for the normal distribution is given by dnorm(). We will see uses of dnorm() in the future.
# Note that dnorm() gives the density function and pnorm() gives the distribution function, which is the integral of the density function.
# We can use dnorm() to plot the density curve for the normal distribution. dnorm(z) gives the probability density  f(z)  of a certain z-score, so we can draw a curve by calculating the density over a range of possible values of z.
library(tidyverse)
x <- seq(-4, 4, length = 100)
data.frame(x, f = dnorm(x)) %>%
  ggplot(aes(x, f)) +
  geom_line()
# Note that dnorm() gives densities for the standard normal distribution by default. Probabilities for alternative normal distributions with mean mu and standard deviation sigma can be evaluated with:
dnorm(z, mu, sigma)

# rnorm(n, avg, s) generates n random numbers from the normal distribution with average avg and standard deviation s.
# By generating random numbers from the normal distribution, we can simulate height data with similar properties to our dataset. Here we generate simulated height data using the normal distribution.
# Code: Generating normally distributed random numbers
# define x as male heights from dslabs data
library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)

# generate simulated height data using normal distribution - both datasets should have n observations
n <- length(x)
avg <- mean(x)
s <- sd(x)
simulated_heights <- rnorm(n, avg, s)

# plot distribution of simulated_heights
data.frame(simulated_heights = simulated_heights) %>%
  ggplot(aes(simulated_heights)) +
  geom_histogram(color="black", binwidth = 2)
# Code: Monte Carlo simulation of tallest person over 7 feet
B <- 10000
tallest <- replicate(B, {
  simulated_data <- rnorm(800, avg, s)    # generate 800 normally distributed random heights
  max(simulated_data)    # determine the tallest height
})
mean(tallest >= 7*12)    # proportion of times that tallest person exceeded 7 feet (84 inches)


#Other Continuous Distributions
# You may encounter other continuous distributions (Student t, chi-squared, exponential, gamma, beta, etc.).
# R provides functions for density (d), quantile (q), probability distribution (p) and random number generation (r) for many of these distributions.
# Each distribution has a matching abbreviation (for example, norm() or t()) that is paired with the related function abbreviations (d, p, q, r) to create appropriate functions.
# For example, use rt() to generate random numbers for a Monte Carlo simulation using the Student t distribution.
# Code: Plotting the normal distribution with dnorm
# Use d to plot the density function of a continuous distribution. Here is the density function for the normal distribution (abbreviation norm()):
  
x <- seq(-4, 4, length.out = 100)
data.frame(x, f = dnorm(x)) %>%
  ggplot(aes(x,f)) +
  geom_line()
