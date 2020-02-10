function [Z1, Z2] = KNN_classifier(X1, Y1, X2, Y2)
    global classA classB classC classD classE classes;
    %% for A and B
    Z1 = zeros(size(X1));
    for i=1:numel(X1)
        distanceA = sqrt((classA(1,:)-X1(i)).^2 + (classA(2,:)-Y1(i)).^2);
        distanceB = sqrt((classB(1,:)-X1(i)).^2 + (classB(2,:)-Y1(i)).^2);
        
        sortedA = sort(distanceA); % sort from lowest to highest
        sortedB = sort(distanceB);
        kmeanA = mean(sortedA(1:5)); % take 5 lowest values and average them
        kmeanB = mean(sortedB(1:5));
        
        if kmeanA < kmeanB
            Z1(i) = 10; %%classify as B
        else
            Z1(i) = 1; %%classify as A
        end
    end
    
    %%C,D,E
    Z2 = zeros(size(X2));
    for i=1:numel(X2)
        distanceC = sqrt((classC(1,:)-X2(i)).^2 + (classC(2,:)-Y2(i)).^2);
        distanceD = sqrt((classD(1,:)-X2(i)).^2 + (classD(2,:)-Y2(i)).^2);
        distanceE = sqrt((classE(1,:)-X2(i)).^2 + (classE(2,:)-Y2(i)).^2);
        
        sortedC = sort(distanceC); % sort from lowest to highest
        sortedD = sort(distanceD);
        sortedE = sort(distanceE);
        
        kmeanC = mean(sortedC(1:5)); % take 5 lowest values and average them
        kmeanD = mean(sortedD(1:5));
        kmeanE = mean(sortedE(1:5));

        if kmeanC < kmeanD && kmeanC < kmeanE
            Z2(i) = 100; %%classify as C
        elseif kmeanD < kmeanC && kmeanD < kmeanE
            Z2(i) = 5; %%assign to class D
        elseif kmeanE < kmeanC && kmeanE < kmeanD
            Z2(i) = 50; %%assign to class E
        end
    end