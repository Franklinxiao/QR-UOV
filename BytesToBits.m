function bits = BytesToBits(bytes)
    % 将字节数组转换为比特流
    % 输入: bytes - uint8数组
    % 输出: bits - uint8数组，值为0或1
    bits = bitget(bytes(:), 8:-1:1)';
    bits =uint8( bits(:)');
end