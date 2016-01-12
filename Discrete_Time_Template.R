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

#Remember you can get help with any function by typing "?FUNCTION_NAME". E.g., "?ls" or "?mean"



# ___________
# 2. Input data, set parameter values, and/or set initial conditions.
# ___________

## Set number of timesteps
nsteps = 100

## Initialize a matrix in which to store your outputs. I like to store each state variable on a different row and each each timestep on a different column. Before you run the analysis, all the entries in your matrix sould have value 0 (or, I like to use NA)

#   Here, we have one state variable, so we use one row
#   The number of columns is equal to the number of steps + 1, since we specify the initial conditions at time 0 (so the outputs for time 1 will be stored in the second column, and so on)
NN <- matrix(NA, nrow = 1, ncol = nsteps+1)

## Set initial number of individuals for each state variable
N0 = 5
#   Store the initial conditions in the first column, appropriate row, of your output matrix
NN[1, 1] <- N0




## Set your parameters
#   In this model, our parameters are R and K
#   Note, I use double letters because they are easier to identify using find and replace with CTRL+F or Command+F
RR = 1
KK = 100




# ___________
#3. The actual calculations.
# ___________

#This for loop will run for 100 timesteps, because the lenght of vector NN is 101
#You could also code, "for(ii in 1:100){". This would be an example of "hard code," when you use specific numbers in your code. "Hard code" is bad coding practice, since it makes it much more difficult to change things later. For example, if you decide to use a different number of time steps, the soft code in this script lets you change just line 24, where you set the value of nsteps. With hard code, you would have to change the value in several places, which leads to bugs and mistakes.
for(ii in 1:( length(NN)-1) ){
  #We run the loop for one step less than the length of NN, since we set the value of NN[1] using the initial population size.
  
  #Put your equation(s) inside the for loop
  #You should have as many equations as state variables (in the logistic growth example, just one equation)
  NN[ii+1] <- NN[ii]*(1+RR*(1-NN[ii]/KK))
  
}


# ___________
#4. Display the results by plotting, saving, etc.
# ___________
#Note, 1:length(NN) will just give you a sequence from 1:101.
# This is another example of soft code.
plot(x = 1:length(NN), y = NN, xlab = "time", ylab = "N", type = "b", col = "green",
     main = "Discrete Logistic Growth")

#You can also save your output as a spreadsheet or RData file
write.csv(NN, file = 'Pop_size_outputs.csv')
save(NN, file = 'Pop_size_outputs.RData')
#Look in your working directory for these new files
# Load spreadsheets into a new script using "read.csv" for .csv files
# Load RData into a new script using "load" -- the variable will appear in your memory. 




# ___________
# 5. BONUS You can also write a FUNCTION that returns your population size vector using flexible inputs
# ___________
## DEFINE THE FUNCTION BY RUNNING LINES 74:86
#  Here LogGrowth is the function name. R remembers LogGrowth as a set of instructions, contained inside the curly brackets.
#  Everything in the parenthese is a function input, whose value you set when you call the function below
#  Once you define the function, R will remember it until you remove it from your memory or overwrite
LogGrowth <- function(N0, RR, KK, nsteps){
  
  #Initialize a matrix with NA values of length 1x101
  NN <- matrix(NA, nrow = 1, ncol = nsteps)
  # Set inital condition to N0
  NN[1] <- N0
  
  #Loop over N timesteps
  for(ii in 1:(length(NN)-1)){
    NN[ii+1] <- NN[ii]*(1+RR*(1-NN[ii]/KK))
  }
  return(NN)
}

## CALL THE FUNCTION, but don't save the output
LogGrowth(N0 = 5, RR = 1.2, KK = 50, nsteps = 100)

## CALL THE FUNCTION, and save the output to a new vector, NN_2
NN_2 = LogGrowth(N0 = 5, RR = 1.2, KK = 50, nsteps = 100)

## Plot
plot(x = 1:length(NN_2), y = NN_2, xlab = "time", ylab = "N", type = "b", col = "blue",
     main = "Discrete Logistic Growth")

