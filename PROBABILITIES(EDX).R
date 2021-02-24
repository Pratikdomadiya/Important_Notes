
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
