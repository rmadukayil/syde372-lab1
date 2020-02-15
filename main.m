
%% Initialize Variables
clear all;
close all;
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

% Posterior class probabilities
global postA postB postC postD postE;
postA = nA/(nA+nB);
postB = nB/(nA+nB);
postC = nC/(nC+nD+nE);
postD = nD/(nC+nD+nE);
postE = nE/(nC+nD+nE);

% Generating clusters
global classA classB classC classD classE classes;
classA = plotClusters(covA, meanA, nA);
classB = plotClusters(covB, meanB, nB);
classC = plotClusters(covC, meanC, nC);
classD = plotClusters(covD, meanD, nD);
classE = plotClusters(covE, meanE, nE);
classes = [classA, classB, classC, classD, classE];

% Generating test data sets for later NN/KNN analysis
global classA_test classB_test classC_test classD_test classE_test class_tests;
classA_test = plotClusters(covA, meanA, nA);
classB_test = plotClusters(covB, meanB, nB);
classC_test = plotClusters(covC, meanC, nC);
classD_test = plotClusters(covD, meanD, nD);
classE_test = plotClusters(covE, meanE, nE);
class_tests = [classA_test, classB_test, classC_test, classD_test, classE_test];

% Creating grid size that allows display of maximum and minimum test/training data points
arr_x_AB = horzcat(classA(1,:),classB(1,:),classA_test(1,:),classB_test(1,:));
arr_y_AB = horzcat(classA(2,:),classB(2,:),classA_test(2,:),classB_test(2,:));
arr_x_CDE = horzcat(classC(1,:),classD(1,:),classE(1,:),classC_test(1,:),classD_test(1,:),classE_test(1,:));
arr_y_CDE = horzcat(classC(2,:),classD(2,:),classE(2,:),classC_test(2,:),classD_test(2,:),classE_test(2,:));
global_min_AB = floor(min(min(arr_x_AB,arr_y_AB)))-1;
global_max_AB = ceil(max(max(arr_x_AB,arr_y_AB)))+1;
x1 = global_min_AB:0.1:global_max_AB;
[X1, Y1] = ndgrid(x1); 
global_min_CDE = floor(min(min(arr_x_CDE,arr_y_CDE )))-1;
global_max_CDE = ceil(max(max(arr_x_CDE,arr_y_CDE )))+1;
x2 = global_min_CDE:0.1:global_max_CDE;
[X2, Y2] = ndgrid(x2);

%% Find Unit Standard Deviation Contours
sd_A = sd_contour(X1, Y1, meanA, covA);
sd_B = sd_contour(X1, Y1, meanB, covB);
sd_C = sd_contour(X2,Y2,meanC,covC);
sd_D = sd_contour(X2,Y2,meanD,covD);
sd_E = sd_contour(X2,Y2,meanE,covE);

%% Plot clusters
%Plot A and B Clusters
figure(1);
scatter(classA(1,:), classA(2,:));
hold on;
scatter(classB(1,:),classB(2,:));
hold on;
contour(X1,Y1,sd_A,1,'g');
contour(X1,Y1,sd_B,1,'g');
title('Classes A and B');
xlabel('x1');
ylabel('x2');
legend('Class A','Class B');

%Plot C,D and E Clusters
figure(2);
scatter(classC(1,:), classC(2,:));
hold on;
scatter(classD(1,:),classD(2,:));
hold on;
scatter(classE(1,:),classE(2,:));
hold on;
contour(X2,Y2,sd_C,1,'g');
contour(X2,Y2,sd_D,1,'g');
contour(X2,Y2,sd_E,1,'g');
title('Classes C, D, and E');
xlabel('x1');
ylabel('x2');
legend('Class C','Class D','Class E');
%% MAP/MED/GED
%contour plot for MAP,MED,GED classifiers, both cases
[MAP_Z1, MAP_Z2] = MAP_classifier(X1, Y1, X2, Y2);
[MED_Z1, MED_Z2] = MED_classifier(X1, Y1, X2, Y2);
[GED_Z1, GED_Z2] = GED_classifier(X1, Y1, X2, Y2);

%plotting
%AB case
figure(3);
scatter(classA(1,:), classA(2,:));
hold on;
scatter(classB(1,:),classB(2,:));
hold on;
contour(X1,Y1,MAP_Z1,1, 'r'); %MAP contour is red
contour(X1,Y1,MED_Z1,1, 'b'); %MED contour is blue
contour(X1,Y1,GED_Z1,1, 'k'); %GED contour is black
contour(X1,Y1,sd_A,1,'g');
contour(X1,Y1,sd_B,1,'g');
title('MAP/MED/GED for Classes A and B');
xlabel('x1');
ylabel('x2');
legend('Class A','Class B','MAP', 'MED', 'GED');

%CDE case
figure(4);
scatter(classC(1,:), classC(2,:));
hold on;
scatter(classD(1,:),classD(2,:));
hold on;
scatter(classE(1,:),classE(2,:));
hold on;
title('Classes C, D, and E');
legend('Class C','Class D','Class E');
contour(X2,Y2,MAP_Z2,[5,50,100],'r'); %MAP contour is red
contour(X2,Y2,MED_Z2,[5,50,100], 'b'); %MED contour is blue
contour(X2,Y2,GED_Z2,[5,50,100], 'k'); %GED contour is black
contour(X2,Y2,sd_C,1,'g');
contour(X2,Y2,sd_D,1,'g');
contour(X2,Y2,sd_E,1,'g');
xlabel('x1');
ylabel('x2');
title('MAP/MED/GED for Classes C, D and E');
legend('Class C','Class D','Class E','MAP', 'MED', 'GED');

