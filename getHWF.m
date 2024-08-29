function HWF=getHWF(filename)
% getHWF - 汇总批量处理的HWF数据
% 
% 
%   HWF=getHWF(filename)
%
% Inputs:
%   filename - 工作路径，包含保存各次扫描数据的文件夹
%   
%
% Outputs:
%   HWF    - HWF数据汇总，用于筛选有效IMF
%
% Notes:
%   目前对于IMF筛选没有明确的指标，我们参考以往研究选取HWF中心频率在
%   [0.01,0.12]Hz范围内的IMF进行功能连接分析（0.12这个地方怎么说？？）

list=dir(filename);
sl=size(list,1);
for i=3:sl
    names=list(i).name;
    namel=[filename,'\',names];
    shujuname=[namel,'\',names,'.mat'];
    load(shujuname,'eHWF');
    HWF(:,:,i-2)=eHWF;
end
end