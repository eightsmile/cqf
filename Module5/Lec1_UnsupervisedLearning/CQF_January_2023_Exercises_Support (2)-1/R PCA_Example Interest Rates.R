# PCA: Example Interest Rates
# My recommendation is to go through this code line by line and mess with the parameters.

setwd("My path")		# Replace with your own path.
sh1 <- read.csv(file="US IR, test.csv", head=FALSE,sep=",")		# index values of variables.
# The data are taken from the Fed's webiste:
# https://www.federalreserve.gov/datadownload/Download.aspx?rel=H15&series=bf17364827e38702b42a58cf8eaa3f78&lastobs=&from=&to=&filetype=csv&label=include&layout=seriescolumn&type=package

s_dd <- c("NA", "1M", "3M", "6M", "1Y", "2Y", "3Y", "5Y", "7Y", "10Y", "20Y", "30Y")	# Maturities.
x <- sh1[14128:14615, 1:ncol(sh1)]		# Select our 471 data points.
colnames(x) <- s_dd
y <- apply(x[ , 2:ncol(x)], 2, as.numeric)
y <- na.omit(y)		# Treat NAs.
# y <- diff(y)		# Differences or levels: for stationary time series take levels (interest rates should in theory be stationary).

# Plot time series:
s_x <- c("3M", "2Y", "5Y", "10Y")
matplot(y[ , s_x], type = c("b"),pch=16,col = 1:NROW(s_x), main ="US Interest Rates", ylab = "yield level (%)", xlab = "Days") #plot
legend("topleft", legend = s_x, col=1:NROW(s_x), pch=16) # optional legend

x3 <- scale(y, center = TRUE, scale = FALSE)	# Centre variables around a mean of 0.
pr <- princomp(x3, cor = FALSE, scores = TRUE, covmat = NULL, fix_sign = TRUE)
summary(pr)
screeplot(pr, main ="Screeplot")

# Plot the first 3 PCs:
pr_load <- pr$loadings[ , 1:3]	# Check signs of the PCs and potentially reverse for better interpretability:
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

pr$loadings		#  Matrix whose columns contain the eigenvectors (=> elements of the eigenvectors are the factor loadings).

# Plot slope of YC 10Y - 1Y to compare with PC2:
x <- y[ , "10Y"] - y[ , "1Y"]
plot(x, pch = 16, main = "YC Steepness: US10Y - US1Y", ylab = "US10Y - US1Y", xlab = "Days")
matplot(cbind(x, pr_scores[ , 2]), type = c("b"),pch=16,col = 1:2, main ="Factor Scores (PC2) vs. US10Y-US1Y", ylab = "change in yields (PC2), yield diff. (US10Y-US1y)", xlab = "Days", axes = TRUE) #plot
legend("topleft", legend = c("US10Y-US1Y", "PC2"), col=1:2, pch=16) # Add legend.

# Calculate residuals from PC1 to PC3:
zz <- pr_load %*% t(pr_scores)	# Reconstruct centred rates 
x_centred_pr <- t(zz)

# Plot Yield Curve Key Rates vs. reconstructed data from PCA (PC1 to PC3):
qq <- 11	# Set qq from 1 to 11 ("1M" to "30Y").
y_pr <- x_centred_pr[ , qq] + mean(y[ , qq])		# Add back mean from centred data.
matplot(cbind(y[ , qq], y_pr), type = c("b"), pch=16, col = 1:2, main = paste("Reconstructed Yield Curve Key Rate (", rownames(pr_load)[qq], ") vs. PCA", sep=""), ylab = "yields", xlab = "Days", axes = TRUE) #plot
x_residuals <- y[ , qq] - y_pr		# Calculate residuals.
plot(x_residuals, type = "b", pch = 16, main = paste("Residuals from Yield Curve Key Rate (", rownames(pr_load)[qq], ") vs. PCA", sep=""), ylab = "yields", xlab = "Days", axes = TRUE)

# Reconstruct original data, compute residuals:
s_v <- 1:11		# For PC1 & PC2: s_v <- 1:2. For PC1 only: s_dd <- 1.
x_centred_pr <- pr$loadings[ , s_v] %*% t(pr$scores[ , s_v])	# Reconstructed x_centred: equivalent to eigenvectors %*% factor_scores.
x_centred <- t(x3)
round(x_centred - x_centred_pr, 3)		# Print residuals. Check residuals = 0 if s_v = 1:11.

