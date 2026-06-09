% integrals.m - 积分计算示例
% 本文件演示如何使用 Octave 符号计算包计算各种类型的积分
% 确保已安装并加载符号计算包

% 加载符号计算包

% 定义符号变量
syms x

disp('=== 积分计算示例 ===')
disp(' ')

%% 1. 不定积分
disp('1. 不定积分计算')

% 示例1：多项式积分
f1 = x^2;
F1 = int(f1, x);
disp(['∫x^2 dx = ', char(F1), ' + C'])

% 示例2：三角函数积分
f2 = sin(x);
F2 = int(f2, x);
disp(['∫sin(x) dx = ', char(F2), ' + C'])

f3 = cos(x);
F3 = int(f3, x);
disp(['∫cos(x) dx = ', char(F3), ' + C'])

% 示例3：指数函数积分
f4 = exp(2*x);
F4 = int(f4, x);
disp(['∫e^(2x) dx = ', char(F4), ' + C'])

% 示例4：有理函数积分
f5 = 1/(1 + x^2);
F5 = int(f5, x);
disp(['∫1/(1+x^2) dx = ', char(F5), ' + C'])

% 示例5：对数函数积分
f6 = 1/x;
F6 = int(f6, x);
disp(['∫1/x dx = ', char(F6), ' + C'])

disp(' ')

%% 2. 定积分
disp('2. 定积分计算')

% 示例6：基本定积分
f7 = x^3 - 2*x;
definite_integral1 = int(f7, x, 0, 2);
disp(['∫_0^2 (x^3 - 2x) dx = ', char(definite_integral1)])

% 示例7：三角函数定积分
f8 = sin(x);
definite_integral2 = int(f8, x, 0, sym(pi));
disp(['∫_0^π sin(x) dx = ', char(definite_integral2)])

% 示例8：指数函数定积分
f9 = exp(x);
definite_integral3 = int(f9, x, 0, 1);
disp(['∫_0^1 e^x dx = ', char(definite_integral3)])

disp(' ')

%% 3. 换元积分法
disp('3. 换元积分法')

% 示例9：第一类换元积分
f10 = 2*x * cos(x^2);
F10 = int(f10, x);
disp(['∫ 2x*cos(x^2) dx = ', char(F10)])

% 手动换元验证
% 令 u = x^2, du = 2x dx
syms u
u_sub = x^2;
du_sub = diff(u_sub, x);
f10_sub = cos(u_sub) * du_sub;
F10_sub = int(f10_sub, u);
disp(['使用换元法: ∫ cos(u) du = ', char(subs(F10_sub, u, x^2))])

disp(' ')

% 示例10：更复杂的换元积分
f11 = x * sqrt(1 + x^2);
F11 = int(f11, x);
disp(['∫ x*sqrt(1+x^2) dx = ', char(F11)])

disp(' ')

%% 4. 分部积分法
disp('4. 分部积分法')

% 示例11：分部积分 ∫ x*e^x dx
f12 = x * exp(x);
F12 = int(f12, x);
disp(['∫ x*e^x dx = ', char(F12)])

% 手动分部积分验证
% u = x, dv = e^x dx
% du = dx, v = e^x
% ∫ x*e^x dx = x*e^x - ∫ e^x dx
disp('手动分部积分: ∫ x*e^x dx = x*e^x - ∫ e^x dx = x*e^x - e^x')

disp(' ')

% 示例12：分部积分 ∫ x*sin(x) dx
f13 = x * sin(x);
F13 = int(f13, x);
disp(['∫ x*sin(x) dx = ', char(F13)])

disp(' ')

%% 5. 三角函数积分
disp('5. 三角函数积分')

% 示例13：三角函数积分
f14 = sin(x)^2;
F14 = int(f14, x);
disp(['∫ sin^2(x) dx = ', char(F14)])

f15 = cos(x)^2;
F15 = int(f15, x);
disp(['∫ cos^2(x) dx = ', char(F15)])

f16 = sin(x) * cos(x);
F16 = int(f16, x);
disp(['∫ sin(x)cos(x) dx = ', char(F16)])

disp(' ')

%% 6. 有理函数积分
disp('6. 有理函数积分')

% 示例14：部分分式分解
f17 = 1/(x^2 - 1);
F17 = int(f17, x);
disp(['∫ 1/(x^2-1) dx = ', char(F17)])

f18 = 1/(x^2 + 1);
F18 = int(f18, x);
disp(['∫ 1/(x^2+1) dx = ', char(F18)])

f19 = (2*x + 1)/(x^2 + x + 1);
F19 = int(f19, x);
disp(['∫ (2x+1)/(x^2+x+1) dx = ', char(F19)])

disp(' ')

%% 7. 物理应用：变力做功
disp('7. 物理应用：变力做功')

% 示例15：弹簧力做功
% 弹簧力 F(x) = 5x（牛顿）
F_spring = 5*x;

% 从 0 拉伸到 0.2 米所做的功
W = int(F_spring, x, 0, 0.2);
disp(['弹簧力 F(x) = 5x 牛顿'])
disp(['从 0 拉伸到 0.2 米所做的功: ', char(W), ' 焦耳'])
disp(['数值结果: ', num2str(double(W)), ' 焦耳'])

disp(' ')

% 示例16：重力做功
% 质量为 m 的物体从高度 h1 移动到 h2
syms m g h h1 h2
F_gravity = m*g;  % 重力
W_gravity = int(F_gravity, h, h1, h2);
disp(['重力做功公式: W = ', char(W_gravity)])
disp(['当 m=2kg, g=9.8m/s^2, h1=0, h2=10m 时:'])
W_gravity_num = subs(W_gravity, [m, g, h1, h2], [2, 9.8, 0, 10]);
disp(['W = ', char(W_gravity_num), ' = ', num2str(double(W_gravity_num)), ' 焦耳'])

disp(' ')

%% 8. 面积计算
disp('8. 面积计算')

% 示例17：曲线下的面积
% 计算 y = x^2 从 0 到 1 的面积
area1 = int(x^2, x, 0, 1);
disp(['曲线 y=x^2 从 0 到 1 的面积: ', char(area1)])

% 示例18：两条曲线之间的面积
% 计算 y = x 和 y = x^2 之间的面积
area2 = int(x - x^2, x, 0, 1);
disp(['y=x 和 y=x^2 之间的面积: ', char(area2)])

disp(' ')

%% 9. 数值验证
disp('9. 数值验证')

% 验证 ∫_0^1 x^2 dx = 1/3
disp('验证 ∫_0^1 x^2 dx = 1/3')
n_values = [10, 100, 1000, 10000];
disp('n          | 梯形法则近似 | 误差')
exact_value = 1/3;

for n = n_values
    x_vals = linspace(0, 1, n+1);
    y_vals = x_vals.^2;
    trapezoidal = trapz(x_vals, y_vals);
    error = abs(trapezoidal - exact_value);
    fprintf('%-10d | %.10f   | %.2e\n', n, trapezoidal, error);
end

disp(' ')


%% 11. 练习
disp('11. 练习')
disp('尝试计算以下积分：')
disp('1. ∫ x^3 * e^x dx')
disp('2. ∫ 1/(x^2 + 4x + 5) dx')
disp('3. ∫_0^π sin^2(x) dx')
disp('4. ∫ x * ln(x) dx')
disp('5. 计算 y = sin(x) 和 y = cos(x) 在 [0, π/4] 之间的面积')
disp(' ')

disp('=== 积分计算示例结束 ===')