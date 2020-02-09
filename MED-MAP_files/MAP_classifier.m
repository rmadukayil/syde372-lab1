function [Z1, Z2] = MAP_classifier(X1, Y1, X2, Y2)
    global nA nB nC nD nE sizes;
    global meanA meanB meanC meanD meanE means;
    global covA covB covC covD covE covs;
    global postA postB postC postD postE;
    %% for A and B
    Z1 = zeros(size(X1));
    for i=1:numel(X1)
        x_vec = [X1(i) Y1(i)]';
        AgreaterB = MAP(meanA, meanB, covA, covB, postA, postB, x_vec);
        if AgreaterB
            Z1(i) = 10; %%classify as A
        else
            Z1(i) = 1; %%classify as B
        end
    end
    
    %%C,D,E
    Z2 = zeros(size(X2));
    for i=1:numel(X2)
        x_vec = [X2(i) Y2(i)]';
        CgreaterD = MAP(meanC, meanD, covC, covD, postC, postD, x_vec); %%boolean
        CgreaterE = MAP(meanC, meanE, covC, covE, postC, postD, x_vec);
        DgreaterE = MAP(meanD, meanE, covD, covE, postD, postE, x_vec);
        
        if CgreaterD && CgreaterE
            Z2(i) = 100; %%classify as C
        elseif ~CgreaterD && DgreaterE
            Z2(i) = 5; %%assign to class D
        elseif ~CgreaterE && ~DgreaterE
            Z2(i) = 50; %%assign to class E
        end
    end
end

