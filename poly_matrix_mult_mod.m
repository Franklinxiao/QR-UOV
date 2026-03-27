function C = poly_matrix_mult_mod(A, B, g, q)
     [v1, v2] = size(A);
    [v3, m] = size(B);
    
    if  v2  ~= v3
        error('矩阵维度不匹配');
    end
    
    v = v1;
    
    % 初始化结果矩阵
    C = cell(v, m);
    
    % 矩阵乘法
    for i = 1:v
        for j = 1:m
            % 计算 C(i,j) = sum_{k=1}^{v} A(i,k) * B(k,j) mod g
            sum_poly = [0];  % 初始化为零多项式（降幂表示）
            
            for k = 1:v
                % 获取两个多项式
                a_poly = A{i,k};
                b_poly = B{k,j};
                
                % 计算乘积
                if ~isempty(a_poly) && ~isempty(b_poly) && ~(length(a_poly) == 1 && a_poly == 0)
                    prod_poly = poly_mult_gf(a_poly, b_poly, q);
                    
                    % 模 g 约化
                    prod_poly_mod = poly_mod_gf(prod_poly, g, q);
                    
                    % 累加
                    sum_poly = poly_add_gf(sum_poly, prod_poly_mod, q);
                end
            end
            
            % 最终结果再模一次 g（确保次数小于 deg(g)）
            C{i,j} = poly_mod_gf(sum_poly, g, q);
            
            % 去除前导零（可选）
            C{i,j} = trim_poly(C{i,j});
        end
    end
end

