# t-SNE & UMAP: Example US Interest Rates
library(Rtsne)
library(umap)
library(h2o)

# Settings:
s_path <- "C:/Users/TradeCap/Documents/Claus Huber/Quant Models/CQF/Presentations/2021-10-12, UML 2/"		# Replace with your own path.

setwd(s_path)
sh1 <- read.csv(file="US IR, test.csv", head=FALSE,sep=",")		# index values of variables.
# The data are taken from the Fed's webiste:
# https://www.federalreserve.gov/datadownload/Download.aspx?rel=H15&series=bf17364827e38702b42a58cf8eaa3f78&lastobs=&from=&to=&filetype=csv&label=include&layout=seriescolumn&type=package

s_dd <- c("NA", "1M", "3M", "6M", "1Y", "2Y", "3Y", "5Y", "7Y", "10Y", "20Y", "30Y")	# Maturities.
x <- sh1[14128:14615, 1:ncol(sh1)]		# Select our 471 data points.
colnames(x) <- s_dd
y <- apply(x[ , 2:ncol(x)], 2, as.numeric)	# Possible warnings are for missing values, just ignore.
y <- na.omit(y)		# Treat NAs.
# y <- diff(y)		# Differences or levels: for stationary time series take levels (interest rates should in theory be stationary).
ds <- y		# Copy variable y to ds for check of Goodness of Fit, see slides 62, 63 and R code "R tSNE Test & Goodness of Fit, CQF.R".

# Plot time series:
s_x <- c("3M", "2Y", "5Y", "10Y")
matplot(y[ , s_x], type = c("b"),pch=16,col = 1:NROW(s_x), main ="US Interest Rates", ylab = "yield level (%)", xlab = "Days") #plot
legend("topleft", legend = s_x, col=1:NROW(s_x), pch=16) # optional legend

######################
# PCA:
x3 <- scale(y, center = TRUE, scale = FALSE)	# Centre variables around a mean of 0.
pr <- princomp(x3, cor = FALSE, scores = TRUE, covmat = NULL, fix_sign = TRUE)
summary(pr)
screeplot(pr, main ="Screeplot")

# Plot the first 3 PCs:
pr_load <- pr$loadings[ , 1:3]	# Check signs of the PCs and potenitally reverse for better interpretability:
pr_load[ , 2] <- -pr_load[ , 2]	# Reverse sign of PC2.
matplot(pr_load, type = c("b"), pch=16, col = 1:3, main ="Factor Loadings", ylab = "change in yields", xlab = "Maturities", axes = FALSE)
axis(2)
axis(side=1,at=1:NROW(pr_load),labels=rownames(pr_load))
legend("bottomright", legend = c("PC1", "PC2", "PC3"), col=1:3, pch=16) # Add legend.

# Plot Factor Scores over time:
pr_scores <- pr$scores[ , 1:3]
pr_scores[ , 2] <- -pr$scores[ , 2]		# Reverse sign of PC2.
matplot(pr_scores, type = c("b"),pch=16,col = 1:3, main ="Factor Scores", ylab = "change in yields", xlab = "Days", axes = TRUE) #plot
legend("topleft", legend = c("PC1", "PC2", "PC3"), col=1:3, pch=16) # Add legend.

# Plot the factor scores of the first 2 PCs (each dot represents 2 factor scores for 1 day):
plot(pr_scores[ , 1:2], main ="PCA: Factor Scores", xlab = "PC1", ylab ="PC2")

x_out <- pr_scores[ , 1:2]	# Check goodness of fit with CPD & KNN, run R code "R tSNE Test & Goodness of Fit, CQF.R".
	
######################
# t-SNE, Package Rtsne (results with same parameters will differ from those obtained with tsne), slide 30:
# Setting the learning rate etc. acc. to Kobak / Berens (2019), p. 3: important for larger data sets, not for our only 600 points.
x_p <- 30		# Perplexity.
x_iter <- 1000	# Iterations.
b_PCA <- TRUE	# TRUE => run PCA as a pre-processing step.

set.seed(7)
r <- Rtsne(y, pca=b_PCA, pca_center = TRUE, pca_scale = FALSE, perplexity = x_p, theta=0.0, eta = 200, max_iter = x_iter) 	#
plot(r$Y, main =paste("t-SNE, Perplexity: ", x_p, ", Iterations: ", x_iter, ", PCA=", b_PCA, sep = ""))

