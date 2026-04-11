function x = quick_solution(A, b, q)
% 最简版本：直接使用高斯消元求一个特解
    
    A = mod(A, q);
    b = mod(b, q);
    
    % 组合成增广矩阵
    Aug = [A, b];
    [m, n] = size(A);
    
    % 高斯消元求上三角
    for col = 1:min(m, n)
        % 找主元
        pivot = find(Aug(col:end, col) ~= 0, 1);
        if isempty(pivot)
            continue;
        end
        pivot = pivot + col - 1;
        
        % 交换行
        if pivot ~= col
            Aug([col, pivot], :) = Aug([pivot, col], :);
        end
        
        % 消去下面行
        for row = col+1:m
            if Aug(row, col) ~= 0
                factor = Aug(row, col) * mod_inverse(Aug(col, col), q);
                Aug(row, :) = mod(Aug(row, :) - factor * Aug(col, :), q);
            end
        end
    end
    
    % 回代求特解（自由变量设为0）
    x = zeros(n, 1);
    for i = min(m, n):-1:1
        if Aug(i, i) ~= 0
            sum_val = 0;
            for j = i+1:n
                sum_val = mod(sum_val + Aug(i, j) * x(j), q);
            end
            x(i) = mod((Aug(i, end) - sum_val) * mod_inverse(Aug(i, i), q), q);
        end
    end
end

function inv = mod_inverse(a, q)
% 模逆元（使用扩展欧几里得）
    a = mod(a, q);
    [~, inv, ~] = extended_gcd(a, q);
    inv = mod(inv, q);
end

function [g, x, y] = extended_gcd(a, b)
    if b == 0
        g = a; x = 1; y = 0;
    else
        [g, y, x] = extended_gcd(b, mod(a, b));
        y = y - floor(a/b) * x;
    end
end