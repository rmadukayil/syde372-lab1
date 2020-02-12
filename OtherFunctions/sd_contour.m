function Z_unit = sd_contour(X,Y,mean,cov)

Z_unit = zeros(size(X));

for i=1:numel(X)
    x = ([X(i) Y(i)]' - mean)'*inv(cov)*([X(i) Y(i)]' - mean);
    if x>1
        Z_unit(i) = 5;
    end
end

% figure(1);
% contour(X1,Y1,Z_a,1);
% hold on;
% contour(X1,Y1,Z_b,1);
% hold on;
% scatter(classA(1,:), classA(2,:));
% hold on;
% scatter(classB(1,:),classB(2,:));
% 
% figure(2);
% contour(X2,Y2,Z_c,1);
% hold on;
% contour(X2,Y2,Z_d,1);
% hold on;
% contour(X2,Y2,Z_e,1);
% hold on;
% scatter(classC(1,:), classC(2,:));
% hold on;
% scatter(classD(1,:),classD(2,:));
% hold on;
% scatter(classE(1,:),classE(2,:));
end