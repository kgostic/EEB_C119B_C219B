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
# 2. Input data, set parameter values, and/or set state_varsial conditions.
# ___________
#state_varsial population size
state_vars = c(NN = 1)

#Generate a  series of times at which you want the ODE solver to output population sizes
tseq <- seq(0, 20, by = .2)
#Run the line below to see your time sequence
tseq

#Generate a vector of parameter values. This syntax gives the appropriate name to each entry in the vector, so you don't have to remember which parameter comes first, second and third later.
pars <- c(rr = 0.9, kk = 100, hh = 0)
#See what the variable looks like
pars



# ___________
# 3. Write FUNCTION to pass to the ODE solver
# ___________
#  You MUST pass your equations to the ODE solver as a function. 
#  Your function MUST input the following:
  # 1. a single vector of state_varsial conditions, one for each state variable
  # 2. a single vector of time steps, here called tseq
  # 3. a single vector of parameters, here called pars
# Your function must calculate and output a derivative for each state variable


#pars will be a generic term for parameters
logGrowthODE <- function(state_vars, tseq, pars){
  #the pars syntax below requires us to define pars as pars <- c(rr = ##)
  dN_dt <- pars['rr']*state_vars[1]*(1-state_vars[1]/pars['kk'])  #This stores the output of dN/dt = rN to a vector called derivs
  #Hint - with one state variable, we call state_vars[1] to get the first and only entry, which represents NN
  return(list(dN_dt))
}



# ___________
# 4. Call the ODE solver to output your results
# ___________

#Now call the function to the ODE solver. Store the results to a variable called "output"
output <- lsoda(state_vars, tseq, logGrowthODE, pars)

#Plot the output
plot(output[,1], output[,2], col = "blue", type = "l", xlab="time", ylab="N", 
     main = "ODE Logistic Growth")

