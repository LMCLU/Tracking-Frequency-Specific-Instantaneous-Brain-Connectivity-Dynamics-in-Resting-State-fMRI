%处理批量数据，每次扫描分文件保存
list=dir(filename);
sl=size(list,1);
for i=3:sl
    names=list(i).name;
    namel=[filename,'\',names];
    listl=dir(namel);
    namew=listl(3).name;
    spm_name=[namel,'\',namew];
    [eHWF,eimf,ephase,ecos]=fchu(spm_name,naomoban,nbrain,ftime);
    shujuname=[namel,'\',names,'.mat'];
    save(shujuname,'eimf','ephase','ecos','eHWF');
end

HWF=getHWF(pwd);
%计算IMF中心频率
for i=1:size(HWF,2)
    hwf=reshape(temp,[1,246*size(HWF,3)]);
    fc(i)=mean(hwf);
end

index=fc<0.12&&fc>0.01;

%根据中心频率选择有效IMF计算功能连接矩阵并划分特征连接模式
