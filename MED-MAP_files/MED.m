function [class1] = MED(mean1, mean2, x)
    dist_class1 = sqrt((mean1(1)-x(1)).^2 + (mean1(2)-x(2)).^2);
    dist_class2 = sqrt((mean2(1)-x(1)).^2 + (mean2(2)-x(2)).^2);
    if dist_class1 < dist_class2
        class1 = true;
    else
        class1 = false;
    end
end