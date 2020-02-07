
%% Importing all files and plotting them
clear all;
classA = csvread('classA');
classB = csvread('classB');
classC = csvread('classC');
classD = csvread('classD');
classE = csvread('classE');
figure(1);
scatter(classA(1,:), classA(2,:));
hold on;
scatter(classB(1,:),classB(2,:));

figure(2);
scatter(classC(1,:), classC(2,:));
hold on;
scatter(classD(1,:),classD(2,:));
hold on;
scatter(classE(1,:),classE(2,:));

%% Find the unit standard deviation plot for A/B
meanA = [5 10]';
meanB = [10 15]'; 
meanC = [5 10]';
meanD = [15 10]';
meanE = [10 5]';
covA = [8 0; 0 4];
covB = [8 0; 0 4];
covC = [8 4; 4 40];
covD = [8 0; 0 8];
covE = [10 -5; -5 20];
x1 = -2:0.1:22;
x2 =  -5:0.1:25;
[X1,Y1] = ndgrid(x1);
[X2,Y2] = ndgrid(x2);
Z_a = zeros(size(X1));
Z_b = zeros(size(X1));
Z_c = zeros(size(X2));
Z_d = zeros(size(X2));
Z_e = zeros(size(X2));

for i=1:numel(X1)
    x_a = ([X1(i) Y1(i)]' - meanA)'*inv(covA)*([X1(i) Y1(i)]' - meanA);
    x_b = ([X1(i) Y1(i)]' - meanB)'*inv(covB)*([X1(i) Y1(i)]' - meanB);
    if x_a>1
        Z_a(i) = 5;
    end
    if x_b>1
        Z_b(i) = 5;
    end
end

for i=1:numel(X2)
    x_c = ([X2(i) Y2(i)]' - meanC)'*inv(covC)*([X2(i) Y2(i)]' - meanC);
    x_d = ([X2(i) Y2(i)]' - meanD)'*inv(covD)*([X2(i) Y2(i)]' - meanD);
    x_e = ([X2(i) Y2(i)]' - meanE)'*inv(covE)*([X2(i) Y2(i)]' - meanE);
    if x_c>1
        Z_c(i) = 5;
    end
    if x_d>1
        Z_d(i) = 5;
    end
    if x_e>1
        Z_e(i) = 5;
    end
end

figure(1);
contour(X1,Y1,Z_a,1);
hold on;
contour(X1,Y1,Z_b,1);
hold on;
scatter(classA(1,:), classA(2,:));
hold on;
scatter(classB(1,:),classB(2,:));

figure(2);
contour(X2,Y2,Z_c,1);
hold on;
contour(X2,Y2,Z_d,1);
hold on;
contour(X2,Y2,Z_e,1);
hold on;
scatter(classC(1,:), classC(2,:));
hold on;
scatter(classD(1,:),classD(2,:));
hold on;
scatter(classE(1,:),classE(2,:));
%% Try something else for A and B
x = -2:0.1:22;
y = -2:0.1:22;
[X1,Y1] = ndgrid(x);
Z1 = zeros(size(X1));
for i=1:numel(X1)
    min_classA = min(sqrt((classA(1,:)-X1(i)).^2 + (classA(2,:)-Y1(i)).^2));
    min_classB = min(sqrt((classB(1,:)-X1(i)).^2 + (classB(2,:)-Y1(i)).^2));
    if min_classA>min_classB
        Z1(i) = 10;
    else
        Z1(i) = 1;
    end
end
contour(X1,Y1,Z1,1);
hold on;
scatter(classA(1,:), classA(2,:));
hold on;
scatter(classB(1,:),classB(2,:));
%% Find NN for all points of linspace (of class C,D and E)
x = -5:0.1:25;
y = -5:0.1:25;
[X2,Y2] = ndgrid(x);
Z2 = zeros(size(X2));
for i=1:numel(X2)
    min_classC = min(sqrt((classC(1,:)-X2(i)).^2 + (classC(2,:)-Y2(i)).^2));
    min_classD = min(sqrt((classD(1,:)-X2(i)).^2 + (classD(2,:)-Y2(i)).^2));
    min_classE = min(sqrt((classE(1,:)-X2(i)).^2 + (classE(2,:)-Y2(i)).^2));
    if min_classC < min_classD && min_classC < min_classE
        Z2(i) = 50;
    elseif min_classD < min_classC && min_classD < min_classE
        Z2(i) = 100;
    elseif min_classE < min_classC && min_classE < min_classD
        Z2(i) = 0;
    end
end
colormap(gray);
contour(X2,Y2,Z2,10:90);
hold on;
%surf(X,Y,Z);
%hold on;
%contour(X,Y,Z,10:90);
%hold on;
scatter(classC(1,:), classC(2,:));
hold on;
scatter(classD(1,:),classD(2,:));
hold on;
scatter(classE(1,:),classE(2,:));
%% Find Error for class A,B ; C,D,E
classA_test = csvread('classA_test');
classB_test = csvread('classB_test');

classC_test = csvread('classC_test');
classD_test = csvread('classD_test');
classE_test = csvread('classE_test');

classA_data_mapped = classify_data(classA_test, X1, Y1, Z1);
classB_data_mapped = classify_data(classB_test, X1, Y1, Z1);

classC_data_mapped = classify_data(classC_test, X2, Y2, Z2);
classD_data_mapped = classify_data(classD_test, X2, Y2, Z2);
classE_data_mapped = classify_data(classE_test, X2, Y2, Z2);

C = confusionmat([zeros(1,size(classA_test,2))+1 zeros(1,size(classB_test,2))+10] ,[classA_data_mapped(3,:) classB_data_mapped(3,:)],'Order',[1,10]);
figure(1);
label = {'Class A','Class B'};
label = categorical(label);
cm_AB = confusionchart(C,label);
cm_matrix = cm_AB.NormalizedValues;
probability_of_error_AB = (cm_matrix(2,1)+ cm_matrix(1,2))/(200+200)

C = confusionmat([zeros(1,size(classC_test,2))+50 zeros(1,size(classD_test,2))+100 zeros(1,size(classE_test,2))] ,[classC_data_mapped(3,:) classD_data_mapped(3,:) classE_data_mapped(3,:)],'Order',[50,100,0]);
figure(2);
label = {'Class C','Class D','Class E'};
label = categorical(label);
cm_CDE = confusionchart(C,label);
cm_matrix = cm_CDE.NormalizedValues;
probability_of_error_CDE = (cm_matrix(2,1)+ cm_matrix(3,1)+ cm_matrix(1,2)+cm_matrix(3,2)+cm_matrix(1,3)+cm_matrix(2,3))/(100+200+150)



function classified_data = classify_data(class_test, X, Y, Z)
    X_transform = X(:);
    Y_transform = Y(:);
    Z_transform = Z(:);
    data_mapped = zeros(3,size(class_test,2));
    for col = 1:size(class_test,2)
        distances = sqrt((X_transform-(class_test(1,col))).^2 + (Y_transform-class_test(2,col)).^2);
        row =  find(distances == min(distances));
        data_mapped(1,col) = X_transform(row(1,1),1);
        data_mapped(2,col) = Y_transform(row(1,1),1);
        data_mapped(3,col) = Z_transform(row(1,1),1);
    end
    classified_data = data_mapped;
end
