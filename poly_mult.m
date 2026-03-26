function c = poly_mult(a, b)
% POLY_MULT 多项式乘法
%   C = POLY_MULT(A, B) 计算多项式 A(x) 与 B(x) 的乘积。
%   输入 A 和 B 为降幂系数向量，即 A = [a1, a2, ..., al] 对应
%   A(x) = a1*x^(l-1) + a2*x^(l-2) + ... + al。
%   输出 C 为升幂系数向量，即 C = [c0, c1, ..., c_{2l-2}] 对应
%   C(x) = c0 + c1*x + ... + c_{2l-2}*x^(2l-2)。
%
%   示例：
%       a = [1, 2, 3];   % 表示 1*x^2 + 2*x + 3
%       b = [4, 5, 6];   % 表示 4*x^2 + 5*x + 6
%       c = poly_mult(a, b); 
%       % 结果 c = [18, 27, 28, 13, 24] 
%       % 对应 18 + 27*x + 28*x^2 + 13*x^3 + 24*x^4

    % 输入检查
    if length(a) ~= length(b)
        error('输入向量长度必须相等');
    end
    l = length(a);
    
    % 方法1：利用卷积（推荐）
    % 将降幂转换为升幂（常数项在前），卷积后再保持升幂
    a_rev = flip(a);
    b_rev = flip(b);
    c = conv(a_rev, b_rev);   % 升幂系数，长度 2l-1
    
    % 方法2：根据推导公式显式计算（备选，注释掉）
    % c = zeros(1, 2*l-1);
    % for k = 0 : 2*l-2
    %     sum_val = 0;
    %     i_min = max(1, l - k);
    %     i_max = min(l, 2*l - k - 1);
    %     for i = i_min : i_max
    %         j = 2*l - k - i;
    %         sum_val = sum_val + a(i) * b(j);
    %     end
    %     c(k+1) = sum_val;  % 索引 k+1 对应 x^k 系数
    % end
end