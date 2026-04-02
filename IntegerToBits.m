function bits = IntegerToBits(num, len)
    % 整数转比特流
    if nargin < 2
        len = max(1, floor(log2(num)) + 1);
    end
    bits = bitget(num, len:-1:1);
    bits =uint8(bits(:)');
end