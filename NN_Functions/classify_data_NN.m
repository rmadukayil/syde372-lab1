function classified_data_KNN = classify_data_KNN(class_test, X, Y, Z)
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
    classified_data_KNN = data_mapped;
end