%Confusion matrices and experimental error rate for MAP
[MAP_AB_confusion, MAP_CDE_confusion] = MAP_error_analysis( );
MAP_AB_error = 1-(trace(MAP_AB_confusion)/(nA+nB)); %Case 1 experimental rate
MAP_CDE_error =1-(trace(MAP_CDE_confusion)/(nC+nD+nE)); %Case 2 experimental rate

%Confusion matrices and experimental error rate for MED
[MED_AB_confusion, MED_CDE_confusion] = MED_error_analysis( );
MED_AB_error = 1-(trace(MED_AB_confusion)/(nA+nB)); %Case 1 experimental rate
MED_CDE_error = 1-(trace(MED_CDE_confusion)/(nC+nD+nE)); %Case 2 experimental rate

%Confusion matrices and experimental error rate for GED
[GED_AB_confusion, GED_CDE_confusion] = GED_error_analysis( );
GED_AB_error = 1-(trace(GED_AB_confusion)/(nA+nB)); %Case 1 experimental rate
GED_CDE_error = 1-(trace(GED_CDE_confusion)/(nC+nD+nE)); %Case 2 experimental rate

%% NN/KNN
[NN_Z1, NN_Z2] = NN_classifier(X1, Y1, X2, Y2);
[KNN_Z1, KNN_Z2] = knn_classifier(X1, Y1, X2, Y2);

%plotting
%AB case
figure(5);
scatter(classA(1,:), classA(2,:));
hold on;
scatter(classB(1,:),classB(2,:));
hold on;
contour(X1,Y1,NN_Z1,1, 'r'); %NN contour is red
contour(X1,Y1,KNN_Z1,1, 'b') %KNN contour is blue
contour(X1,Y1,sd_A,1,'g');
contour(X1,Y1,sd_B,1,'g');
title('NN/kNN for Classes A and B');
xlabel('x1');
ylabel('x2');
legend('Class A','Class B','NN', 'kNN');

%CDE case
figure(6);
scatter(classC(1,:), classC(2,:));
hold on;
scatter(classD(1,:),classD(2,:));
hold on;
scatter(classE(1,:),classE(2,:));
hold on;
contour(X2,Y2,NN_Z2,[5,50,100],'r'); %NN contour is red
contour(X2,Y2,KNN_Z2,[5,50,100],'b'); %KNN contour is blue
contour(X2,Y2,sd_C,1,'g');
contour(X2,Y2,sd_D,1,'g');
contour(X2,Y2,sd_E,1,'g');
title('NN/kNN for Classes C, D and E');
xlabel('x1');
ylabel('x2');
legend('Class C','Class D','Class E','NN', 'kNN');

% Performing error analysis with confusion matrices
[NN_AB_confusion,NN_CDE_confusion]=NN_error_analysis(X1,X2,Y1,Y2,NN_Z1,NN_Z2);
[KNN_AB_confusion,KNN_CDE_confusion]=KNN_error_analysis(X1,X2,Y1,Y2,KNN_Z1,KNN_Z2);

%Plot confusion matrix AB for NN
figure(7);
label = {'Class A','Class B'};
label = categorical(label);
NN_AB = confusionchart(NN_AB_confusion,label);
cm_matrix_AB = NN_AB.NormalizedValues;
title('NN Confusion Matrix for Classes A and B');

%Plot confusion matrix AB for kNN
figure(8);
label = {'Class A','Class B'};
label = categorical(label);
KNN_AB = confusionchart(KNN_AB_confusion,label); 
cm_matrix_AB_KNN = KNN_AB.NormalizedValues;
title('kNN Confusion Matrix for Classes A and B');

%NN Experimental Error Rate for AB
NN_AB_error = (cm_matrix_AB(2,1)+ cm_matrix_AB(1,2))/(nA + nB);

%KNN Experimental Error Rate for AB
KNN_AB_error =(cm_matrix_AB_KNN(2,1) + cm_matrix_AB_KNN(1,2))/(nA + nB);

%Plot confusion matrix CDE for NN
figure(9);
label = {'Class C','Class D','Class E'};
label = categorical(label);
NN_CDE = confusionchart(NN_CDE_confusion,label);
cm_matrix_CDE = NN_CDE.NormalizedValues;
title('NN Confusion Matrix for Classes C, D and E');

%Plot confusion matrix CDE for KNN
figure(10);
label = {'Class C','Class D','Class E'};
label = categorical(label);
KNN_CDE = confusionchart(KNN_CDE_confusion,label);
cm_matrix_CDE_KNN = KNN_CDE.NormalizedValues;
title('kNN Confusion Matrix for Classes C, D and E');

%NN Experimental Error Rate for CDE
NN_CDE_error = (cm_matrix_CDE(2,1)+ cm_matrix_CDE(3,1)+ cm_matrix_CDE(1,2)+cm_matrix_CDE(3,2)+cm_matrix_CDE(1,3)+cm_matrix_CDE(2,3))/(100+200+150);

%kNN Experimental Error Rate for CDE
KNN_CDE_error = (cm_matrix_CDE_KNN(2,1)+ cm_matrix_CDE_KNN(3,1)+ cm_matrix_CDE_KNN(1,2)+cm_matrix_CDE_KNN(3,2)+cm_matrix_CDE_KNN(1,3)+cm_matrix_CDE_KNN(2,3))/(nC+nD+nE);
