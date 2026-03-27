function [g, x, y] = gcd_extended(a, b)
% GCD_EXTENDED 扩展欧几里得算法
    if a == 0
        g = b;
        x = 0;
        y = 1;
    else
        [g, y, x] = gcd_extended(mod(b, a), a);
        y = y - floor(b / a) * x;
    end
end