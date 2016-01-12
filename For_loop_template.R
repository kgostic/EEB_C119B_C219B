#Initialize your population size
NN = 1
#Print out the value of you initial population size
NN

#Set the number of time steps
nsteps = 10

for(ii in 1:nsteps){
  NN[ii+1] = NN[ii]*2
  print(NN)
}

