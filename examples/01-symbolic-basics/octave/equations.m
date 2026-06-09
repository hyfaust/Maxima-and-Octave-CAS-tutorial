% Equation Solving Examples for Octave
% 方程求解示例 - 适用于Octave（需要symbolic包）
%
% 本文件演示如何使用符号计算求解各种类型的方程
% 作者: CAS Learn Tutorial
% 日期: 2026-06-05

% 确保加载symbolic包

%% 定义符号变量
syms x y z a b c;

%% 1. 线性方程求解
fprintf('=== 线性方程求解 ===\n');

% 一元一次方程: 2x + 3 = 7
eq1 = 2*x + 3 == 7;
sol1 = solve(eq1, x);
fprintf('方程 2x + 3 = 7 的解: x = %s\n', char(sol1));

% 一元一次方程: ax + b = 0
eq2 = a*x + b == 0;
sol2 = solve(eq2, x);
fprintf('方程 ax + b = 0 的解: x = %s\n', char(sol2));

%% 2. 二次方程求解
fprintf('\n=== 二次方程求解 ===\n');

% 标准二次方程: ax² + bx + c = 0
eq3 = a*x^2 + b*x + c == 0;
sol3 = solve(eq3, x);
fprintf('二次方程 ax² + bx + c = 0 的解:\n');
fprintf('x₁ = %s\n', char(sol3(1)));
fprintf('x₂ = %s\n', char(sol3(2)));

% 具体例子: x² - 5x + 6 = 0
eq4 = x^2 - 5*x + 6 == 0;
sol4 = solve(eq4, x);
fprintf('\n具体例子 x² - 5x + 6 = 0:\n');
fprintf('x₁ = %s, x₂ = %s\n', char(sol4(1)), char(sol4(2)));

% 有复数解的例子: x² + 1 = 0
eq5 = x^2 + 1 == 0;
sol5 = solve(eq5, x);
fprintf('\n复数解例子 x² + 1 = 0:\n');
fprintf('x₁ = %s, x₂ = %s\n', char(sol5(1)), char(sol5(2)));

%% 3. 高次多项式方程
fprintf('\n=== 高次多项式方程 ===\n');

% 三次方程: x³ - 6x² + 11x - 6 = 0
eq6 = x^3 - 6*x^2 + 11*x - 6 == 0;
sol6 = solve(eq6, x);
fprintf('三次方程 x³ - 6x² + 11x - 6 = 0 的解:\n');
for i = 1:length(sol6)
    fprintf('x%d = %s\n', i, char(sol6(i)));
end

% 四次方程: x⁴ - 16 = 0
eq7 = x^4 - 16 == 0;
sol7 = solve(eq7, x);
fprintf('\n四次方程 x⁴ - 16 = 0 的解:\n');
for i = 1:length(sol7)
    fprintf('x%d = %s\n', i, char(sol7(i)));
end

%% 4. 方程组求解
fprintf('\n=== 方程组求解 ===\n');

% 二元一次方程组
eq8 = 2*x + y == 5;
eq9 = x - y == 1;
[sol_x, sol_y] = solve([eq8, eq9], [x, y]);
fprintf('方程组:\n');
fprintf('  2x + y = 5\n');
fprintf('  x - y = 1\n');
fprintf('解: x = %s, y = %s\n', char(sol_x), char(sol_y));

% 三元一次方程组
eq10 = x + y + z == 6;
eq11 = 2*x - y + z == 3;
eq12 = x + 2*y - z == 2;
[sol_x, sol_y, sol_z] = solve([eq10, eq11, eq12], [x, y, z]);
fprintf('\n三元一次方程组:\n');
fprintf('  x + y + z = 6\n');
fprintf('  2x - y + z = 3\n');
fprintf('  x + 2y - z = 2\n');
fprintf('解: x = %s, y = %s, z = %s\n', char(sol_x), char(sol_y), char(sol_z));

