library(ggplot2)

data(mpg) #Load built-in data set
?cars #Inspect your data set and get to know the variables
head(mpg)


# Ex 1 ->  Plot city vs. highway mpg

attach(mpg)

## R base graphics
plot(cty, hwy, xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot')

# Jitter the points so they don't all overlap
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot')

#Change the color
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2')

#Change the point type
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19)
# See ?points for a list of point characters

#Change the point size
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19, cex = 2)

# Change the text size of the title, axis labels (words) and axis ticks (numbers on tick marks)
#Change the point type
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19, cex.main = 2) #title size

plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19, cex.lab = 2) #Axis label

plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19, cex.axis = 2) #Axis tick

detach(mpg)



# Plot Audi and Chevrolet data in different colors

#First, take subsets of the full data set
Audi = subset(mpg, subset = manufacturer == 'audi')
Chevrolet = subset(mpg, subset = manufacturer == 'chevrolet')

#Start by plotting the Audi data
plot(jitter(Audi$cty), jitter(Audi$hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19)

#Overlay the chevy plot using "points" or "lines"
points(jitter(Chevrolet$cty), jitter(Chevrolet$hwy), pch = 19, col = 'magenta')

#Add a legend in the top left
legend('topleft', legend =  c('Audi', 'Chevrolet'), fill = c('steelblue2', 'magenta'))
# see ?legend






## Now do the same with ggplot2

## NOTE: you MUST put your data into a data frame to use ggplot2



## R base graphics
p = ggplot(mpg, aes(x = cty, y = hwy))
p + geom_point() #Show plot
p + geom_point(color = 'steelblue2') #Add color

p + geom_jitter(color = 'steelblue2') #Add jitter

p + geom_jitter(color = 'steelblue2', size = 3) #Change point size

p + geom_jitter(color = 'steelblue2', size = 3) + ggtitle('MPG plot') #Add title


p + geom_jitter(color = 'steelblue2', size = 3) + ggtitle('MPG plot') + 
  theme(axis.title = element_text(size=22)) + #Change axis label size
  theme(plot.title = element_text(size=22))   #Change plot title size

p + geom_jitter(aes(color = model)) #Color according to model

p + geom_jitter(aes(color = manufacture)) #Color according to make



# Jitter the points so they don't all overlap
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot')

#Change the color
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2')

#Change the point type
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19)
# See ?points for a list of point characters

#Change the point size
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19, cex = 2)

# Change the text size of the title, axis labels (words) and axis ticks (numbers on tick marks)
#Change the point type
plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19, cex.main = 2) #title size

plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19, cex.lab = 2) #Axis label

plot(jitter(cty), jitter(hwy), xlab = 'Highway Mileage', ylab = 'City Mileage', main = 'MPG Plot', col = 'steelblue2', pch = 19, cex.axis = 2) #Axis tick

detach(mpg)

