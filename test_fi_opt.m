function [ind] = test_fi_opt(indx,test_opt_d)
%在检测用测试点基础上，选择重复的隔离用测试点
%   此处显示详细说明
    ind=indx(1);
    for i=length(test_opt_d):-1:1
        if ismember(test_opt_d(i),indx)
            ind=test_opt_d(i);
            break;
        end
    end
end

