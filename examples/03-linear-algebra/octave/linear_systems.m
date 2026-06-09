%% 第3章：线性代数 - 线性方程组求解
% 本文件演示如何在Octave中求解线性方程组
% 包括：直接法、高斯消元、克拉默法则、符号求解等

%% 初始化符号计算包

fprintf('=== 线性方程组求解示例 ===\n\n');

%% 1. 基本线性方程组求解
fprintf('--- 1. 基本线性方程组求解 ---\n');

% 定义方程组：
% 2x + 3y = 8
% 4x + 5y = 14
A = [2, 3; 4, 5];
b = [8; 14];

fprintf('系数矩阵 A:\n');
disp(A);
fprintf('常数向量 b:\n');
disp(b);

% 方法1: 使用左除运算符（最推荐）
x1 = A \ b;
fprintf('方法1 - 左除法 (A\\b):\n');
disp(x1);

% 方法2: 使用逆矩阵
x2 = inv(A) * b;
fprintf('方法2 - 逆矩阵法 (inv(A)*b):\n');
disp(x2);

% 方法3: 使用 linsolve 函数
x3 = linsolve(A, b);
fprintf('方法3 - linsolve 函数:\n');
disp(x3);

%% 2. 符号求解
fprintf('\n--- 2. 符号求解 ---\n');

% 定义符号变量
syms x y

% 定义方程
eq1 = 2*x + 3*y == 8;
eq2 = 4*x + 5*y == 14;

% 求解方程组
sol = solve([eq1, eq2], [x, y]);
fprintf('符号解:\n');
fprintf('x = %s\n', char(sol.x));
fprintf('y = %s\n', char(sol.y));

%% 3. 3x3 线性方程组
fprintf('\n--- 3. 3x3 线性方程组 ---\n');

% 定义方程组：
% x + 2y + 3z = 1
% 2x + 5y + 2z = 3
% 3x + y + 5z = 2
A3 = [1, 2, 3; 2, 5, 2; 3, 1, 5];
b3 = [1; 3; 2];

fprintf('系数矩阵 A3:\n');
disp(A3);
fprintf('常数向量 b3:\n');
disp(b3);

% 求解
x3 = A3 \ b3;
fprintf('解向量:\n');
disp(x3);

% 验证解
check = A3 * x3;
fprintf('验证 A3 * x = b3:\n');
disp(check);

%% 4. 克拉默法则
fprintf('\n--- 4. 克拉默法则 ---\n');

% 对于 2x2 系统
fprintf('使用克拉默法则求解 2x2 系统:\n');

% 计算主行列式
det_A = det(A);
fprintf('det(A) = %f\n', det_A);

% 计算 x 的分子行列式（替换第一列）
A_x = A;
A_x(:, 1) = b;
det_Ax = det(A_x);
fprintf('det(A_x) = %f\n', det_Ax);

% 计算 y 的分子行列式（替换第二列）
A_y = A;
A_y(:, 2) = b;
det_Ay = det(A_y);
fprintf('det(A_y) = %f\n', det_Ay);

% 应用克拉默法则
x_cramer = det_Ax / det_A;
y_cramer = det_Ay / det_A;
fprintf('克拉默法则结果: x = %f, y = %f\n', x_cramer, y_cramer);

%% 5. 高斯消元法
fprintf('\n--- 5. 高斯消元法 ---\n');

% 创建增广矩阵
aug = [A, b];
fprintf('增广矩阵 [A|b]:\n');
disp(aug);

% 使用 rref 函数进行行化简
rref_aug = rref(aug);
fprintf('行最简形:\n');
disp(rref_aug);

% 从行最简形中提取解
x_gauss = rref_aug(:, end);
fprintf('高斯消元法解:\n');
disp(x_gauss);

%% 6. 3x3 系统的高斯消元
fprintf('\n--- 6. 3x3 系统的高斯消元 ---\n');

% 增广矩阵
aug3 = [A3, b3];
fprintf('增广矩阵 [A3|b3]:\n');
disp(aug3);

