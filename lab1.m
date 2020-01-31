% Generate class data

% Class sizes
nA = 200;
nB = 200;
nC = 100;
nD = 200;
nE = 150;
sizes = [nA,nB,nC,nD,nE];

% Class means 
meanA = [5; 10];
meanB = [10; 15]; 
meanC = [5; 10];
meanD = [15; 10];
meanE = [10; 5];
means = [meanA,meanB,meanC,meanD,meanE];

% Class covariances
covA = [8 0; 0 4];
covB = [8 0; 0 4];
covC = [8 4; 4 40];
covD = [8 0; 0 8];
covE = [10 -5; -5 20];
covs = [covA,covB,covC,covD,covE];

%classes = double.(5,2,0);
classes = cell(5,2);

for n = 1
    corrdata = chol(covs(n));
    class = repmat(mean(n),sizes(n),1) + randn(sizes(n),2)*corrdata;
    classes{n,1} = class(:, 1);
    classes{n,2} = class(:, 2);
end

%plotmatrix(classA);
scatter(classes{1,1},classes{1,2});
hold on;
scatter(classes{2,1},classes{2,2});



