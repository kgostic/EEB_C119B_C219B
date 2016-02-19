# Data
child.maxs = matrix(seq(1, 19, by = 2), nrow = 10, ncol = 15)
old.mins = matrix(61:75, nrow = 10, ncol = 15, byrow = T)
Hm = matrix(c( 0.2043571, 0.2226860, 0.2464833, 0.2482801, 0.2415724, 0.2363867, 0.2340365, 0.2319989, 0.2378935, 0.20435710, 0.2043569, 0.2227047, 0.2464832, 0.2482802, 0.2415722, 0.2363823, 0.2340111, 0.2319991, 0.2378941, 0.20435690, 0.2043569, 0.2226909, 0.2464827, 0.2482797, 0.2415737, 0.2363817, 0.2340110, 0.2319989, 0.2378890, 0.20435690, 0.2043577, 0.2227046, 0.2464833, 0.2482801, 0.2415724, 0.2363817, 0.2340097, 0.2319984, 0.2378936, 0.20435770, 0.2043583, 0.2227072, 0.2464831, 0.2482801, 0.2415726, 0.2363844, 0.2340109, 0.2319938, 0.2378938, 0.20435830, 0.2043582, 0.2227044, 0.2464167, 0.2482771, 0.2415723, 0.2363835, 0.2340107, 0.2319904, 0.2378943, 0.20435820, 0.2043580, 0.2227043, 0.2464842, 0.2482803, 0.2415720, 0.2363830, 0.2340127, 0.2319966, 0.2378934, 0.20435800, 0.2043580, 0.2227033, 0.2465037, 0.2482801, 0.2415720, 0.2363830, 0.2340093, 0.2319957, 0.2378933, 0.20435800, 0.2043587, 0.2227049, 0.2464477, 0.2482801, 0.2415719, 0.2363824, 0.2340034, 0.2319990, 0.2378944, 0.20435870, 0.2043587, 0.2227051, 0.2464832, 0.2482825, 0.2415758, 0.2363828, 0.2340096, 0.2319949, 0.2378934, 0.20435870, 0.2043582, 0.2227006, 0.2464832, 0.2482801, 0.2415724, 0.2363845, 0.2340175, 0.2319990, 0.2378934, 0.20435820, 0.2043590, 0.2227071, 0.2464801, 0.2482801, 0.2415721, 0.2363833, 0.2340100, 0.2319990, 0.2378900, 0.20435900, 0.2043581, 0.2227051, 0.2464831, 0.2482801, 0.2415725, 0.2363834, 0.2340091, 0.2319992, 0.2378934, 0.20435810, 0.2043559, 0.2227051, 0.2464832, 0.2482809, 0.2410970, 0.2353516, 0.2332338, 0.2316103, 0.2376833, 0.20435590, 0.2012437, 0.2199822, 0.2437402, 0.2444422, 0.2372560, 0.2316670, 0.2295583, 0.2278882, 0.2338612, 0.20124370), nrow = 10, ncol = 15)


# Load packages 
library('fields')

# Set colors
# Create a function interpolating colors in the range of specified colors
jet.colors <- colorRampPalette( c("blue", "green") )
# Generate the desired number of colors from this palette
nbcol <- 100
color <- jet.colors(nbcol)

# Set margins
par(mar = c(5, 4, 5, 7))
# Plot heatmap
image(child.maxs[,1], old.mins[1,], Hm, xlab = 'Max age in child risk group', ylab = 'Min age in elderly risk group', col = color, main = 'H5N1, Hm', xaxt = 'n', yaxt = 'n')

# Manually set axis labels 
##   1 indicates the x axis
##   "at" sets the x values at which you want labels to appear
##   "labels" sets the actual text that you want to appear at each corresponding x value
axis(1, at = child.maxs[,1], labels = child.maxs[,1]-1)
# plot vertical lines at each x value, starting with 0
abline(v = child.maxs[,1]-1, col = 'grey')
# Manually set y axis labels
axis(2, at = old.mins[1,])
# plot horizontal lines at each y value label
abline(h = old.mins[1,]-.5, col = 'grey')
# add the colorbar scale
image.plot(zlim = range(Hm), legend.only=T, col=color)