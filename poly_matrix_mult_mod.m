function C = poly_matrix_mult_mod_fixed(A, B, g, q, l)
% POLY_MATRIX_MULT_MOD_FIXED 多项式矩阵乘法（输出统一长度）
%   输入：
%       A - v×v 的多项式矩阵，每个元素是降幂系数向量
%       B - v×m 的多项式矩阵，每个元素是降幂系数向量
%       g - 模多项式（降幂系数向量）
%       q - 有限域阶数
%       l - 统一输出长度（最高次数+1），默认为 deg(g)
%   输出：
%       C - v×m 的多项式矩阵，每个元素长度为 l（降幂表示）

    if nargin < 5
        l = length(g);  % 默认使用模多项式的长度
    end
    
    [v, ~] = size(A);
    [~, m] = size(B);
    
    % 初始化结果矩阵
    C = cell(v, m);
    
    for i = 1:v
        for j = 1:m
            % 计算乘积和模
            sum_poly = [0];
            
            for k = 1:v
                a_poly = A{i,k};
                b_poly = B{k,j};
                
                if ~isempty(a_poly) && ~isempty(b_poly) && ...
                   ~(length(a_poly) == 1 && a_poly == 0)
                    prod_poly = poly_mult_gf(a_poly, b_poly, q);
                    prod_poly_mod = poly_mod_gf(prod_poly, g, q);
                    sum_poly = poly_add_gf(sum_poly, prod_poly_mod, q);
                end
            end
            
            % 最终取模
            sum_poly = poly_mod_gf(sum_poly, g, q);
            
            % 统一长度
            C{i,j} = fix_poly_length(sum_poly, l);
        end
    end
end

function poly_fixed = fix_poly_length(poly, target_len)
% FIX_POLY_LENGTH 将多项式统一到指定长度（降幂表示）
%   输入：
%       poly       - 降幂系数向量（可变长度）
%       target_len - 目标长度（最高次数+1）
%   输出：
%       poly_fixed - 长度为 target_len 的降幂系数向量

    % 去除前导零
    poly = trim_poly(poly);
    
    current_len = length(poly);
    
    if current_len >= target_len
        % 如果当前长度超过目标，截断高次项（取模后不应发生）
        poly_fixed = poly(1:target_len);
    else
        % 如果当前长度不足，前面补零
        poly_fixed = [zeros(1, target_len - current_len), poly];
    end
end