%% 5. 非线性方程组
fprintf('\n=== 非线性方程组 ===\n');

% 圆与直线的交点
circle_eq = x^2 + y^2 == 25;
line_eq = x + y == 7;
[sol_x, sol_y] = solve([circle_eq, line_eq], [x, y]);
fprintf('圆 x² + y² = 25 与直线 x + y = 7 的交点:\n');
for i = 1:length(sol_x)
    fprintf('点%d: (%s, %s)\n', i, char(sol_x(i)), char(sol_y(i)));
end

%% 6. 不等式求解
fprintf('\n=== 不等式求解 ===\n');

% 简单不等式
ineq1 = x^2 - 4 > 0;
sol_ineq1 = solve(ineq1, x);
fprintf('不等式 x² - 4 > 0 的解集: %s\n', char(sol_ineq1));

%% 7. 含参数的方程求解
fprintf('\n=== 含参数的方程求解 ===\n');

% 一元二次方程判别式
syms a b c;
disc_eq = a*x^2 + b*x + c == 0;
disc_sol = solve(disc_eq, x);
discriminant = b^2 - 4*a*c;
fprintf('一元二次方程 ax² + bx + c = 0:\n');
fprintf('解: x = %s\n', char(disc_sol(1)));
fprintf('判别式 Δ = %s\n', char(discriminant));

%% 8. 物理学应用：运动方程
fprintf('\n=== 物理学应用：运动方程 ===\n');

% 自由落体运动：h = h0 + v0*t - (1/2)*g*t^2
syms h0 v0 g t;
h = h0 + v0*t - (1/2)*g*t^2;

% 求落地时间 (h = 0)
land_time = solve(h == 0, t);
fprintf('自由落体运动方程: h = %s\n', char(h));
fprintf('落地时间 (h=0): t = %s\n', char(land_time(1)));

% 具体数值：h0=100m, v0=0, g=9.8m/s²
h_specific = 100 + 0*t - 4.9*t^2;
t_land = solve(h_specific == 0, t);
t_land_positive = t_land(t_land > 0);
fprintf('具体例子 (h0=100m, v0=0, g=9.8): 落地时间 t = %s 秒\n', char(double(t_land_positive)));

%% 9. 工程应用：电路分析
fprintf('\n=== 工程应用：电路分析 ===\n');

% 基尔霍夫电压定律 (KVL) 求解电路
syms I1 I2 R1 R2 R3 V;
% 两个网孔的电路方程
kvl1 = R1*I1 + R3*(I1 - I2) == V;
kvl2 = R2*I2 + R3*(I2 - I1) == 0;

[I1_sol, I2_sol] = solve([kvl1, kvl2], [I1, I2]);
fprintf('电路方程求解:\n');
fprintf('I1 = %s\n', char(I1_sol));
fprintf('I2 = %s\n', char(I2_sol));

% 具体数值：R1=10Ω, R2=20Ω, R3=30Ω, V=12V
I1_val = double(subs(I1_sol, {R1, R2, R3, V}, {10, 20, 30, 12}));
I2_val = double(subs(I2_sol, {R1, R2, R3, V}, {10, 20, 30, 12}));
fprintf('具体数值 (R1=10Ω, R2=20Ω, R3=30Ω, V=12V):\n');
fprintf('I1 = %.4f A, I2 = %.4f A\n', I1_val, I2_val);

%% 10. 数值求解与符号求解对比
fprintf('\n=== 数值求解与符号求解对比 ===\n');

% 符号求解
eq_numeric = x^3 - 2*x - 5 == 0;
sol_symbolic = solve(eq_numeric, x);
fprintf('符号解: %s\n', char(sol_symbolic(1)));

% 数值求解
sol_numeric = vpasolve(eq_numeric, x);
fprintf('数值解: %s\n', char(sol_numeric));

fprintf('\n方程求解示例完成！\n');
