function out = PRG(seed, i,output_len)
 a = [seed, SHAKE.integerToBits(i-1, output_len)];
out = SHAKE.SHAKE128(a, 64);
end

