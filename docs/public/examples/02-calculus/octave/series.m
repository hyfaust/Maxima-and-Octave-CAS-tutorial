% series.m - 泰勒级数展开示例
% 本文件演示如何使用 Octave 符号计算包进行泰勒级数展开
% 确保已安装并加载符号计算包

% 加载符号计算包

% 定义符号变量
syms x

disp('=== 泰勒级数展开示例 ===')
disp(' ')

%% 1. 基本泰勒展开
disp('1. 基本泰勒展开')

% 示例1：e^x 在 x=0 处的展开（麦克劳林级数）
f1 = exp(x);
taylor_f1 = taylor(f1, x, 0, 'Order', 6);
disp(['e^x 的麦克劳林级数（前5项）:'])
disp(taylor_f1)

% 示例2：sin(x) 的展开
f2 = sin(x);
taylor_f2 = taylor(f2, x, 0, 'Order', 8);
disp(['sin(x) 的麦克劳林级数:'])
disp(taylor_f2)

% 示例3：cos(x) 的展开
f3 = cos(x);
taylor_f3 = taylor(f3, x, 0, 'Order', 8);
disp(['cos(x) 的麦克劳林级数:'])
disp(taylor_f3)

% 示例4：ln(1+x) 的展开
f4 = log(1 + x);
taylor_f4 = taylor(f4, x, 0, 'Order', 6);
disp(['ln(1+x) 的麦克劳林级数:'])
disp(taylor_f4)

disp(' ')

%% 2. 在非零点处的泰勒展开
disp('2. 在非零点处的泰勒展开')

% 示例5：e^x 在 x=1 处的展开
f5 = exp(x);
taylor_f5 = taylor(f5, x, 1, 'Order', 5);
disp(['e^x 在 x=1 处的泰勒级数:'])
disp(taylor_f5)

% 示例6：sin(x) 在 x=π/2 处的展开
f6 = sin(x);
taylor_f6 = taylor(f6, x, sym(pi)/2, 'Order', 5);
disp(['sin(x) 在 x=π/2 处的泰勒级数:'])
disp(taylor_f6)

disp(' ')

%% 3. 常见函数的泰勒展开公式
disp('3. 常见函数的泰勒展开公式')

% 创建一个表格显示常见函数的麦克劳林级数
disp('函数        | 麦克劳林级数')
disp('------------|-------------')

% e^x
disp('e^x         | 1 + x + x²/2! + x³/3! + ...')
% sin(x)
disp('sin(x)      | x - x³/3! + x⁵/5! - x⁷/7! + ...')
% cos(x)
disp('cos(x)      | 1 - x²/2! + x⁴/4! - x⁶/6! + ...')
% ln(1+x)
disp('ln(1+x)     | x - x²/2 + x³/3 - x⁴/4 + ...')
% 1/(1-x)
disp('1/(1-x)     | 1 + x + x² + x³ + ...')
% (1+x)^n
disp('(1+x)^n     | 1 + nx + n(n-1)x²/2! + ...')

disp(' ')

%% 4. 泰勒展开的应用
disp('4. 泰勒展开的应用')

% 示例7：使用泰勒展开近似计算 e
disp('使用泰勒展开近似计算 e:')
exact_e = exp(1);
disp(['e 的精确值: ', num2str(double(exact_e))])

% 不同阶数的近似
orders = [1, 2, 3, 4, 5, 6];
disp('阶数 | 近似值        | 相对误差')
for n = orders
    taylor_approx = taylor(exp(x), x, 0, 'Order', n+1);
    approx_value = double(subs(taylor_approx, x, 1));
    relative_error = abs(approx_value - double(exact_e)) / double(exact_e);
    fprintf('%-4d | %.10f | %.2e\n', n, approx_value, relative_error);
end

disp(' ')

% 示例8：使用泰勒展开近似计算 π
disp('使用泰勒展开近似计算 π:')
exact_pi = sym(pi);
disp(['π 的精确值: ', num2str(double(exact_pi))])

% 使用 arctan(1) = π/4 的泰勒展开
% arctan(x) = x - x³/3 + x⁵/5 - x⁷/7 + ...
atan_taylor = taylor(atan(x), x, 0, 'Order', 20);
pi_approx = 4 * double(subs(atan_taylor, x, 1));
disp(['使用 arctan(1) 的泰勒展开近似 π: ', num2str(pi_approx)])
disp(['相对误差: ', num2str(abs(pi_approx - double(exact_pi)) / double(exact_pi))])

disp(' ')

%% 5. 收敛性分析
disp('5. 收敛性分析')

% 示例9：分析 e^x 的泰勒级数收敛性
disp('分析 e^x 的泰勒级数收敛性:')

