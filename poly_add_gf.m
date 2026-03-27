
function result = poly_add_gf(a, b, q)
% POLY_ADD_GF 有限域上的多项式加法
%   输入：
%       a, b - 降幂系数向量
%       q    - 有限域阶数
%   输出：
%       result - 降幂系数向量

    a = trim_poly(a);
    b = trim_poly(b);
    
    if isempty(a) || (length(a) == 1 && a == 0)
        result = b;
        return;
    end
    
    if isempty(b) || (length(b) == 1 && b == 0)
        result = a;
        return;
    end
    
    % 对齐长度
    len_a = length(a);
    len_b = length(b);
    
    if len_a >= len_b
        result = a;
        result(end-len_b+1:end) = mod(result(end-len_b+1:end) + b, q);
    else
        result = b;
        result(end-len_a+1:end) = mod(result(end-len_a+1:end) + a, q);
    end
    
    result = trim_poly(result);
end