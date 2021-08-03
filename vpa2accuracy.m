clc
clear
rng(1);%for repeatly

digit_start=4;
digit_end=15;
d_leapsize=1;

m_size_start=500;
m_size_end=10000;
mz_leapsize=500;

accuracy_m=zeros((digit_end-digit_start)/d_leapsize+1,(m_size_end-m_size_start)/mz_leapsize+1);

progress=0;

for digit=digit_start:d_leapsize:digit_end
for matrix_size=m_size_start:mz_leapsize:m_size_end
%digit=8;%熵值有效位数
%matrix_size=500;%矩阵规模

d_matrix=randi([0,1],matrix_size,matrix_size);

% d_matrix=[
% 1 1 1 1 1 1;
% 0 1 1 1 1 1;
% 0 0 1 0 1 1;
% 0 0 0 1 0 1;
% 0 0 0 0 0 1;
% 0 0 0 0 1 0
% ];

flag=0;

temp_dm=d_matrix;
fenge_ku={};
flaggie=0;
while(1)
    if (size(temp_dm,1)==1)
        flag=flag+1;
        ind0=find(temp_dm==max(temp_dm));
        test_opt_d(flag)=ind0(1); 
        
        flaggie=flaggie+1;
        fenge_ku{flaggie}=temp_dm;
        break;
    elseif (size(temp_dm,1)==0)
        break;
    end
    wfd=sum(temp_dm,1);
    ind0=find(wfd==max(wfd));
    ind1=find(temp_dm(:,ind0(1))==1);
    ind2=find(temp_dm(:,ind0(1))==0);
    
    sub_m1=temp_dm(ind1,:);
    flaggie=flaggie+1;
    fenge_ku{flaggie}=sub_m1;
    
    sub_m2=temp_dm(ind2,:);
    
    clear temp_dm
    temp_dm=sub_m2;
    flag=flag+1;
    test_opt_d(flag)=ind0(1);
end

%%%去掉无用单独行
ind_fg=[];
k=0;
for i=1:size(fenge_ku,2)
    if (size(fenge_ku{i},1)==1 || size(fenge_ku{i},1)==0)
        k=k+1;
        ind_fg(k)=i;
    end
end
fenge_ku(ind_fg)=[];

chou_d_matrix=[];
for i=1:size(fenge_ku,2)
    chou_d_matrix=[chou_d_matrix;fenge_ku{i}];
end
%%%%

flag=1;
ku{flag}=chou_d_matrix;
while(1)
    ind=[];
    for i=1:(size(ku,2))
        ind(i,:)=single_matrix_indx(ku{i});
    end
    if (sum(ind,'all')==0)
        break;
    end
    indx=test_fi_opt(find(sum(ind,1)==max(sum(ind,1))),test_opt_d);
    test_opt_i(flag)=indx;
    
    temp_ku={};
    for i=1:(size(ku,2))
        temp_d=ku{i};
        sub_m1=temp_d(find(temp_d(:,indx)==1),:);
        sub_m2=temp_d(find(temp_d(:,indx)==0),:);
        temp_ku{2*i-1}=sub_m1;
        temp_ku{2*i}=sub_m2;
    end
    clear ku
    ku=temp_ku;
    flag_del=1;
    ind_del=[];
    for i=1:size(ku,2)
        if (size(ku{i},1)==0)
            ind_del(flag_del)=i;
            flag_del=flag_del+1;
        end
    end
    ku([ind_del])=[];
    flag=flag+1;
end

%[test_opt_d,test_opt_i]
test_sequence=unique([test_opt_d,test_opt_i],'stable');
d_dictionary=d_matrix(:,test_sequence);%%qudiao sort

%%%%创建基于MD5的字典

for i=1:size(d_dictionary,1)
    irra_En{i}=char(vpa(irritional_entropy(d_dictionary(i,:)),digit));
    str_key=mlreportgen.utils.hash(irra_En{i});
    key{i}=['d',char(str_key)];
    dic.(key{i})=i;
end
%%%%验证基于信息熵的算法
tic
for i=1:size(d_dictionary,1)
    sr_en(i)=dic.(['d',char(mlreportgen.utils.hash(irra_En{i}))]);
end
toc

if sum(sr_en-[1:1:size(d_dictionary,1)])==0
    disp('Done_EN!');
    accuracy=1;
else
    accuracy=length(unique(sr_en))/size(d_dictionary,1);
    disp(num2str(accuracy));
end
accuracy_m((digit-digit_start)/d_leapsize+1,...
    (matrix_size-m_size_start)/mz_leapsize+1)=accuracy;

clear ku d_matrix test_sequence test_opt_d test_opt_i sr_en

progress=progress+1;
disp(['Progress:',num2str(progress),'/',num2str(numel(time_stat_en))]);

end
end
[X,Y]=meshgrid(digit_start:d_leapsize:digit_end,m_size_start:mz_leapsize:m_size_end);
mesh(X,Y,accuracy_m');
