function [Z1, Z2] = NN_classifier(X1, Y1, X2, Y2)
    global classA classB classC classD classE classes;
    %% for A and B
    Z1 = zeros(size(X1));
    for i=1:numel(X1)
        min_classA = min(sqrt((classA(1,:)-X1(i)).^2 + (classA(2,:)-Y1(i)).^2));
        min_classB = min(sqrt((classB(1,:)-X1(i)).^2 + (classB(2,:)-Y1(i)).^2));
        if min_classA>min_classB
            Z1(i) = 10; %%classify as B
        else
            Z1(i) = 1; %%classify as A
        end
    end
    
    %%C,D,E
    Z2 = zeros(size(X2));
    for i=1:numel(X2)
        min_classC = min(sqrt((classC(1,:)-X2(i)).^2 + (classC(2,:)-Y2(i)).^2));
        min_classD = min(sqrt((classD(1,:)-X2(i)).^2 + (classD(2,:)-Y2(i)).^2));
        min_classE = min(sqrt((classE(1,:)-X2(i)).^2 + (classE(2,:)-Y2(i)).^2));
        if min_classC < min_classD && min_classC < min_classE
            Z2(i) = 100; %%classify as C
        elseif min_classD < min_classC && min_classD < min_classE
            Z2(i) = 5; %%assign to class D
        elseif min_classE < min_classC && min_classE < min_classD
            Z2(i) = 50; %%assign to class E
        end
    end
end

