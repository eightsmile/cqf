# PCA Example: 10 Artificial data points.

# Generate artificial data:
x_orig <- matrix(NA, nrow = 10, ncol = 2)
x_orig[ , 1] <- c(14.3, 12.2, 13.7, 12.0, 13.4, 14.3, 13.0, 14.8, 11.1, 14.3)
x_orig[ , 2] <- c(7.5, 5.5, 6.7, 5.1, 5.2, 6.3, 7.6, 7.3, 5.3, 7.2)

plot(x_orig, xlim=c(0,15), ylim=c(0,15), pch = 16)
cor(x_orig)		# Print correlation matrix.
x3 <- scale(x_orig, center = TRUE, scale = FALSE)	# Centre variables around a mean of 0.
vcv3 <- cov(x3)	# Covariance matrix.

#########
# PCA "self-made" with R function eigen:

e3 <- eigen(vcv3, symmetric = TRUE)		# Extract eigenvectors and -values from covariance matrix.
e3		# print eigenvectors and -loadings.
e3v <- e3$vectors		# Assign eigenvectors to variable e3v.

e3$values / sum(e3$values)	# Portion of variance explained by PCs.
sum(e3$values)			# Total variance of the variable system.

# Plot PCs (this is the analogue to the plot of the first 3 PCs in the interest rate exmaple):
s <- c("x", "y")
matplot(e3v, type = c("b"),pch=16,col = 1:3, main ="Factor Loadings", ylab = "Factor Loadings", xlab = "x_orig", axes = FALSE) # Plot with axes removed.
axis(2)		# Add ordinate.
axis(side=1,at=1:2,labels=s)	# Add abscissa with labes.
legend("topright", legend = c("PC1", "PC2"), col=1:2, pch=16) # Add legend.

# Reconstruction of original data:
s_v <- 1:2		# For PC1 & PC2: s_v <- 1:2. For PC1 only: s_v <- 1.
x_centred <- t(x3)
x_scores <- t(e3v[ , s_v]) %*% x_centred		# Factor Scores, p. 20.
x4 <- t(x_scores)
s <- NULL		# Initialise variable.
for(i in 1:ncol(x4))
{
	s <- c(s, paste("PC", i, "_scores", sep=""))	# 
}
colnames(x4) <- s		# Rename columns for easier legibility.

plot(x3, xlim=c(-3, 3), ylim=c(-3, 3), pch=16)	# Mean-adj. data, correlated.

{
if(length(s_v) == 1)
	s_x <- cbind(x4[ , s_v], rep.int(0, 10))	# For plotting: PC1 only => set PC2 to 0.
else
	s_x <- x4						# Plot both dimensions.
}
plot(s_x, xlim=c(-3, 3), ylim=c(-3, 3), pch=16)	# Transformed data, uncorrelated (first 2 PCs).

round(cor(x4), 3)		# New variables are orthogonal: their correlations must be 0.
x_centred_2 <- t(t(e3v[ , s_v])) %*% x_scores		# Reconstructed data from factors.
x_centred_2		# Print reconstructed centred data.
x_centred		# Print centred data.
round(x_centred - x_centred_2, 3)		# Print residuals.

t(x_centred_2 + apply(x_orig, 2, mean))	# Print reconstructed original data.
x_orig		# Print original data. If s_v = 1:2 x_orig should match exactly the reconstructed data.

cov(t(x_scores))	# Elements on diagonal of factor scores' VCV give the factor loadings. 

#########
# PCA with R function princomp:
pr <- princomp(x3, cor = FALSE, scores = TRUE, covmat = NULL, fix_sign = FALSE)
pr$scores		# Factor scores.
pr$loadings		#  Matrix whose columns contain the eigenvectors.

# Reconstruction of original data:
x_centred_pr <- pr$loadings[ , s_v] %*% t(pr$scores[ , s_v])	# Reconstructed x_centred: equivalent to eigenvectors %*% factor_scores.
x_centred
round(x_centred - x_centred_pr, 3)		# Print residuals.

t(x_centred_pr + apply(x_orig, 2, mean))	# Print reconstructed original data.
x_orig		# Print original data.


