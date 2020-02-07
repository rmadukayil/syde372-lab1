clear all;
close all;

classA = csvread('classA');
classB = csvread('classB');
classC = csvread('classC');
classD = csvread('classD');
classE = csvread('classE');

% Class A, B
x = -2:0.1:22;
y = -2:0.1:22;
[X,Y] = ndgrid(x);
Z = zeros(size(X));
for i=1:numel(X)	
    distanceA = sqrt((classA(1,:)-X(i)).^2 + (classA(2,:)-Y(i)).^2); 
	distanceB = sqrt((classB(1,:)-X(i)).^2 + (classB(2,:)-Y(i)).^2);
	sortedA = sort(distanceA); % sort from lowest to highest
	sortedB = sort(distanceB);

    kMeanA = mean(sortedA(1:5)); % take 5 lowest values and average them
    kMeanB = mean(sortedB(1:5));

    if kMeanA>kMeanB
        Z(i) = 10;
    else
        Z(i) = 1;
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
    distanceC = sqrt((classC(1,:)-X(i)).^2 + (classC(2,:)-Y(i)).^2); 
	distanceD = sqrt((classD(1,:)-X(i)).^2 + (classD(2,:)-Y(i)).^2);
	distanceE = sqrt((classE(1,:)-X(i)).^2 + (classE(2,:)-Y(i)).^2);

	sortedC = sort(distanceC); % sort from lowest to highest
	sortedD = sort(distanceD);
	sortedE = sort(distanceE);

	kMeanC = mean(sortedC(1:5)); % take 5 lowest values and average them
    kMeanD = mean(sortedD(1:5));
	kMeanE = mean(sortedE(1:5));

    if kMeanC > kMeanD && kMeanC > kMeanE
        Z(i) = 50;
    elseif kMeanD > kMeanC && kMeanD > kMeanE
        Z(i) = 100;
    elseif kMeanE > kMeanC && kMeanE > kMeanD
        Z(i) = 0;
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
