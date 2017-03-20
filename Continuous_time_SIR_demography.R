## Try the ODE Solver lsoda to solve the continuous-time version of the logistic growth model

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
# REMEMBER, YOU NEED TO INSTALL THE PACKAGE deSolve BEFORE YOU CAN LOAD IT BELOW.
#   See the tools tab to install packages, or run the line of code, "install.packages('deSolve')"
require('deSolve')

#Remember you can get help with any function by typing "?FUNCTION_NAME". E.g., "?ls" or "?mean"




# ___________
# 2. Input data, set parameter values, and/or set state_variable conditions.
# ___________
#state_variable population size

## ------------  IMPORTANT !!
## Express your state variables as fractions of the whole population, so S+I+R = 1
## ------------
S0 = 1-.0001
I0 = .0001
R0 = 0
state_vars = c(SS = S0, II = I0, RR = R0)

#Generate a  series of times at which you want the ODE solver to output population sizes
tseq <- seq(0, 500, by = 1)
#Run the line below to see your time sequence
tseq

#Generate a vector of parameter values. This syntax gives the appropriate name to each entry in the vector, so you don't have to remember which parameter comes first, second and third later.
pars <- c(beta = 0.5, gamma = 0.4, mu = 0.0007)
#See what the variable looks like
pars; names(pars) = NULL



# ___________
# 3. Write FUNCTION to pass to the ODE solver
# ___________
#  You MUST pass your equations to the ODE solver as a function. 
#  Your function MUST input the following:
  # 1. a single vector of state_variable conditions, one for each state variable
  # 2. a single vector of time steps, here called tseq
  # 3. a single vector of parameters, here called pars
# Your function must calculate and output a derivative for each state variable


#pars will be a generic term for parameters
SIR_system <- function(tseq, state_vars, pars){
  SS = state_vars[1]
  II = state_vars[2]
  RR = state_vars[3]
  
  beta = pars[1]
  gamma = pars[2]
  mu = pars[3]
  
  dS_dt = mu-beta*state_vars[1]*state_vars[2]-mu*state_vars[1]
  dI_dt = beta*state_vars[1]*state_vars[2] - gamma*state_vars[2]-mu*state_vars[2]
  dR_dt = gamma*state_vars[2]-mu*state_vars[3]
  #Hint - with one state variable, we call state_vars[1] to get the first and only entry, which represents NN
  list(c(dS = dS_dt, dI = dI_dt, dR = dR_dt))
}



# ___________
# 4. Call the ODE solver to output your results
# ___________

#Now call the function to the ODE solver. Store the results to a variable called "output"
output <- lsoda(c(S0, I0, R0), tseq, SIR_system, pars)

# Look at the format of the results. Enter ?head into the console for help with this funciton.
head(output) #The first column is time, "1" is your first state variable (S), "2" is I, and "3" is R

#Plot the output
par(mfrow = c(2,2)) # Set up a plot with two rows and two columns
plot(output[,1], output[,2], col = "blue", type = "l", xlab="time", ylab="N",  main = "S") #Plot column 1 (time), against column 2 (S)
plot(output[,1], output[,3], col = 'red', main = 'I', type = 'l') #Plot column 1 (time), against column 3 (I)
plot(output[,1], output[,4], main = 'R', type = 'l') #Plot column 1 (time), against column 4 (R)


