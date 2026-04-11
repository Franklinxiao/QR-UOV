function bits = BytesToBits(bytes)
   num_bytes = length(bytes);
    bits = zeros(1, num_bytes * 8, 'uint8');
    for i = 1:num_bytes
        bits((i-1)*8 + 1 : i*8) = bitget(bytes(i), 8:-1:1);
    end
end