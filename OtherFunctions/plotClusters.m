function [class] = plotClusters(cov_matrix, mean_matrix, size)
correlated_matrix = chol(cov_matrix);
class = repmat(mean_matrix,1, size) + (randn(size, 2)*correlated_matrix)';
end

