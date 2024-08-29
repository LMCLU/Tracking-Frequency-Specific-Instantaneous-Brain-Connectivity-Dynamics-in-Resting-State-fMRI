function [eHWF, eimf, ephase, ecos] = gethilbertfeature(spm_name, Atlase, nbrain, fs)
% gethilbertfeature - 计算单次扫描各脑区fmri信号的HWF, IMF, 瞬时相位,功能连接矩阵
% 
% 
%   [eHWF, eimf, ephase, ecos] = fchu(spm_name, Atlase, nbrain, ftime)
%
% Inputs:
%   spm_name - fMRI图像nii文件名字符串
%   Atlase   - 划分脑区提取数据使用的脑模板
%   nbrain   - 脑膜板脑区数
%   fs       - 采样频率
%
% Outputs:
%   eHWF    - IMF的希尔伯特能量加权频率汇总 （脑区数*IMF数量）
%   eimf    - 原始信号经EMD分解产生的IMF分量
%   ephase  - 各IMF分量的瞬时相位
%   ecos    - 全脑功能连接矩阵
%
% Notes:
%   函数使运行需要安装MATLAB Signal Processing Toolbox和SPM8

% 使用spm函数读取nii文件
s = spm_vol(spm_name);
espm = spm_read_vols(s);
ntime = size(espm, 4);
edata = zeros(nbrain, ntime);

% 提取脑分区数据
for i = 1:nbrain
    for j = 1:ntime
        S = espm(:, :, :, j);
        edata(i, j) = mean(S(Atlase == i));
    end
end

% 对原始信号进行EMD获取IMF分量
e0imf = zeros(ntime, 100, nbrain);
maxc = zeros(1, nbrain);
for i = 1:nbrain
    imf = emd(edata(i, :));
    c = size(imf, 2);
    maxc(1, i) = c;
    for k = 1:c
        e0imf(:, k, i) = imf(:, k);
    end
end
cmax = max(maxc);
eimf = zeros(ntime, cmax, nbrain);
for i = 1:cmax
    eimf(:, i, :) = e0imf(:, i, :);
end

% 计算IMF分量的希尔伯特加权频率
eimfinsf = zeros(ntime, cmax, nbrain);
eimfinse = zeros(ntime, cmax, nbrain);
for i = 1:nbrain
    [~, ~, ~, imfinsf, imfinse] = hht(eimf(:, :, i), 1/fs);
    eimfinsf(:, :, i) = imfinsf;
    eimfinse(:, :, i) = imfinse;
end
eHWF = zeros(nbrain, cmax);
for k = 1:cmax
    for i = 1:nbrain
        F = 0;
        E = 0;
        for j = 1:ntime
            F = F + eimfinsf(j, k, i) * eimfinse(j, k, i);
            E = E + eimfinse(j, k, i);
        end
        eHWF(i, k) = F / E;
    end
end

% 计算各IMF的瞬时相位
ephase = zeros(ntime, cmax, nbrain);
for i = 1:nbrain
    for k = 1:cmax
        z1 = hilbert(eimf(:, k, i));
        ephase(:, k, i) = angle(z1);
    end
end

% 计算脑连接矩阵
ecos = zeros(nbrain, nbrain, ntime, cmax);
for n = 1:cmax
    for i = 1:ntime
        for j = 1:nbrain
            for k = 1:nbrain
                econnect(j, k, i, n) = ephase(i, n, j) - ephase(i, n, k);
                ecos(j, k, i, n) = cos(econnect(j, k, i, n));
            end
            ecos(j, j, i, n) = 0;
        end
    end
end

end