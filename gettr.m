function tr=gettr(nimf)
% gettr - 汇总功能连接矩阵并提取下三角元素
% 
% 
%   tr=gettr(nimf)
%
% Inputs:
%   nimf 需要提取的IMF编号
%   
%
% Outputs:
%   tr    - 汇总的功能连接矩阵下三角元素
%
% Notes:
%   用于后续的对连接矩阵通过机器学习算法划分特征脑连接模式

list=dir(pdw);
sl=size(list,1);

names=list(3).name;
namel=[filename,'\',names];

load(namel,'ecos');
si1=size(ecos,3);
sj1=size(ecos,1);
n1=si1*(sl-2);
n2=sj1*(sj1-1)/2;
tr=zeros(n1,n2);
for k=3:sl
    names=list(k).name;
    namel=[filename,'\',names];

    load(namel,'ecos');
    si=size(ecos,3);
    sj=size(ecos,1);
    ui=k-3;
    for i=1:si
        t=1;
        for j=2:sj
            for u=1:(j-1)
                tr(i+190*ui,t)=ecos(j,u,i,nimf);
                t=t+1;
            end
        end
    end
end
end