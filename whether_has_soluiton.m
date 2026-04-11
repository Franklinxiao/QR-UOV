function has_solution = whether_has_soluiton(A,b,q)
    [m, n] = size(A);
    if length(b) ~= m
        error('b的维度必须与A的行数一致');
    end
    
    % 将输入转换为模q下的GF(q)元素（使用符号运算）
    % 注意：MATLAB的gf函数需要Communications Toolbox
    try
        % 方法1：使用Communications Toolbox（如果可用）
        A_gf = gf(A, log2(q));  % 需要q是2的幂
        b_gf = gf(b, log2(q));
        
        % 计算秩
        rank_A = rank(A_gf);
        rank_Aug = rank([A_gf, b_gf]);
        
    catch
        % 方法2：不使用工具箱，手动实现模q运算的秩计算
        rank_A = rank_mod_q(A, q);
        rank_Aug = rank_mod_q([A, b], q);
    end
    
    % 判断是否有解
    has_solution = (rank_A == rank_Aug);
    
%     if has_solution
%         fprintf('方程组有解 (rank(A) = rank([A|b]) = %d)\n', rank_A);
%     else
%         fprintf('方程组无解 (rank(A) = %d, rank([A|b]) = %d)\n', ...
%                 rank_A, rank_Aug);
%     end
end

function r = rank_mod_q(M, q)
% RANK_MOD_Q 计算矩阵在模q下的秩（不使用工具箱）
% 使用高斯消元法在有限域F_q上计算秩

    M = mod(M, q);  % 确保元素在0到q-1之间
    [rows, cols] = size(M);
    r = 0;
    row = 1;
    
    % 对每一列进行消元
    for col = 1:cols
        if row > rows
            break;
        end
        
        % 寻找主元（非零元素）
        pivot_row = find(M(row:rows, col) ~= 0, 1);
        
        if isempty(pivot_row)
            % 当前列全为零，跳过
            continue;
        end
        
        pivot_row = pivot_row + row - 1;
        
        % 交换当前行和主元行
        if pivot_row ~= row
            M([row, pivot_row], :) = M([pivot_row, row], :);
        end
        
        % 将主元归一化为1（求乘法逆元）
        pivot_val = M(row, col);
        if pivot_val ~= 1
            % 计算模q下的乘法逆元
            inv_pivot = mod_inverse(pivot_val, q);
            M(row, :) = mod(M(row, :) * inv_pivot, q);
        end
        
        % 消去其他行
        for i = 1:rows
            if i ~= row && M(i, col) ~= 0
                factor = M(i, col);
                M(i, :) = mod(M(i, :) - factor * M(row, :), q);
            end
        end
        
        r = r + 1;
        row = row + 1;
    end
end

function inv = mod_inverse(a, q)
% MOD_INVERSE 计算a在模q下的乘法逆元（要求a与q互质）
% 对于有限域F_q，当q是素数时，使用费马小定理
% 当q是素数幂时，需要更复杂的计算，这里简化为素数情况
    
    % 简化版本：假设q是素数，使用扩展欧几里得算法
    a = mod(a, q);
    
    % 扩展欧几里得算法
    [~, inv, ~] = extended_gcd(a, q);
    inv = mod(inv, q);
end

function [g, x, y] = extended_gcd(a, b)
% 扩展欧几里得算法：返回gcd(a,b)以及x,y使得a*x + b*y = gcd(a,b)
    if b == 0
        g = a;
        x = 1;
        y = 0;
    else
        [g, y, x] = extended_gcd(b, mod(a, b));
        y = y - floor(a/b) * x;
    end
end

