# https://plotly.com/r/axes/
# This code generates 2 spheres in 3D space with 500 and 100 random numbers and plots them in 3D.
# Data can be further processed with t-SNE, UMAP, PCA & AE.
library(plotly)
library(Rtsne)
library(tsne)
library(umap)
library(h2o)

# Set working directory (change this to your own directory):
s_path <- "my path"
setwd(s_path)

set.seed(417)

# Build 3D chart with 2 spheres:
x <- 500
v_x <- runif(x, 3.5, 4.5)
v_y <- runif(x, 0.5, 1.5)
v_z <- runif(x, 3.5, 4.5)

x <- 100
v_x2 <- runif(x, 0.5, 1.5)
v_y2 <- runif(x, 3.5, 4.5)
v_z2 <- runif(x, 0.5, 1.5)

# Create lists for axis properties
f1 <- list(
  family = "Arial, sans-serif",
  size = 28,
  color = "black")

f2 <- list(
  family = "Old Standard TT, serif",
  size = 14,
  color = "black")		# "#ff9999"

axis <- list(
  titlefont = f1,
  tickfont = f2,
  showgrid = FALSE,
  range = c(0, 5)
)

scene = list(
  xaxis = axis,
  yaxis = axis,
  zaxis = axis,
  camera = list(eye = list(x = -1.25, y = 1.25, z = 1.25)))

ds <- data.frame(cbind(v_x, v_y, v_z))	
ds2 <- data.frame(cbind(v_x2, v_y2, v_z2))
colnames(ds2) <- colnames(ds)
ds <- rbind(ds, ds2)
fig <- plot_ly(ds, x = ~v_x, y = ~v_y, z = ~v_z, type = 'scatter3d', mode = 'markers', marker = list(size = 3))
fig <- fig %>% layout(title = "Two 3D Spheres: [x:4, y:1, z:4], [x:1, y:4, z:1]", scene = scene)
fig

# End of plotting.
############

# Distance matrix:
ds_d <- dist(ds, method = "euclidean", diag = FALSE, upper = FALSE, p = 2)

# t-SNE:

x_p <- 50			# Change the parameters to get the charts on slides 23 & 24.
x_iter <- 200
b_PCA <- TRUE		# Toggle for pre-processing step with PCA, only relevant for Rtsne, cf. slide 25.
x = tsne(ds, perplexity=x_p, max_iter = x_iter)
plot(x, main = paste("Perplexity: ", x_p, ", Iterations: ", x_iter, sep = ""))
x_out <- x		# Save results in variable x_out for further processing, e.g., with CPD & KNN (run R code "R tSNE Test & Goodness of Fit, CQF.R")

# Rtsne (results with same parameters can differ from those obtained with tsne):
# Setting the learning rate etc. acc. to Kobak / Berens (2019), p. 3: important for larger data sets, not for our only 600 points.
r <- Rtsne(ds, pca=b_PCA, perplexity = x_p, theta=0.5, eta = 200, max_iter = x_iter) 	# Charts as on slide 25.
plot(r$Y, main =paste("Perplexity: ", x_p, ", Iterations: ", x_iter, ", PCA=", b_PCA, sep = ""))
x_out <- r$Y	# Check goodness of fit with CPD & KNN, run R code "R tSNE Test & Goodness of Fit, CQF.R".
r$itercosts		# Print Kullback-Leibler Divergence measure. Last value is KLD after training has finished.

# PCA, slide 28:
ds_centred <- scale(ds, center = TRUE, scale = TRUE)	# Centre variables around a mean of 0.
pr <- princomp(ds_centred, cor = FALSE, scores = TRUE)
summary(pr)
screeplot(pr, main ="Screeplot")
pr_load <- pr$loadings[ , 1:2]
matplot(pr_load, type = c("b"),pch=16,col = 1:2, main ="Factor Loadings", ylab = "change in yields", xlab = "Maturities", axes = FALSE)
axis(2)
axis(side=1,at=1:NROW(pr_load),labels=rownames(pr_load))
legend("right", legend = c("PC1", "PC2"), col=1:2, pch=16) # Add legend.

