

## 1. DEFINE PARAMETERS
# Birth probabilities for types S, R and C, respectively
Betas = c(.7, .5, .4)
# Death probabilities for types S, R and C, respectively
mus = c(.45, .55, .55)
# Toxicity of C on S
tau = 0.1


## 2. INITIALIZE THE MODEL SPACE

# Model space will be a grid of 10 rows x 10 columns, where each cell is represenented by an entry in an 10x10 matrix
# Possible states are: 0: empty, 1: sensitive, 2: resistant and 3: colicin

# First make a matrix of all 0's
model.grid = matrix(0, nrow = 10, ncol = 10, dimnames = list(paste('r', 1:10, sep = ''), paste('c', 1:10, sep = '')))

#check grid
model.grid

# You will have 100 total grid cells. To populate the cells, I will initially randomly order cells 1:100. The first 25 in the list will be assigned initial state 0, the next 25 will be assigned initial state 1, and so on
initial.random.order = sample(x=100, size = 100, replace = FALSE)

# Now use the random order to assign initial states in the model grid
init.0 = initial.random.order[1:25] #No change...these cells will stay at 0
init.1 = initial.random.order[26:50]; model.grid[init.1] = 1 #Update the value of these cells to 1
init.2 = initial.random.order[51:75]; model.grid[init.2] = 2 #Update the value of these cells to 2
init.3 = initial.random.order[76:100]; model.grid[init.3] = 3 #Update the value of these cells to 3

#Check grid
model.grid

#Plot initial grid
image(x = 1:10, y = 1:10, z = model.grid, col = c('white', 'blue', 'green', 'red'))
#Here white = 0, blue = 1, green = 2, and red = 3



## 3. Update the model by one time step

# First calculate the transition probabilities

# Transition probabilities are unique for each cell and change for each time step, so we will use a matrix that represents the probability for each cell, and update the probabilities for each time step


#This function will input the current model grid and output the updated grid
model.grid.update.function = function(model.grid){
  
  #Initialize new, empty probability matricies
  updated.model.grid = matrix(0, nrow = 10, ncol = 10, dimnames = list(paste('r', 1:10, sep = ''), paste('c', 1:10, sep = ''))) #We will fill this in as we go along cell by cell
  birth.probs = matrix(0, nrow = 10, ncol = 10)
  death.probs = matrix(0, nrow = 10, ncol = 10)

  
  for(ii in 1:10){ # For all 10 rows
    for(jj in 1:10){ # And all 10 columns
      # The model cell in question is cell ii, jj
      cell.state = model.grid[ii, jj] #Gives current state
      neighborhood.rows = max(1, (ii-1)):min(10, ii+1) #Define the rows and columns in the cells' neightborhood
      neighborhood.cols = max(1, (jj-1)):min(10, jj+1)
      neighborhood = model.grid[neighborhood.rows, neighborhood.cols] #Returns the neighborhood 1 row and 1 column in either direction of the cell of interest
      neighborhood[rownames(model.grid)[ii], colnames(model.grid)[jj]] = 0 #Get rid of the value of the cell of interest 
      
      #Get neighborhood fractions
      fS = sum(neighborhood == 1)/8
      fR = sum(neighborhood == 2)/8
      fC = sum(neighborhood == 3)/8
      
      #If the cell is empty, determine whether a birth occurrs
      if(cell.state == 0){
        
      #Birth.probs gives a vector of the probability of birth into S, R, C, or no birth (in that order)
      birth.probs = c(Betas*c(fS, fR, fC), 1-sum(Betas*c(fS, fR, fC)))
      
      # Draw a weighted sample based on birth.probs to update the cell type
      updated.model.grid[ii, jj] = sample(0:3, size = 1, prob = birth.probs)
      }
      
      #If the cell is susceptible, determine whether a death occurs
      if(cell.state == 1){
        #Birth.probs gives a vector of the probability of birth into S, R, C, or no birth (in that order)
        death.prob = (mus[1]+tau*fC)
        # Draw a weighted sample based on birth.probs to update the cell type
        updated.model.grid[ii, jj] = sample(0:1, size = 1, prob = c(death.prob, 1-death.prob)) #Either changes to a 0 (death) with probability equal to "death.prob", or remains in state 1 with probability 1-death.prob
      }
      
      #If the cell is resistant, determine whether a death occurs
      if(cell.state == 2){
        #Birth.probs gives a vector of the probability of birth into S, R, C, or no birth (in that order)
        death.prob = (mus[2])
        # Draw a weighted sample based on birth.probs to update the cell type
        updated.model.grid[ii, jj] = sample(c(0,2), size = 1, prob = c(death.prob, 1-death.prob)) #Either changes to a 0 (death), or remains in state 2
      }
      
      #If the cell is colicin-producing, determine whether a death occurs
      if(cell.state == 3){
        #Birth.probs gives a vector of the probability of birth into S, R, C, or no birth (in that order)
        death.prob = (mus[3])
        # Draw a weighted sample based on birth.probs to update the cell type
        updated.model.grid[ii, jj] = sample(c(0,3), size = 1, prob = c(death.prob, 1-death.prob)) #Either changes to a 0 (death) with probability equal to "death.prob", or remains in state 3 with probability 1-death.prob
      }
      
    }
  }
  #Finally, after updating every cell, overwrite the previous model grid
  ## NOTE, IN REAL LIFE YOU WOULD WANT TO STORE YOUR OUTPUTS OF INTEREST BEFORE YOU DID THIS
 #I'll just plot the grid before I overwrite it instead
image(x = 1:10, y = 1:10, z = model.grid, col = c('white', 'blue', 'green', 'red'))

#Now overwrite
  model.grid = updated.model.grid

# And return the updated output
return(model.grid)

} #end function







## Finally, run the simulation for 25 time steps by calling the update function in a for loop
for(tt in 1:25){
  model.grid = model.grid.update.function(model.grid)
}


#You can use the back arrow in the top left corner of your plotting window to scroll back through time and look at the changing outputs