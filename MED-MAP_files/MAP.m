function [class1] = MAP(mean1, mean2, cov1, cov2, post1, post2, x_vec)
    likelihood = ((x_vec-mean2)'*inv(cov2)*(x_vec-mean2))-((x_vec-mean1)'*inv(cov1)*(x_vec-mean1));
    threshold = (2*log(post2/post1))+(log(det(cov1)/det(cov2)));
    
    if likelihood > threshold
        class1 = true;
    else
        class1 = false;
    end
end