% 行化简
rref_aug3 = rref(aug3);
fprintf('行最简形:\n');
disp(rref_aug3);

%% 7. 齐次线性方程组
fprintf('\n--- 7. 齐次线性方程组 ---\n');

% 齐次方程组 Ax = 0
A_homo = [1, 2, 3; 4, 5, 6; 7, 8, 9];
fprintf('齐次方程组系数矩阵:\n');
disp(A_homo);

% 计算秩
r = rank(A_homo);
fprintf('矩阵的秩: %d\n', r);
fprintf('解空间维数: %d\n', 3 - r);

% 使用 null 函数求零空间
N = null(A_homo);
fprintf('零空间基:\n');
disp(N);

%% 8. 超定方程组（最小二乘）
fprintf('\n--- 8. 超定方程组（最小二乘） ---\n');

% 超定系统：方程数 > 未知数
A_over = [1, 1; 2, 1; 3, 1; 4, 1];
b_over = [2; 3; 5; 6];

fprintf('超定系统 A*x = b:\n');
fprintf('A:\n');
disp(A_over);
fprintf('b:\n');
disp(b_over);

% 最小二乘解
x_ls = A_over \ b_over;
fprintf('最小二乘解:\n');
disp(x_ls);

% 计算残差
residual = b_over - A_over * x_ls;
fprintf('残差向量:\n');
disp(residual);
fprintf('残差范数: %f\n', norm(residual));

%% 9. 欠定方程组
fprintf('\n--- 9. 欠定方程组 ---\n');

% 欠定系统：方程数 < 未知数
A_under = [1, 2, 3; 4, 5, 6];
b_under = [1; 2];

fprintf('欠定系统 A*x = b:\n');
fprintf('A:\n');
disp(A_under);
fprintf('b:\n');
disp(b_under);

% 求最小范数解
x_under = pinv(A_under) * b_under;
fprintf('最小范数解:\n');
disp(x_under);

%% 10. 物理应用：电路分析
fprintf('\n--- 10. 物理应用：电路分析 ---\n');

% 三个回路的电路方程
% R1*I1 - R2*(I1-I2) = V1
% -R2*(I1-I2) + R3*I2 - R4*(I2-I3) = 0
% -R4*(I2-I3) + R5*I3 = -V2

% 设定电阻和电压值
R1 = 10; R2 = 20; R3 = 30; R4 = 40; R5 = 50;
V1 = 100; V2 = 50;

% 构建系数矩阵
A_circuit = [
    R1 + R2, -R2, 0;
    -R2, R2 + R3 + R4, -R4;
    0, -R4, R4 + R5
];

b_circuit = [V1; 0; -V2];

fprintf('电路方程系数矩阵:\n');
disp(A_circuit);
fprintf('电压向量:\n');
disp(b_circuit);

% 求解电流
I = A_circuit \ b_circuit;
fprintf('各回路电流:\n');
fprintf('I1 = %.4f A\n', I(1));
fprintf('I2 = %.4f A\n', I(2));
fprintf('I3 = %.4f A\n', I(3));

%% 11. 符号求解一般系统
fprintf('\n--- 11. 符号求解一般系统 ---\n');

% 符号系数矩阵
syms a11 a12 a21 a22 b1 b2
A_sym = [a11, a12; a21, a22];
b_sym = [b1; b2];

% 符号解
x_sym = A_sym \ b_sym;
fprintf('符号解:\n');
fprintf('x1 = %s\n', char(simplify(x_sym(1))));
fprintf('x2 = %s\n', char(simplify(x_sym(2))));

% 使用克拉默法则验证
det_A_sym = det(A_sym);
x1_cramer = det([b_sym, A_sym(:,2)]) / det_A_sym;
x2_cramer = det([A_sym(:,1), b_sym]) / det_A_sym;

fprintf('\n克拉默法则验证:\n');
fprintf('x1 = %s\n', char(simplify(x1_cramer)));
fprintf('x2 = %s\n', char(simplify(x2_cramer)));

fprintf('\n=== 线性方程组求解示例完成 ===\n');
