#Initialize your population size
NN = 1
#Print out the value of you initial population size
NN

#Set your population growth rate
r = 2

#Set the number of time steps
nsteps = 10

for(ii in 1:nsteps){
  NN[ii+1] = NN[ii]*r
  print(NN)
}

