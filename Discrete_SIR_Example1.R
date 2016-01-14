# ___________
#  1. Setup statements, if needed (e.g. loading libraries needed for the program). 
# ___________
# Clear your R memory. I do this at the beginning of most scripts. It throws out all the data and variables 
# in your memory so that you never accidentally use or plot values from previous analyses.
rm(list = ls())
#Set your working directory
# Make sure you use quotes
# The "~/..." shortcut lets you skip writing out your root directory, where for me, the root directory would be /Users/kgostic
setwd('~/Dropbox/R')
#Check that you set your working directory correctly
getwd()
#Load required packages. In this example we don't need any packages.



# ___________
# 2. Input data, set parameter values, and/or set initial conditions.
# ___________

## Initialize a matrix in which to store your outputs.
#I like to store each state variable on a different row and each each timestep
#on a different column. Before you run the analysis, all the entries in
#your matrix sould have value 0 (or, I like to use NA)

## Set number of timesteps
nsteps = 500


#   Here, we have one state variable, so we use one row
#   The number of columns is equal to the number of steps + 1, since we specify
#the initial conditions at time 0 (so the outputs for time 1 will be stored in
#the second column, and so on)
#NN <- matrix(NA, nrow = 1, ncol = nsteps+1)

SS <- matrix(NA, nrow = 1, ncol = nsteps+1)
II <- matrix(NA, nrow = 1, ncol = nsteps+1)
RR <- matrix(NA, nrow = 1, ncol = nsteps+1)
#For SIR change to 3, creates a matrix of 1 column x 3 rows
#1 row for each state variable (S, I, R) and each column represents their values
#at a specific time step

## Set initial number of individuals for each state variable
#N0 = 5
S0=98
I0=1
R0=1

#   Store the initial conditions in the first column, appropriate row, of your output matrix
#NN[1, 1] <- N0

SS[1, 1] <- S0
II[1, 1] <- I0
RR[1, 1] <- R0
#1st entry in square brackets is the row, 2nd entry is the column
#eg NN[1, 3] is row 1 column 3    NN[ , 3]  gives all row in column 3


## Set your parameters
#   In this model, our parameters are R and K
#   Note, I use double letters because they are easier to identify using find and replace with CTRL+F or Command+F
#RR = 1
#KK = 100
y=0.0005
B=0.0008



# ___________
#3. The actual calculations.
# ___________

#This for loop will run for 100 timesteps, because the lenght of vector NN is 101
#You could also code, "for(ii in 1:100){". This would be an example of "hard code," when you use specific numbers in your code. "Hard code" is bad coding practice, since it makes it much more difficult to change things later. For example, if you decide to use a different number of time steps, the soft code in this script lets you change just line 24, where you set the value of nsteps. With hard code, you would have to change the value in several places, which leads to bugs and mistakes.
for(ii in 1:(length(SS)-1) ){
  #We run the loop for one step less than the length of NN, since we set the value of NN[1] using the initial population size.
  
  #Put your equation(s) inside the for loop
  #You should have as many equations as state variables
  #(in the logistic growth example, just one equation)
  #NN[ii+1] <- NN[ii]*(1+RR*(1-NN[ii]/KK))
  
  SS[ii + 1] <- SS[ii] - B*SS[ii]*II[ii]
  II[ii + 1] <- II[ii] + B*SS[ii]*II[ii] - y*II[ii]
  RR[ii + 1] <- RR[ii] + y*II[ii]
}


SS
II
RR

# ___________
#4. Display the results by plotting, saving, etc.
# ___________
#Note, 1:length(NN) will just give you a sequence from 1:101.
# This is another example of soft code.


par(mfrow=c(2,2)) #This line splits your plotting window into 2 rows x 2 columns = 4 plots

my_ylimits = c(0, S0+I0+R0) #Set the lower y limit to 0, and the upper to the total populaiton size
#Use this vector to set the "ylim" option in the plotting function

#The first plot shows all three state variables for the first 300 time steps, when the epidemic is changing a lot
plot(x = 1:ncol(SS), y = SS, xlab = "time", ylab = "N", type = "b", col = "green",
     main = "Discrete SIR", ylim = my_ylimits) #The plot function initializes a new plot window and sets the x and y limits
lines(x = 1:ncol(II), y = II, xlab = "time", ylab = "N", type = "b", col = "red", ylim = my_ylimits)
#The lines function overlays new plots onto the active window. Make sure your data fits in the x and y limits set above. You could also use the points() function here.
lines(x = 1:ncol(RR), y = RR, xlab = "time", ylab = "N", type = "b", col = "blue", ylim = my_ylimits)


#Let's call plot again to start a new plot that shows only the S class
plot(x = 1:ncol(SS), y = SS, xlab = "time", ylab = "N", type = "b", col = "green",
     main = "Susceptible", ylim = my_ylimits) 

#...and another new call to plot activates the third plot window for the I class
plot(x = 1:ncol(II), y = II, xlab = "time", ylab = "N", type = "b", col = "red",
     main = "Infected", ylim = my_ylimits) #The plot function initializes a new plot window and sets

#...and finally the fourth plot window will show just the R class
plot(x = 1:ncol(RR), y = RR, xlab = "time", ylab = "N", type = "b", col = "blue",
     main = "Recovered", ylim = my_ylimits) #The plot function initializes a new plot window and sets

