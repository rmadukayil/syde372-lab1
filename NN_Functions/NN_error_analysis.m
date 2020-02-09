function [case1_confusion, case2_confusion] = NN_error_analysis(X1,X2,Y1,Y2,Z1,Z2)
    global classA_test classB_test classC_test classD_test classE_test class_tests;
    
classA_data_mapped = classify_data_NN(classA_test, X1, Y1, Z1);
classB_data_mapped = classify_data_NN(classB_test, X1, Y1, Z1);
classC_data_mapped = classify_data_NN(classC_test, X2, Y2, Z2);
classD_data_mapped = classify_data_NN(classD_test, X2, Y2, Z2);
classE_data_mapped = classify_data_NN(classE_test, X2, Y2, Z2);

case1_confusion = confusionmat([zeros(1,size(classA_test,2))+1 zeros(1,size(classB_test,2))+10] ,[classA_data_mapped(3,:) classB_data_mapped(3,:)],'Order',[1,10]);
case2_confusion = confusionmat([zeros(1,size(classC_test,2))+100 zeros(1,size(classD_test,2))+5 zeros(1,size(classE_test,2))+50] ,[classC_data_mapped(3,:) classD_data_mapped(3,:) classE_data_mapped(3,:)],'Order',[100,5,50]);

end