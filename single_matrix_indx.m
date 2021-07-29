function [index] = single_matrix_indx(matrix)

if (size(matrix,1)==1)
    index=zeros(1,size(matrix,2));
    
else
    len=size(matrix,2);
    num=zeros(2,len);
    for i=1:len
        num(:,i)=[length(find(matrix(:,i)==0));length(find(matrix(:,i)==1))];
    end
    index=num(1,:).*num(2,:);
end
end

