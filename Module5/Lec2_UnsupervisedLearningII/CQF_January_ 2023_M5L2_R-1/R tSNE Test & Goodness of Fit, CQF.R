# CPD & KNN (Goodness of Fit measures, Kobak / Berens (2019)):

# This R code needs 2 matrices as inputs:
# 1) the original data in ds, 2) the model output x_out.
# For our toy example, ds is 600 x 3, x_out is 600 x 2.
# Run R code "R 3D Plot Toy Example.R" first to build the models, e.g., t-SNE (via Rtsne). 
# x_out is set after building the model has been built, e.g., x_out <- r$Y for Rtsne, x_out <- pr_scores for PCA, etc.
# When both ds and x_out have been determined, run the R code below to calculate CPD & KNN:

#######################
# User settings:
K <- 10		# Number of Nearest Neighbours.


xd <- dist(ds, method = "euclidean", diag = FALSE, upper = FALSE)   # Get distance matrix for orig. data.
xd1 <- as.matrix(xd)	# Convert to matrix format.	
outd <- dist(x_out, method = "euclidean", diag = FALSE, upper = FALSE)   # Distance matrix for model output.
outd1 <- as.matrix(outd)	# Convert to matrix format.

x_dd <- c(1:nrow(ds))
x_ed <- matrix(NA, nrow = 2, ncol = nrow(ds))  # To save results. Row 1: ED for orig. data, row 2: ED for model output.
	
for(i in 1:nrow(ds))
{
	x_xd1 <- order(xd1[ , i], decreasing = FALSE)		# Index sorted by ED in ascending order.
	x_outd1 <- order(outd1[ , i], decreasing = FALSE)		# Index sorted by ED in ascending order.

	x <- which(x_xd1[1:(K + 1)] == x_outd1[1:(K + 1)])	# K + 1 as elements on diagonal are always 0 (=min).
	x_dd[i] <- (NROW(x) - 1) / K

	x_ed[1, i] <- sum(xd1[ , i])		# Save sum ED of col. i => later compare the sum ED of orig. data with sum ED of model.
	x_ed[2, i] <- sum(outd1[ , i])	# Sum ED, model output.
}

CPD <- cor(t(x_ed), method = "spearman")	# Compute Spearman rank correlation between ED of orig. data and model.
CPD		# CPD is a global measure. Compare with Quantisation Error for SOM.
# This statistic based on the Spearman rank correlation is called CPD in Kobak / Berens (2019).

KNN <- round(mean(x_dd), 2)	# As defined in Kobak/Berens (2019) and Bibal / Frénay (2016).
KNN	# KNN is a local measure. Compare with Topographical Error for SOM.