x_out <- r$Y	# Check goodness of fit with CPD & KNN, run R code "R tSNE Test & Goodness of Fit, CQF.R".

######################
# UMAP, Package umap, slide 48:
x_params <- umap.defaults		# Copy default settings to modify umap's parameters.
x_params$n_neighbors <- 25		# Set n_neighbors.
x_params$min_dist <- 0.5		# Set min-dist.
x_params$n_epochs <- 200		# Set number of training epochs.
set.seed(7)
ds.umap = umap(y, x_params)		# Run umap.
plot(ds.umap$layout, main = paste("UMAP, n_neighbours: ", x_params$n_neighbors, ", min_dist: ", x_params$min_dist, sep = ""), xlab = "Y1", ylab = "Y2")

x_out <- ds.umap$layout		# Check goodness of fit with CPD & KNN, run R code "R tSNE Test & Goodness of Fit, CQF.R".


######################
# Autoencoder, Package h2o:

h2o.init()
# Show the data objects on the H2O platform
h2o.ls()

# Set model parameters:
s_hidden <- c(7, 5, 2, 5, 7)		# Change this to reflect different AE structures of hidden layers.
# Fewer than 3 hidden layers do not lead to plausible results.
x_dd <- scale(y, center = TRUE, scale = TRUE)	# 
x_orig <- t(x_dd)
write.csv(x_orig, file="test1.csv")			# Write imput data to csv-file for later conversion to h2o-format.
f_YC = paste(s_path, "/test1.csv", sep="")
x = h2o.importFile(path = f_YC,sep=",")		# Imports data to h2o.
x <- na.omit(x)
x_YC <- t(as.numeric(x[ , 2:ncol(x)]))	# Convert data to format h2o can digest.
NN_model = h2o.deeplearning(x = 1:11, training_frame = x_YC, model_id = "1", hidden = s_hidden, epochs = 1000, standardize = TRUE, activation = "Tanh", autoencoder = TRUE, export_weights_and_biases = TRUE, reproducible = TRUE, seed = 10)
summary(NN_model)
model_path <- h2o.saveModel(object=NN_model, path=getwd(), force=TRUE)	# Write model to HD.

########
# Plot 2 common risk factors:
x_hidden <- (NROW(s_hidden) + 1) / 2	# Calculate the index of the hidden layer whose features we want to extract.
x_layer3 <- h2o.deepfeatures(NN_model, x_YC, layer=x_hidden)
s_dd <- paste("Hidden Layer:", paste(s_hidden, collapse = "-"), sep=" ")
df <- as.data.frame(x_layer3)
plot(df, main = s_dd, xlab=paste("Layer ", x_hidden, ", Dim.1", sep=""), ylab = paste("Layer ", x_hidden, ", Dim.2", sep=""), xlim = c(-1,1), ylim = c(-1,1))

# Sort by MSE:
s_dd <- paste("AE ", paste(s_hidden, collapse = "-"), ", MSE by Period", sep="")
# To analyse RMSE of individual model:
y_dd <- h2o.anomaly(NN_model, data = x_YC, per_feature = TRUE)	# Reconstruction MSE for each m(i) and each month.
y_dd <- as.matrix(y_dd)
x_MSE <- 1/ncol(y_dd) * apply(y_dd, 1, sum)
x_idx <- order(x_MSE, decreasing = FALSE)
x_MSE[x_idx]	# Print periods ordered by MSE .
plot(x_MSE[x_idx], main = s_dd, ylab ="MSE", xlab="Index of Periods, sorted by MSE")
write.csv(cbind(x_MSE[x_idx], x_idx), file="m_sorted MSE.csv")	# Sorted from lowest (rk 1) to highest (rk N) SSE.

x_idx		# Print indices of the 471 periods. Last index values show the largest MSEs, i.e., the periods that cannot be well explained by model.

x_out <- df	# Check goodness of fit with CPD & KNN, run R code "R tSNE Test & Goodness of Fit, CQF.R".

# Value of 5 Sep 2017 (day with largest MSE for AE with 3 and 5 hidden layers), red on slide 56:
y[391, ]
x_layer3[391, ]

# Value of 5 Jul 2016 (day with 2nd-largest MSE for AE with 5 hidden layers, c(7, 5, 2, 5, 7)), blue on slide 56:
y[98, ]
x_layer3[98, ]

# Value of 26 Dec 2017 (day with largest MSE for AE with 3 hidden layers, c(5, 2, 5)), green on slide 56:
y[468, ]
x_layer3[468, ]