% 计算不同阶数的泰勒展开
x_val = 2;  % 在 x=2 处测试
exact_value = exp(x_val);
disp(['在 x=', num2str(x_val), ' 处，e^x 的精确值: ', num2str(double(exact_value))])

orders = [2, 4, 6, 8, 10, 12];
disp('阶数 | 近似值        | 绝对误差      | 相对误差')
for n = orders
    taylor_approx = taylor(exp(x), x, 0, 'Order', n+1);
    approx_value = double(subs(taylor_approx, x, x_val));
    absolute_error = abs(approx_value - double(exact_value));
    relative_error = absolute_error / double(exact_value);
    fprintf('%-4d | %.10f | %.2e | %.2e\n', n, approx_value, absolute_error, relative_error);
end

disp(' ')

%% 6. 小角度近似
disp('6. 小角度近似')

% 示例10：小角度近似分析
disp('分析 sin(x) 的小角度近似:')

% 不同角度下的近似精度
angles = [0.1, 0.2, 0.3, 0.5, 1.0];  % 弧度
disp('角度(弧度) | sin(x)精确值 | 一阶近似(x) | 三阶近似(x-x³/6) | 相对误差(一阶) | 相对误差(三阶)')
for angle = angles
    exact_sin = sin(angle);
    approx_1 = angle;  % 一阶近似
    approx_3 = angle - angle^3/6;  % 三阶近似
    error_1 = abs(approx_1 - exact_sin) / exact_sin;
    error_3 = abs(approx_3 - exact_sin) / exact_sin;
    fprintf('   %.1f     | %.10f | %.10f | %.10f     | %.2e       | %.2e\n', ...
        angle, exact_sin, approx_1, approx_3, error_1, error_3);
end

disp(' ')

%% 7. 物理应用：单摆周期
disp('7. 物理应用：单摆周期')

% 单摆周期公式 T = 2π√(L/g) 是小角度近似
% 更精确的公式涉及椭圆积分
% 使用泰勒展开近似

syms theta_max
% 单摆周期的精确公式（用椭圆积分表示）
% T = 4√(L/g) * K(sin(θ_max/2))
% 其中 K(k) 是第一类完全椭圆积分

% 使用泰勒展开近似
% T ≈ 2π√(L/g) * (1 + θ_max²/16 + ...)
disp('单摆周期的泰勒展开近似:')
disp('T ≈ 2π√(L/g) * (1 + θ_max²/16 + 11*θ_max⁴/3072 + ...)')
disp('当 θ_max 很小时，T ≈ 2π√(L/g)')

% 计算不同最大角度下的修正因子
theta_max_values = [0.1, 0.2, 0.3, 0.5, 1.0];  % 弧度
disp('θ_max(弧度) | 修正因子 T/T0 | 相对误差(%)')
T0 = 2*pi;  % 当 L/g=1 时的周期
for theta_max = theta_max_values
    % 使用数值积分计算精确周期
    integrand = @(theta) 1./sqrt(1 - sin(theta_max/2)^2 * sin(theta).^2);
    K = integral(integrand, 0, pi/2);
    T_exact = 4 * K;
    
    % 泰勒展开近似
    T_approx = 2*pi * (1 + theta_max^2/16 + 11*theta_max^4/3072);
    
    relative_error = abs(T_exact - T_approx) / T_exact;
    fprintf('   %.1f      | %.10f   | %.2e\n', ...
        theta_max, T_exact/T0, relative_error);
end

disp(' ')

%% 8. 级数求和
disp('8. 级数求和')

% 示例11：几何级数求和
disp('几何级数求和:')
syms n
% ∑(1/2)^n 从 n=0 到 ∞
geometric_sum = symsum((1/2)^n, n, 0, inf);
disp(['∑(1/2)^n (n=0 to ∞) = ', char(geometric_sum)])

% 示例12：调和级数的部分和
disp('调和级数的部分和:')
syms k
harmonic_partial = symsum(1/k, k, 1, 10);
disp(['∑(1/k) (k=1 to 10) = ', char(harmonic_partial)])

disp(' ')


%% 10. 练习
disp('10. 练习')
disp('尝试计算以下泰勒展开：')
disp('1. f(x) = sqrt(1+x) 在 x=0 处的泰勒展开（前4项）')
disp('2. g(x) = 1/(1-x^2) 在 x=0 处的泰勒展开（前5项）')
disp('3. h(x) = arctan(x) 在 x=0 处的泰勒展开（前6项）')
disp('4. 分析 ln(1+x) 的泰勒级数在 x=0.5 处的收敛速度')
disp('5. 使用泰勒展开计算 ∫_0^1 e^(-x^2) dx 的近似值')
disp(' ')

disp('=== 泰勒级数展开示例结束 ===')