# Factor Scores:
pr_scores <- pr$scores[ , 1:2]
x_out <- pr_scores	# Check goodness of fit with CPD & KNN, run R code "R tSNE Test & Goodness of Fit, CQF.R".
matplot(pr_scores, type = c("b"),pch=16,col = 1:2, main ="Factor Scores", ylab = "change in yields", xlab = "Days", axes = TRUE) #plot
legend("bottomleft", legend = c("PC1", "PC2"), col=1:2, pch=16) # Add legend.


######################
# UMAP, Package umap, slides 41 & 43:
x_params <- umap.defaults		# Copy default settings to modify umap's parameters.
x_params$n_neighbors <- 25		# Set n_neighbors.
x_params$min_dist <- 0.1		# Set min-dist.
x_params$n_epochs <- 200		# Set number of training epochs.
set.seed(27)				# Set random seed for reproducible results. Changing this parameter gives different results.
ds.umap = umap(ds, x_params)		# Run umap.
plot(ds.umap$layout, main = paste("UMAP, n_neighbours: ", x_params$n_neighbors, ", min_dist: ", x_params$min_dist, sep = ""), xlab = "Y1", ylab = "Y2")
x_out <- ds.umap$layout	# Check goodness of fit with CPD & KNN, run R code "R tSNE Test & Goodness of Fit, CQF.R".


######################
# Autoencoder, Package h2o:
h2o.init()
# Show the data objects on the H2O platform:
h2o.ls()
h2o.removeAll()		# Caution: removes all objects from the h2o cluster.

# Set model parameters:
s_hidden <- c(2)		# Change this to reflect different AE structures of hidden layers, e.g., c(3, 2, 3)
x_dd <- scale(ds, center = TRUE, scale = TRUE)	# 
x_orig <- t(x_dd)
write.csv(x_orig, file="test1.csv")			# Write imput data to csv-file for later conversion to h2o-format.
f_dd = paste(s_path, "/test1.csv", sep="")
x = h2o.importFile(path = f_dd, sep ="")		# Imports data to h2o.
x <- na.omit(x)
x_dd <- t(as.numeric(x[ , 2:ncol(x)]))	# Convert data to format h2o can digest.
NN_model = h2o.deeplearning(x = 1:3, training_frame = x_dd, model_id = "1", hidden = s_hidden, epochs = 1000, standardize = TRUE, activation = "Tanh", autoencoder = TRUE, export_weights_and_biases = TRUE, reproducible = TRUE, seed = 10)
summary(NN_model)
model_path <- h2o.saveModel(object=NN_model, path=getwd(), force=TRUE)	# Write model to HD.

########
# Plot 2 common risk factors:
x_hidden <- (NROW(s_hidden) + 1) / 2	# Calculate the index of the hidden layer whose features we want to extract.
x_layer3 <- h2o.deepfeatures(NN_model, x_dd, layer=x_hidden)
s_dd <- paste("Toy Example, Hidden Layer:", paste(s_hidden, collapse = "-"), sep=" ")
df <- as.data.frame(x_layer3)
plot(df, main = s_dd, xlab=paste("Layer ", x_hidden, ", Dim.1", sep=""), ylab = paste("Layer ", x_hidden, ", Dim.2", sep=""), xlim = c(-1,1), ylim = c(-1,1))

# Sort by MSE:
s_dd <- paste("AE ", paste(s_hidden, collapse = "-"), ", MSE by Period", sep="")
# To analyse MSE of individual model:
y_dd <- h2o.anomaly(NN_model, data = x_dd, per_feature = TRUE)	# Reconstruction MSE for each m(i) and each month.
y_dd <- as.matrix(y_dd)
x_MSE <- 1/ncol(y_dd) * apply(y_dd, 1, sum)
x_idx <- order(x_MSE, decreasing = FALSE)		# Sorted from lowest (rk 1) to highest (rk N) SSE.
x_idx		# Print indices of data points. The last data point is the one that can least be explained by AE model.
x_MSE[x_idx]	# Print periods ordered by MSE .
plot(x_MSE[x_idx], main = s_dd, ylab ="MSE", xlab="Index, sorted by MSE")

x_out <- df	# Check goodness of fit with CPD & KNN, run R code "R tSNE Test & Goodness of Fit, CQF.R".

