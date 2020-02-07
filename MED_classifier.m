clear all;
close all;

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

%% for A and B
%%compare x and y distances to mean of class A and class B
%%smallest distance wins!
x = -2:0.1:22;
y = -2:0.1:22;
[X,Y] = ndgrid(x);
Z = zeros(size(X));
for i=1:numel(X)
    dist_classA = sqrt((meanA(1)-X(i)).^2 + (meanA(2)-Y(i)).^2);
    dist_classB = sqrt((meanB(1)-X(i)).^2 + (meanB(2)-Y(i)).^2);
    if dist_classA < dist_classB
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
for i=1:numel(X)
    dist_classC = sqrt((meanC(1)-X(i)).^2 + (meanC(2)-Y(i)).^2);
    dist_classD = sqrt((meanD(1)-X(i)).^2 + (meanD(2)-Y(i)).^2);
    dist_classE = sqrt((meanE(1)-X(i)).^2 + (meanE(2)-Y(i)).^2);
    
    if dist_classC < dist_classD && dist_classC < dist_classE
        Z(i) = 100; %%assign to class C
    elseif dist_classD < dist_classC && dist_classD < dist_classE
        Z(i) = 5; %%assign to class D
    elseif dist_classE < dist_classC && dist_classE < dist_classD
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
contour(X,Y,Z,10:90);

