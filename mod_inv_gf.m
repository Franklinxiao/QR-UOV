
function inv = mod_inv_gf(a, q)
% MOD_INV_GF 有限域中的乘法逆元
%   输入：
%       a - 非零元素
%       q - 素数域阶数
%   输出：
%       inv - a 在 GF(q) 中的逆元

    if mod(a, q) == 0
        error('零元素没有乘法逆元');
    end
    
    % 使用费马小定理（适用于素数域）
    inv = mod(a^(q-2), q);
    
    % 或者使用扩展欧几里得算法（更通用）
    % [~, inv, ~] = gcd_extended(a, q);
    % inv = mod(inv, q);
end



