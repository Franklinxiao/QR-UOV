function result = poly_mod_gf(poly, g, q)
% POLY_MOD_GF 有限域上的多项式取模
%   输入：
%       poly - 降幂系数向量（被除数）
%       g    - 降幂系数向量（除数）
%       q    - 有限域阶数
%   输出：
%       result - 降幂系数向量（余式）

    % 去除前导零
    poly = trim_poly(poly);
    g = trim_poly(g);
    
    if isempty(poly) || (length(poly) == 1 && poly == 0)
        result = 0;
        return;
    end
    
    if length(poly) < length(g)
        result = poly;
        return;
    end
    
    % 转换为升幂以便计算
    poly_rev = flip(poly);
    g_rev = flip(g);
    
    % 多项式长除法（升幂表示）
    r = poly_rev;
    d = length(g_rev);
    
    while length(r) >= d && ~(length(r) == 1 && r(1) == 0)
        % 当前最高次项系数（升幂表示中末尾）
        lead_r = r(end);
        lead_g = g_rev(end);
        
        if lead_r == 0
            r = r(1:end-1);
            continue;
        end
        
        % 计算商的一项
        lead_g_inv = mod_inv_gf(lead_g, q);
        q_coeff = mod(lead_r * lead_g_inv, q);
        
        % 构造当前项对应的多项式
        k = length(r) - d;
        q_poly = [zeros(1, k), q_coeff];
        
        % 计算乘积并相减
        sub = conv(q_poly, g_rev);
        sub = mod(sub, q);
        
        % 对齐长度
        min_len = min(length(r), length(sub));
        r(1:min_len) = mod(r(1:min_len) - sub(1:min_len), q);
        
        % 去除末尾零
        r = r(1:find(r, 1, 'last'));
        
        if isempty(r)
            r = 0;
        end
    end
    
    % 转回降幂
    result = flip(r);
    result = trim_poly(result);
end