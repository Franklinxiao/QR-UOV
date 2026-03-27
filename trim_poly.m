function poly = trim_poly(poly)
% TRIM_POLY 去除多项式的高次零系数
%   输入：
%       poly - 降幂系数向量
%   输出：
%       poly - 去除前导零后的多项式

    if isempty(poly)
        poly = 0;
        return;
    end
    
    % 找到第一个非零系数
    idx = find(poly ~= 0, 1);
    
    if isempty(idx)
        poly = 0;
    else
        poly = poly(idx:end);
    end
end
