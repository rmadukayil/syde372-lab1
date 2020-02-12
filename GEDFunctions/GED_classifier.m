function [Z1, Z2] = GED_classifier(X1, Y1, X2, Y2)
    global nA nB nC nD nE sizes;
    global meanA meanB meanC meanD meanE means;
    global covA covB covC covD covE covs;
    global postA postB postC postD postE;
    %for A and B
    %covariance transform and find distance metric for Class A and B
    Z1 = zeros(size(X1));
    for i=1:numel(X1)
        classA = GED(meanA, meanB, covA, covB, [X1(i) Y1(i)]');
        if classA
            Z1(i) = 10; %%classify as A
        else
            Z1(i) = 1; %%classify as B
        end
    end

    %C,D,E
    Z2 = zeros(size(X2));
    for i=1:numel(X2)
        CcloserD = GED(meanC, meanD, covC, covD, [X2(i) Y2(i)]');
        CcloserE = GED(meanC, meanE, covC, covE, [X2(i) Y2(i)]');
        DcloserE = GED(meanD, meanE, covD, covE, [X2(i) Y2(i)]');
        
        if CcloserD && CcloserE
            Z2(i) = 100; %%classify as class C
        elseif ~CcloserD && DcloserE
            Z2(i) = 5; %%classify as class D
        elseif ~CcloserE && ~DcloserE
            Z2(i) = 50; %%classify as class E
        end
    end
end

