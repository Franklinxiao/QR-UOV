%% 修正后的使用示例
clear; clc;

% 示例1: 基本使用
message = uint8('Hello, World!');
output128 = SHAKE.SHAKE128(message, 32);
disp('SHAKE-128 (32 bytes):');
disp(reshape(dec2hex(output128, 2)', 64, [])');

% 示例2: 域分离验证（使用类内部方法）
seed = uint8(1:32);
i1 = 1;
i2 = 2;

%%%integerToBits用法%%%%
% 构造不同输入: seed || integerToBits(i-1, 16)
input1 = [seed, SHAKE.integerToBits(i1-1, 16)];
input2 = [seed, SHAKE.integerToBits(i2-1, 16)];

out1 = SHAKE.SHAKE256(input1, 64);
out2 = SHAKE.SHAKE256(input2, 64);

fprintf('\n不同i的输出是否相同? %s\n', mat2str(isequal(out1, out2)));
fprintf('前16字节 (i=1): %s\n', reshape(dec2hex(out1(1:16),2)', 32, [])');
fprintf('前16字节 (i=2): %s\n', reshape(dec2hex(out2(1:16),2)', 32, [])');
