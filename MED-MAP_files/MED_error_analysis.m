function [case1_confusion, case2_confusion] = MED_error_analysis( )
    global classA classB classC classD classE classes;
    global nA nB nC nD nE sizes;
    global meanA meanB meanC meanD meanE means;
    global covA covB covC covD covE covs;
    global postA postB postC postD postE;
    success_A = 0;
    success_B = 0; 
    success_C = 0;
    success_D = 0; 
    success_E = 0;
    fail_AB = 0;
    fail_BA = 0;
    fail_CD = 0;
    fail_CE = 0;
    fail_DC = 0;
    fail_DE = 0;
    fail_EC = 0;
    fail_ED = 0;
    
    for i=1:nA
        x = classA(:,i);
        AcloserB = MED(meanA, meanB, x);
        if AcloserB
            success_A = success_A+1;
        else
            fail_AB = fail_AB + 1;
        end
    end
    for i=1:nB
        x = classB(:,i);
        AcloserB = MED(meanA, meanB, x);
        if AcloserB
            fail_BA = fail_BA+1;
        else
            success_B = success_B + 1;
        end
    end
    for i=1: nC
        x = classC(:,i);
        CcloserD = MED(meanC, meanD, x);%%boolean
        CcloserE = MED(meanC, meanE, x);
        DcloserE = MED(meanD, meanE, x);
        if CcloserD && CcloserE
            success_C = success_C+1;
        elseif ~CcloserD && DcloserE
            fail_CD = fail_CD + 1; %%C sample wrongly assigned to class D
        elseif ~CcloserE && ~DcloserE
            fail_CE = fail_CE + 1; %%C sample wrongly assigned to class E
        end
    end
    for i=1: nD
        x = classD(:,i);
        CcloserD = MED(meanC, meanD, x);%%boolean
        CcloserE = MED(meanC, meanE, x);
        DcloserE = MED(meanD, meanE, x);
        if CcloserD && CcloserE
            fail_DC = fail_DC +1;%%D sample wrongly assigned to class C
        elseif ~CcloserD && DcloserE
            success_D = success_D + 1; 
        elseif ~CcloserE && ~DcloserE
            fail_DE = fail_DE + 1; %%D sample wrongly assigned to class E
        end
    end
    for i=1: nE
        x = classE(:,i);
        CcloserD = MED(meanC, meanD, x);%%boolean
        CcloserE = MED(meanC, meanE, x);
        DcloserE = MED(meanD, meanE, x);
        if CcloserD && CcloserE
            fail_EC = fail_EC +1;%%E sample wrongly assigned to class C
        elseif ~CcloserD && DcloserE
            fail_ED = fail_ED + 1; %%E sample wrongly assigned to class D 
        elseif ~CcloserE && ~DcloserE
            success_E = success_E + 1; 
        end
    end
    
    case1_confusion = [
        success_A    fail_AB;
        fail_BA      success_B;
        ];
    
    case2_confusion = [
        success_C    fail_CD    fail_CE;
        fail_DC      success_D  fail_DE;
        fail_EC      fail_ED    success_E;
        ];
   
   
end