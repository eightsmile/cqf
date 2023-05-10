
#####################
# Generate artificial data:
x_orig <- matrix(NA, nrow = 10, ncol = 2)
x_orig[ , 1] <- c(14.3, 12.2, 13.7, 12.0, 13.4, 14.3, 13.0, 14.8, 11.1, 14.3)
x_orig[ , 2] <- c(7.5, 5.5, 6.7, 5.1, 5.2, 6.3, 7.6, 7.3, 5.3, 7.2)
x3 <- scale(x_orig, center = TRUE, scale = FALSE)	# Subtract mean from x_orig (see formula for calculating VCV) = centre variables around a mean of 0, leave variance unscaled.

# Use R's built-in functions to calculate VCV:
cov(x_orig)		# Original, untransformed data.
cov(x3)		# Transformed data.
# Self-calculate VCV (=x3 * x3_T):
X <- t(x3)   # X should have dimensions (T x N) = (10 x 2), hence we need to transpose x3.
(X %*% t(X)) / (ncol(X) - 1)  # = X * t(X).
# All 3 calculation methods should give identical results.

e3 <- eigen(cov(x3), symmetric = TRUE)		# Extract eigenvectors and -values from covariance matrix.
e3		# print Eigenvectors and -values.
L <- matrix(0, nrow = 2, ncol = 2)  # Initialise matrix as basis for L with diagonal elements = Eigenvalues.
L[1, 1] <- e3$values[1]
L[2, 2] <- e3$values[2]

# Construct the original matrix A (=VCV) as product of Eigenvectors and Eigenvalues:
A <- e3$vectors %*% L %*% t(e3$vectors)  # ... using the transpose of the Eigenvectors.
A
e3$vectors %*% L %*% solve(e3$vectors)  # ... using the inverse of the Eigenvectors.

# Check if A * e3$vectors[ , 1] = e3$value[1] * e3[ , 1]:
# 1) A * e3$vectors[ , 1] = VCV * 1st Eigenvector:
A %*% e3$vectors[ , 1]		# This should be equal to...

# 2) e3$value[1] * e3$vectors[ , 1] = 1st Eigenvalue * 1st Eigenvector;
e3$value[1] %*% e3$vectors[ , 1]	# ... this row.

# Are the 2 Eigenvectors orthogonal to each other? If so, their dot product should be 0:
e3$vectors[ , 1] %*% e3$vectors[ , 2]


A %*% e3$vectors[ , 1]



