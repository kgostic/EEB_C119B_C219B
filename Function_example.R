## Function example

## General structure of a function
## NAME_OF_FUNCTION = function(INPUT_1, INPUT_2, INPUT_3, etc.){
##  WRITE A SERIES OF COMMANDS DEFINING THE FUNCTION HERE
    ## e.g. y = mX+b
##  THEN OUTPUT THE VARIABLE(S) OF INTEREST
   ## return(y)
## }

##Example that solves the quadratic equation

#use inputs a, b, c
quadratic_solver = function(a, b, c){
  
  #calculate roots x1 and x2 using the quadratic equation
  x1 = (-b-sqrt(b^2 - 4*a*c) )/(2*a)
  x2 = (-b+sqrt(b^2 - 4*a*c) )/(2*a)
  
  #return x1 and x2
  return(c(x1, x2))
} #End the function by closing your curly brackets

#Once you have run lines 14-24, you have taught the computer to repeat the series of commands inside the curly brackets whenever you call "quadratic solver"

#Try calling the function
quadratic_solver(a = 2, b= 16, c =1)
