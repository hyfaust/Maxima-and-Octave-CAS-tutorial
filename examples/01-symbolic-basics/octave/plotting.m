% Function Plotting Examples for Octave
% 函数绘图示例 - 适用于Octave（需要symbolic包）
%
% 本文件演示如何使用符号计算进行函数分析
% 作者: CAS Learn Tutorial
% 日期: 2026-06-05

%% 定义符号变量
syms x y t;

%% 1. 基本函数绘图
fprintf('\n=== 1. 基本函数绘图 ===\n');

figure('Name', '基本函数绘图');

% 多项式函数
subplot(2, 2, 1);
x_vals = linspace(-3, 3, 100);
y1 = x_vals.^3 - 3*x_vals.^2 + 2*x_vals;
plot(x_vals, y1, 'b-', 'LineWidth', 2);
title('多项式: y = x^3 - 3x^2 + 2x');
xlabel('x'); ylabel('y');
grid on;

% 三角函数
subplot(2, 2, 2);
y2 = sin(x_vals) .* exp(-0.2 * x_vals.^2);
plot(x_vals, y2, 'r-', 'LineWidth', 2);
title('衰减正弦: y = sin(x)·e^{-0.2x²}');
xlabel('x'); ylabel('y');
grid on;

% 指数函数
subplot(2, 2, 3);
y3 = exp(x_vals);
plot(x_vals, y3, 'g-', 'LineWidth', 2);
title('指数函数: y = e^x');
xlabel('x'); ylabel('y');
grid on;

% 对数函数
subplot(2, 2, 4);
x_pos = linspace(0.1, 5, 100);
y4 = log(x_pos);
plot(x_pos, y4, 'm-', 'LineWidth', 2);
title('对数函数: y = ln(x)');
xlabel('x'); ylabel('y');
grid on;

%% 2. 符号函数绘图
fprintf('\n=== 2. 符号函数绘图 ===\n');

% 定义符号函数
f_sym = sin(x) * exp(-x/5);
g_sym = cos(x) * exp(-x/5);

% 转换为数值函数
f_num = matlabFunction(f_sym, 'vars', {x});
g_num = matlabFunction(g_sym, 'vars', {x});

figure('Name', '符号函数绘图');
x_plot = linspace(0, 20, 200);
plot(x_plot, f_num(x_plot), 'b-', 'LineWidth', 2);
hold on;
plot(x_plot, g_num(x_plot), 'r--', 'LineWidth', 2);
legend('sin(x)·e^{-x/5}', 'cos(x)·e^{-x/5}');
title('衰减振荡函数');
xlabel('x'); ylabel('y');
grid on;
hold off;

%% 3. 隐函数绘图
fprintf('\n=== 3. 隐函数绘图 ===\n');

figure('Name', '隐函数绘图');

% 圆
subplot(1, 2, 1);
[X, Y] = meshgrid(linspace(-2, 2, 200));
contour(X, Y, X.^2 + Y.^2 - 1, [0 0], 'b-', 'LineWidth', 2);
title('隐函数: x² + y² = 1');
xlabel('x'); ylabel('y');
axis equal;
grid on;

% 心形线
subplot(1, 2, 2);
[X, Y] = meshgrid(linspace(-2, 2, 200));
Z = (X.^2 + Y.^2 - 1).^3 - X.^2 .* Y.^3;
contour(X, Y, Z, [0 0], 'r-', 'LineWidth', 2);
title('心形线');
xlabel('x'); ylabel('y');
axis equal;
grid on;

%% 4. 参数曲线绘图
fprintf('\n=== 4. 参数曲线绘图 ===\n');

figure('Name', '参数曲线绘图');

% 螺旋线
subplot(1, 2, 1);
t_vals = linspace(0, 6*pi, 500);
x_spiral = t_vals .* cos(t_vals);
y_spiral = t_vals .* sin(t_vals);
plot(x_spiral, y_spiral, 'b-', 'LineWidth', 1.5);
title('阿基米德螺旋: r = θ');
xlabel('x'); ylabel('y');
axis equal;
grid on;

% 李萨如图形
subplot(1, 2, 2);
t_lissajous = linspace(0, 2*pi, 500);
x_liss = sin(3 * t_lissajous);
y_liss = sin(2 * t_lissajous);
plot(x_liss, y_liss, 'r-', 'LineWidth', 1.5);
title('李萨如图形: x=sin(3t), y=sin(2t)');
xlabel('x'); ylabel('y');
axis equal;
grid on;

%% 5. 三维曲面绘图
fprintf('\n=== 5. 三维曲面绘图 ===\n');

figure('Name', '三维曲面绘图');

% 高斯曲面
subplot(1, 2, 1);
[X, Y] = meshgrid(linspace(-3, 3, 50));
Z = exp(-(X.^2 + Y.^2));
surf(X, Y, Z);
title('高斯曲面: z = e^{-(x²+y²)}');
xlabel('x'); ylabel('y'); zlabel('z');
shading interp;
colorbar;

% 鞍点
subplot(1, 2, 2);
[X, Y] = meshgrid(linspace(-2, 2, 50));
Z = X.^2 - Y.^2;
surf(X, Y, Z);
title('鞍点: z = x² - y²');
xlabel('x'); ylabel('y'); zlabel('z');
shading interp;
colorbar;

%% 6. 物理学应用：波动方程
fprintf('\n=== 物理学应用：波动方程 ===\n');

% Define wave function (numerical)
wave_func = @(x, t) 2 * sin(2*x - 3*t);

% Compute wave at different times
x_wave = linspace(0, 4*pi, 200);
t_values = [0, pi/6, pi/3, pi/2];

figure('Name', '波动方程');
for i = 1:length(t_values)
    t_val = t_values(i);
    y_wave = wave_func(x_wave, t_val);
    plot(x_wave, y_wave, 'LineWidth', 2);
    hold on;
    fprintf('  t = %.4f: wave amplitude range [%.2f, %.2f]\n', t_val, min(y_wave), max(y_wave));
end
hold off;
title('波动方程: u = 2sin(2x - 3t)');
xlabel('x'); ylabel('u(x,t)');
legend('t=0', 't=\pi/6', 't=\pi/3', 't=\pi/2');
grid on;

%% 7. 工程应用：频率响应
fprintf('\n=== 工程应用：频率响应 ===\n');

% Define frequency response function (numerical)
H_func = @(omega, omega_n, zeta) 1 ./ sqrt((1 - (omega/omega_n).^2).^2 + (2*zeta*omega/omega_n).^2);

% Set parameters
omega_n_val = 1;
zeta_values = [0.1, 0.3, 0.5, 0.7, 1.0];

% Compute frequency response at resonance
omega_range = linspace(0, 3, 1000);

figure('Name', '频率响应');
for i = 1:length(zeta_values)
    zeta_val = zeta_values(i);
    H_val = H_func(omega_range, omega_n_val, zeta_val);
    plot(omega_range, H_val, 'LineWidth', 2);
    hold on;
    fprintf('  zeta = %.1f: peak amplitude = %.4f\n', zeta_val, max(H_val));
end
hold off;
title('频率响应函数');
xlabel('\omega/\omega_n'); ylabel('|H(\omega)|');
legend(arrayfun(@(z) sprintf('\\zeta = %.1f', z), zeta_values, 'UniformOutput', false));
grid on;
ylim([0, 6]);

fprintf('\n=== 函数分析示例完成 ===\n');
