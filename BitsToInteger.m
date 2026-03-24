function num = BitsToInteger(bits)
    % 比特流转整数
    bits = bits(:)';  % 确保行向量
    num = sum(bits .* 2.^(length(bits)-1:-1:0));
end

