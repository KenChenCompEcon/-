% load the data
data=csvread('D:\Dissertation\Data2\appended(97-06).csv',1,0);
for i=1:10
    I=find(data(:,10)==i);
    data1{i}=data(I,:);
end
a=0;
for i=1:18
    for j=1:7
        a=a+1;
        group(1,a)=i*100+j;
    end
end
a=0;
for i=group
    for j=1:10
        a=a+1;
        I=find(data1{1,j}(:,11)==i);
        A=data1{1,j}(I,:);
        INE(a,1)=i;
        INE(a,2)=j;
        if size(A,1)>1;
            INE(a,3)=ginicoeff(ones(size(A,1),1),A(:,14));
            INE(a,4)=theilt(A(:,14));
        else
            INE(a,3)=0;
            INE(a,4)=0;
        end
    end
end
theil=csvread('D:/Dissertation/Data2/Theil.csv',1,0);