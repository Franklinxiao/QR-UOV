classdef SHAKE
    properties (Constant, Access = private)
        RC = uint64([...
            hex2dec('0000000000000001'), hex2dec('0000000000008082'), ...
            hex2dec('800000000000808A'), hex2dec('8000000080008000'), ...
            hex2dec('000000000000808B'), hex2dec('0000000080000001'), ...
            hex2dec('8000000080008081'), hex2dec('8000000000008009'), ...
            hex2dec('000000000000008A'), hex2dec('0000000000000088'), ...
            hex2dec('0000000080008009'), hex2dec('000000008000000A'), ...
            hex2dec('000000008000808B'), hex2dec('800000000000008B'), ...
            hex2dec('8000000000008089'), hex2dec('8000000000008003'), ...
            hex2dec('8000000000008002'), hex2dec('8000000000000080'), ...
            hex2dec('000000000000800A'), hex2dec('800000008000000A'), ...
            hex2dec('8000000080008081'), hex2dec('8000000000008080'), ...
            hex2dec('0000000080000001'), hex2dec('8000000080008008')]);
        
        ROT = [...
            0,  1, 62, 28, 27, ...
            36, 44,  6, 55, 20, ...
             3, 10, 43, 25, 39, ...
            41, 45, 15, 21,  8, ...
            18,  2, 61, 56, 14];
    end
    
    methods (Static)
        function output = SHAKE128(input, outputByteLen)
            rate = 168;
            output = SHAKE.sponge(input, outputByteLen, rate);
        end
        
        function output = SHAKE256(input, outputByteLen)
            rate = 136;
            output = SHAKE.sponge(input, outputByteLen, rate);
        end
        
        function output = sponge(input, outputByteLen, rate)
            state = zeros(5, 5, 'uint64');
            padded = SHAKE.pad(input, rate);
            numBlocks = length(padded) / rate;
            for blockIdx = 0:numBlocks-1
                block = padded(blockIdx*rate + 1 : (blockIdx+1)*rate);
                state = SHAKE.xorBlock(state, block, rate);
                state = SHAKE.keccakF(state);
            end
            output = uint8([]);
            while length(output) < outputByteLen
                block = SHAKE.extractBlock(state, rate);
                output = [output, block];
                if length(output) < outputByteLen
                    state = SHAKE.keccakF(state);
                end
            end
            output = output(1:outputByteLen);
        end
        
        function state = keccakF(state)
            for round = 0:23
                % θ步
                C = zeros(1, 5, 'uint64');
                for x = 1:5
                    C(x) = bitxor(bitxor(bitxor(bitxor(state(x,1), state(x,2)), state(x,3)), state(x,4)), state(x,5));
                end
                D = zeros(1, 5, 'uint64');
                for x = 1:5
                    D(x) = bitxor(C(mod(x,5)+1), rotl64(C(mod(x+3,5)+1), 1));
                end
                for x = 1:5
                    for y = 1:5
                        state(x,y) = bitxor(state(x,y), D(x));
                    end
                end
                % ρ步和π步
                newState = zeros(5,5,'uint64');
                for x = 1:5
                    for y = 1:5
                        idx = (y-1)*5 + x;
                        rot = SHAKE.ROT(idx);
                        newState(y, mod(2*x+3*y,5)+1) = rotl64(state(x,y), rot);
                    end
                end
                state = newState;
                % χ步
                for y = 1:5
                    for x = 1:5
                        state(x,y) = bitxor(state(x,y), ...
                            bitand(bitcmp(state(mod(x,5)+1,y), 'uint64'), state(mod(x+1,5)+1,y)));
                    end
                end
                % ι步
                state(1,1) = bitxor(state(1,1), SHAKE.RC(round+1));
            end
        end
        
        function state = xorBlock(state, block, rate)
            block64 = SHAKE.bytesToUint64(block);
            numWords = rate / 8;
            for i = 1:numWords
                row = mod(i-1, 5) + 1;
                col = floor((i-1)/5) + 1;
                state(row, col) = bitxor(state(row, col), block64(i));
            end
        end
        
        function block = extractBlock(state, rate)
            numWords = rate / 8;
            block64 = zeros(1, numWords, 'uint64');
            for i = 1:numWords
                row = mod(i-1, 5) + 1;
                col = floor((i-1)/5) + 1;
                block64(i) = state(row, col);
            end
            block = SHAKE.uint64ToBytes(block64);
        end
        
        function padded = pad(message, rate)
            len = length(message);
            requiredLen = ceil((len + 2) / rate) * rate;
            padded = zeros(1, requiredLen, 'uint8');
            padded(1:len) = message;
            if len < requiredLen
                padded(len+1) = 0x80;
            end
            padded(end) = bitxor(padded(end), 0x01);
        end
        
        function uint64Arr = bytesToUint64(bytes)
            numWords = length(bytes) / 8;
            uint64Arr = zeros(1, numWords, 'uint64');
            for i = 1:numWords
                word = uint64(0);
                for j = 0:7
                    word = bitor(word, bitshift(uint64(bytes((i-1)*8 + j + 1)), 8*j));
                end
                uint64Arr(i) = word;
            end
        end
        
        function bytes = uint64ToBytes(uint64Arr)
            bytes = zeros(1, length(uint64Arr) * 8, 'uint8');
            for i = 1:length(uint64Arr)
                word = uint64Arr(i);
                for j = 0:7
                    bytes((i-1)*8 + j + 1) = bitand(bitshift(word, -8*j), 255);
                end
            end
        end
        
        % 新增：整数转固定长度字节
        function bytes = integerToBits(val, byteLen)
            bytes = zeros(1, byteLen, 'uint8');
            for i = 1:byteLen
                bytes(i) = bitand(val, 255);
                val = bitshift(val, -8);
            end
        end
    end
end

function result = rotl64(x, shift)
    shift = mod(shift, 64);
    result = bitor(bitshift(x, shift), bitshift(x, shift-64));
end