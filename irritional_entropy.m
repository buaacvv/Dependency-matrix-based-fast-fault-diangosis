function [entropy] = irritional_entropy(matrix)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
pos1=abs(sin(find(matrix==1)));
pos2=abs(sin(find(matrix==0)));
if ((sum(pos1)==0) || (sum(pos2)==0))
    entropy=0+matrix(1);
else
    p0=sum(pos1)/(sum(pos1)+sum(pos2));
    p1=sum(pos2)/(sum(pos1)+sum(pos2));
    entropy=-p0*log(p0)-p1*log(p1)+matrix(1);
end
end

