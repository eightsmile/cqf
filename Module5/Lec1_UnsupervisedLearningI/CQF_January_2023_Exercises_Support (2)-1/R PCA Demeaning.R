# PCA via 1) princomp (Eigendecomposition) and 2) Singular Value Decomposition: 20 Artificial data points.

# Generate artificial data:
x_orig <- matrix(NA, nrow = 20, ncol = 2)
x_orig[ , 1] <- c(2.5, 2.8, 3, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4, 4.1, 4.2, 4.3, 4.4, 3.7, 4.6, 4.2)
x_orig[ , 2] <- c(4, 5, 4.1, 3.6, 4.3, 4, 4.4, 4.5, 3.8, 3.7, 4.4, 4.2, 4, 3.8, 3.5, 3.4, 3.5, 3.1, 2.9, 3)

plot(x_orig, pch = 16)

cor(x_orig)		# Print correlation matrix.

# 1) Try scaled data => Eigenvectors should be identical.
x3 <- x_orig	# Un-centred data.

# 2) Try original, unscaled data => Eigenvectors should differ.
x3 <- scale(x_orig, center = TRUE, scale = FALSE)	# Centre variables around a mean of 0.

#########
# PCA with R function princomp (Eigendecomposition):
pr <- princomp(x3, cor = FALSE, scores = FALSE, covmat = NULL, fix_sign = FALSE)
pr$loadings		#  Matrix whose columns contain the eigenvectors.

# Singular Value Decomposition:
x_svd <- svd(x3, nu = nrow(x3), nv = ncol(x3))
round(x_svd$v, 3)	# The columns of $v (right-singular vectors) are eigenvectors of x3*x3. Compare this with pr$loadings.


