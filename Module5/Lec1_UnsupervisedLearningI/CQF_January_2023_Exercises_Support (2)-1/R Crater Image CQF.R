library(kohonen)

# This example was adapted from the website:
# https://blog.dominodatalab.com/topology-and-density-based-clustering/

set.seed(3)
inner_rad <- 2
outer_rad <- 6.5
donut_len <- 2
inner_pts <- 1000
outer_pts <- 500

# Make the inner core:
radius_core <- inner_rad * runif(inner_pts)
direction_core <- 2 * pi * runif(inner_pts)
# Simulate inner core points:
core_x <- radius_core * cos(direction_core)
core_y = radius_core * sin(direction_core)
crater_core <- cbind(core_x, core_y)	# Aggregate x and y coordinates of the crater core.
# Make the outer ring:
radius_ring <- outer_rad + donut_len * runif(outer_pts)
direction_ring = 2 * pi * runif(outer_pts)
# Simulate ring points:
ring_x <- radius_ring * cos(direction_ring)
ring_y <- radius_ring * sin(direction_ring)

crater_ring <- cbind(ring_x, ring_y)	# Aggregate x and y coordinates of the crater ring.
x <- rbind(crater_ring, crater_core)	# Ordering: 1..500: crater_ring, 501..1500: carter_core.
plot(x)	# Plot crater image.

# SOM:
set.seed(3)		# Set random seed for reproducible results.
x.grid <- somgrid(3, 3, topo = "hexagonal")	# Define SOm grid.
x.som <- som(x, x.grid, rlen = 10000, alpha = c(0.05, 0.01), keep.data = TRUE, mode = "online")		# Train SOM.
summary(x.som)
plot(x.som, type="changes", main = "Training Progress")		# Plot training pogress.
plot(x.som, type= "counts", main = "Mapping of the Crater", shape = "straight")	# Plot the SOM with the number of months mapped onto each unit.
som_cluster <- cutree(hclust(object.distances(x.som, "codes")), 4)	# Separate 4 areas on the SOM.
add.cluster.boundaries(x.som, som_cluster)					# Draw cluster boundaries on SOM.
plot(hclust(object.distances(x.som, "codes")))		# Dendrogram.

x.som$unit.classif		# Check which data points were mapped onto which units.
# The first 500 data points in x constitute the ring, numbers 501 to 1500 the core,
# hence the first 500 data points should be mapped onto units 1, 3, 4, 6, 9.
# Data points 501 to 1500 should be mapped onto units 2, 5, 5, 8.


