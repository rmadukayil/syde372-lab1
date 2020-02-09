clear all;
close all;

global classA classB classC classD classE classes;
classA = csvread('classA');
classB = csvread('classB');
classC = csvread('classC');
classD = csvread('classD');
classE = csvread('classE');
classes = [classA, classB, classC, classD, classE];

% Class sizes
global nA nB nC nD nE sizes;
nA = 200;
nB = 200;
nC = 100;
nD = 200;
nE = 150;
sizes = [nA,nB,nC,nD,nE];

% Class means 
global meanA meanB meanC meanD meanE means;
meanA = [5; 10];
meanB = [10; 15]; 
meanC = [5; 10];
meanD = [15; 10];
meanE = [10; 5];
means = [meanA,meanB,meanC,meanD,meanE];

% Class covariances
global covA covB covC covD covE covs;
covA = [8 0; 0 4];
covB = [8 0; 0 4];
covC = [8 4; 4 40];
covD = [8 0; 0 8];
covE = [10 -5; -5 20];
covs = [covA,covB,covC,covD,covE];

%%posterior class probabilities
global postA postB postC postD postE;
postA = nA/(nA+nB);
postB = nB/(nA+nB);
postC = nC/(nC+nD+nE);
postD = nD/(nC+nD+nE);
postE = nE/(nC+nD+nE);

x1 = -2:0.1:22;
y1 = -2:0.1:22;  %TODO: do we need y1 if it's not used in ndgrid?
[X1, Y1] = ndgrid(x1); 
x2 = -5:0.1:25;
y2 = -5:0.1:25;
[X2, Y2] = ndgrid(x2);

%contour plot for MAP classifier, both cases
[MAP_Z1, MAP_Z2] = MAP_classifier(X1, Y1, X2, Y2);
[MED_Z1, MED_Z2] = MED_classifier(X1, Y1, X2, Y2);

%plotting
%AB case
figure(1);
scatter(classA(1,:), classA(2,:));
hold on;
scatter(classB(1,:),classB(2,:));
hold on;
contour(X1,Y1,MAP_Z1,1, 'r'); %MAP contour is red
contour(X1,Y1,MED_Z1,1, 'b'); %MED contour is blue

%CDE case
figure(2);
scatter(classC(1,:), classC(2,:));
hold on;
scatter(classD(1,:),classD(2,:));
hold on;
scatter(classE(1,:),classE(2,:));
hold on;
contour(X2,Y2,MAP_Z2,10:90,'r'); %MAP contour is red
contour(X2,Y2,MED_Z2,10:90, 'b'); %MED contour is blue


[MAP_AB_confusion, MAP_CDE_confusion] = MAP_error_analysis( );
MAP_AB_error = trace(MAP_AB_confusion)/(nA+nB); %Case 1 experimental rate
MAP_CDE_error = trace(MAP_CDE_confusion)/(nC+nD+nE); %Case 2 experimental rate

[MED_AB_confusion, MED_CDE_confusion] = MED_error_analysis( );
MED_AB_error = trace(MED_AB_confusion)/(nA+nB); %Case 1 experimental rate
MED_CDE_error = trace(MED_CDE_confusion)/(nC+nD+nE); %Case 2 experimental rate
