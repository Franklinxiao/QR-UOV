function result = poly_mult_gf(a, b, q)
% POLY_MULT_GF 有限域上的多项式乘法
%   输入：
%       a, b - 降幂系数向量
%       q    - 有限域阶数
%   输出：
%       result - 降幂系数向量

    % 转换为升幂
    a_rev = flip(a);
    b_rev = flip(b);
    
    % 卷积
    c_rev = conv(a_rev, b_rev);
    
    % 系数模 q
    c_rev = mod(c_rev, q);
    
    % 转回降幂
    result = flip(c_rev);
    
    % 去除前导零
    result = trim_poly(result);
end

