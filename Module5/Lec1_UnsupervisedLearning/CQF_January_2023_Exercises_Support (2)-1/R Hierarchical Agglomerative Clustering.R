# Hierarchical Cluster Analysis:

x <- c(1, 2, 4, 5, 6)
y <- c(4, 4, 3, 1, 2)

zz <- cbind(x, y)
plot(zz, xlim = c(0, 6), ylim = c(0, 6), pch = 19, bg = "black")

zz_dist <- dist(zz, method = "euclidean", diag = TRUE, upper = FALSE)

x <- hclust(zz_dist, method = "complete", members = NULL)
plot(x, labels = NULL, hang = 0.1, check = TRUE, axes = TRUE, frame.plot = FALSE, ann = TRUE, main = "Complete Linkage", sub = NULL, xlab = NULL, ylab = "Height") 
x <- hclust(zz_dist, method = "single", members = NULL)
plot(x, labels = NULL, hang = 0.1, check = TRUE, axes = TRUE, frame.plot = FALSE, ann = TRUE, main = "Single Linkage", sub = NULL, xlab = NULL, ylab = "Height") 


