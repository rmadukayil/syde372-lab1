function [class1] = GED(mean1, mean2, cov1, cov2, x)
    gdist_class1 = sqrt((x' - mean1)'*inv(cov1)*(x' - mean1));
    gdist_class2 = sqrt((x' - mean2)'*inv(cov2)*(x' - mean2));
    if gdist_class1 < gdist_class2
        class1 = true;
    else
        class1 = false;
    end
end
