function [Z1, Z2] = MAP_classifier(X1, Y1, X2, Y2)
    global nA nB nC nD nE sizes;
    global meanA meanB meanC meanD meanE means;
    global covA covB covC covD covE covs;
    global postA postB postC postD postE;
    %for A and B
    %compare x and y distances to mean of class A and class B
    %smallest distance wins!
    Z1 = zeros(size(X1));
    for i=1:numel(X1)
        classA = MED(meanA, meanB, [X1(i) Y1(i)]);
        if classA
            Z1(i) = 10; %%classify as A
        else
            Z1(i) = 1; %%classify as B
        end
    end

    %C,D,E
    Z2 = zeros(size(X2));
    for i=1:numel(X2)
        CcloserD = MED(meanC, meanD, [X2(i) Y2(i)]);
        CcloserE = MED(meanC, meanE, [X2(i) Y2(i)]);
        DcloserE = MED(meanD, meanE, [X2(i) Y2(i)]);
        
        if CcloserD && CcloserE
            Z2(i) = 100; %%assign to class C
        elseif ~CcloserD && DcloserE
            Z2(i) = 5; %%assign to class D
        elseif ~CcloserE && ~DcloserE
            Z2(i) = 50; %%assign to class E
        end
    end
end

