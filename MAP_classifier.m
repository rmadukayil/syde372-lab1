clear all;
close all;

nA = 200;
nB = 200;
nC = 100;
nD = 200;
nE = 150;

classA = csvread('classA');
classB = csvread('classB');
classC = csvread('classC');
classD = csvread('classD');
classE = csvread('classE');

% Class means 
meanA = [5 10]';
meanB = [10 15]'; 
meanC = [5 10]';
meanD = [15 10]';
meanE = [10 5]';

% Class covariances
covA = [8 0; 0 4];
covB = [8 0; 0 4];
covC = [8 4; 4 40];
covD = [8 0; 0 8];
covE = [10 -5; -5 20];

%% for A and B
%%compare x and y distances to mean of class A and class B
%%smallest distance wins!
x = -2:0.1:22;
y = -2:0.1:22;
[X,Y] = ndgrid(x);
Z = zeros(size(X));
for i=1:numel(X)
    x_vec = [X(i) Y(i)]';
    likelihood = ((x_vec-meanB)'*inv(covB)*(x_vec-meanB))-((x_vec-meanA)'*inv(covA)*(x_vec-meanA));
    if likelihood > 0
        Z(i) = 10; %%classify as A
    else
        Z(i) = 1; %%classify as B
    end
end
figure(1);
scatter(classA(1,:), classA(2,:));
hold on;
scatter(classB(1,:),classB(2,:));
hold on;
contour(X,Y,Z,1);

%%C,D,E
x = -5:0.1:25;
y = -5:0.1:25;
[X,Y] = ndgrid(x);
Z = zeros(size(X));
%%posterior class probabilities
postC = nC/(nC+nD+nE);
postD = nD/(nC+nD+nE);
postE = nE/(nC+nD+nE);
for i=1:numel(X)
    x_vec = [X(i) Y(i)]';
    likelihood_CD = ((x_vec-meanD)'*inv(covD)*(x_vec-meanD))-((x_vec-meanC)'*inv(covC)*(x_vec-meanC));
    likelihood_CE = ((x_vec-meanE)'*inv(covE)*(x_vec-meanE))-((x_vec-meanC)'*inv(covC)*(x_vec-meanC));
    likelihood_DE = ((x_vec-meanE)'*inv(covE)*(x_vec-meanE))-((x_vec-meanD)'*inv(covD)*(x_vec-meanD));
    threshold_CD = (2*log(postD/postC))+(log(det(covC)/det(covD)));
    threshold_CE = (2*log(postE/postC))+(log(det(covC)/det(covE)));
    threshold_DE = (2*log(postE/postD))+(log(det(covD)/det(covE)));
    
    if likelihood_CD > threshold_CD && likelihood_CE > threshold_CE
        Z(i) = 100; %%class C has greater posterior distr than class D and E
    elseif likelihood_CD < threshold_CD && likelihood_DE > threshold_DE
        Z(i) = 5; %%assign to class D
    elseif likelihood_CE < threshold_CE && likelihood_DE < threshold_DE
        Z(i) = 50; %%assign to class E
    end
end
figure(2);
scatter(classC(1,:), classC(2,:));
hold on;
scatter(classD(1,:),classD(2,:));
hold on;
scatter(classE(1,:),classE(2,:));
hold on;
contour(X,Y,Z,10:90,'r');

