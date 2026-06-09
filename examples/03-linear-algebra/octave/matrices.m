%% 第3章：线性代数 - 矩阵基本运算
% 本文件演示如何在Octave中进行符号矩阵的基本运算
% 包括：矩阵创建、加法、乘法、行列式、逆矩阵等

%% 初始化符号计算包

fprintf('=== 矩阵基本运算示例 ===\n\n');

%% 1. 矩阵的创建
fprintf('--- 1. 矩阵的创建 ---\n');

% 创建数值矩阵
A_num = [1, 2, 3; 4, 5, 6; 7, 8, 9];
fprintf('数值矩阵 A:\n');
disp(A_num);

% 创建符号矩阵（使用符号变量）
syms a b c d
S = [a, b; c, d];
fprintf('符号矩阵 S:\n');
disp(S);

% 创建特殊矩阵
Z = zeros(3, 3);           % 3x3 零矩阵
I = eye(3);                % 3x3 单位矩阵
D = diag([1, 2, 3]);       % 对角矩阵

fprintf('零矩阵 Z:\n');
disp(Z);
fprintf('单位矩阵 I:\n');
disp(I);
fprintf('对角矩阵 D:\n');
disp(D);

%% 2. 矩阵加法与数乘
fprintf('\n--- 2. 矩阵加法与数乘 ---\n');

% 定义两个矩阵
A = [1, 2; 3, 4];
B = [5, 6; 7, 8];

fprintf('矩阵 A:\n');
disp(A);
fprintf('矩阵 B:\n');
disp(B);

% 矩阵加法
C_add = A + B;
fprintf('A + B:\n');
disp(C_add);

% 数乘
k = 3;
C_scalar = k * A;
fprintf('3 * A:\n');
disp(C_scalar);

% 矩阵减法
C_sub = A - B;
fprintf('A - B:\n');
disp(C_sub);

%% 3. 矩阵乘法
fprintf('\n--- 3. 矩阵乘法 ---\n');

% 2x2 矩阵乘法
C_mult = A * B;
fprintf('A * B:\n');
disp(C_mult);

% 注意：矩阵乘法不满足交换律
C_mult_rev = B * A;
fprintf('B * A:\n');
disp(C_mult_rev);

% 验证 A*B != B*A
fprintf('A*B - B*A:\n');
disp(C_mult - C_mult_rev);

% 元素级乘法（Hadamard积）
C_elem = A .* B;
fprintf('A .* B (元素级乘法):\n');
disp(C_elem);

%% 4. 矩阵转置
fprintf('\n--- 4. 矩阵转置 ---\n');

% 复数矩阵的转置
M_complex = [1+2i, 3+4i; 5+6i, 7+8i];
fprintf('复数矩阵 M:\n');
disp(M_complex);

% 转置（不共轭）
M_trans = M_complex.';
fprintf('转置 M.'':\n');
disp(M_trans);

% 共轭转置
M_ctrans = M_complex';
fprintf('共轭转置 M'':\n');
disp(M_ctrans);

%% 5. 行列式
fprintf('\n--- 5. 行列式 ---\n');

% 2x2 矩阵的行列式
det_A = det(A);
fprintf('det(A) = %d\n', det_A);

% 3x3 矩阵的行列式
C = [1, 2, 3; 0, 1, 4; 5, 6, 0];
fprintf('矩阵 C:\n');
disp(C);
det_C = det(C);
fprintf('det(C) = %d\n', det_C);

% 符号行列式
syms x y
S_det = [x, y; 1-x, 1+y];
det_S = det(S_det);
fprintf('符号行列式 det([x, y; 1-x, 1+y]):\n');
disp(det_S);
fprintf('化简后:\n');
disp(simplify(det_S));

%% 6. 逆矩阵
fprintf('\n--- 6. 逆矩阵 ---\n');

% 数值逆矩阵
A_inv = inv(A);
fprintf('A 的逆矩阵:\n');
disp(A_inv);

% 验证 A * A^(-1) = I
check = A * A_inv;
fprintf('验证 A * A^(-1):\n');
check(abs(check) < 1e-10) = 0;
disp(check);

% 符号逆矩阵
syms a b c d
S_inv = inv([a, b; c, d]);
fprintf('符号矩阵的逆:\n');
disp(S_inv);

%% 7. 矩阵的秩
fprintf('\n--- 7. 矩阵的秩 ---\n');

% 满秩矩阵
rank_A = rank(A);
fprintf('A 的秩: %d\n', rank_A);

% 秩亏矩阵
A_singular = [1, 2, 3; 4, 5, 6; 7, 8, 9];
rank_singular = rank(A_singular);
fprintf('奇异矩阵的秩: %d\n', rank_singular);

%% 8. 物理应用：惯性张量
fprintf('\n--- 8. 物理应用：惯性张量 ---\n');

% 假设一个质量为 m 的长方体，边长为 a, b, c
syms m a b c positive

% 惯性张量（绕质心）
I_tensor = (m/12) * [
    b^2 + c^2, 0, 0;
    0, a^2 + c^2, 0;
    0, 0, a^2 + b^2
];

fprintf('长方体的惯性张量:\n');
disp(I_tensor);

% 计算行列式（主惯性矩的乘积）
det_I = det(I_tensor);
fprintf('惯性张量的行列式:\n');
disp(simplify(det_I));

%% 9. 矩阵的迹
fprintf('\n--- 9. 矩阵的迹 ---\n');

trace_A = trace(A);
fprintf('A 的迹: %d\n', trace_A);

% 符号迹
trace_S = trace(S);
fprintf('符号矩阵 S 的迹:\n');
disp(trace_S);

%% 10. 矩阵的幂
fprintf('\n--- 10. 矩阵的幂 ---\n');

A_sq = A^2;
fprintf('A^2:\n');
disp(A_sq);

A_3 = A^3;
fprintf('A^3:\n');
disp(A_3);

fprintf('\n=== 矩阵基本运算示例完成 ===\n');
