% 一阶常微分方程示例
% 本文件演示如何使用Octave求解一阶常微分方程
% 包括可分离变量方程、线性方程和恰当方程

% 加载符号包

disp('=== 一阶常微分方程示例 ===');
disp(' ');

%% 1. 可分离变量方程示例
disp('1. 可分离变量方程: dy/dx = x*y');
disp('--------------------------------');

% 定义符号变量
syms x y(x)

% 定义微分方程
ode1 = diff(y, x) == x * y;

% 求解微分方程
y1_sol = dsolve(ode1);
disp('通解:');
disp(y1_sol);

% 求满足初始条件 y(0)=2 的特解
y1_specific = dsolve(ode1, y(0) == 2);
disp('满足 y(0)=2 的特解:');
disp(y1_specific);

% 绘制解曲线
% 绘制不同C值的解曲线
disp(' ');
disp(' ');

%% 2. 线性微分方程示例
disp('2. 一阶线性微分方程: dy/dx + (2/x)*y = x^2');
disp('-------------------------------------------');

% 定义微分方程
P = 2/x;
Q = x^2;
ode2 = diff(y, x) + P * y == Q;

% 求解微分方程
y2_sol = dsolve(ode2);
disp('通解:');
disp(y2_sol);

% 求满足初始条件 y(1)=1 的特解
y2_specific = dsolve(ode2, y(1) == 1);
disp('满足 y(1)=1 的特解:');
disp(y2_specific);

% 绘制特解曲线
disp(' ');
disp(' ');

%% 3. 恰当微分方程示例
disp('3. 恰当微分方程: (2xy + 3)dx + (x^2 - 1)dy = 0');
disp('-----------------------------------------------');

% 验证恰当性
M = 2*x*y + 3;
N = x^2 - 1;

% 计算偏导数（手动，因为 y 是 y(x) 函数形式）
dM_dy = sym(2)*x;
dN_dx = 2*x;

disp('∂M/∂y = ');
disp(dM_dy);
disp('∂N/∂x = ');
disp(dN_dx);

if isequal(dM_dy, dN_dx)
    disp('方程是恰当的');
else
    disp('方程不是恰当的');
end

% 求解恰当方程
% 对M关于x积分得到F（y 视为常数）
% ∫(2xy + 3)dx = x^2*y + 3x
F_x = x^2 * sym('y') + 3*x;
disp('F = ∫M dx = x^2*y + 3x');

% ∂F/∂y = x^2
dF_dy = x^2;
disp('∂F/∂y = x^2');

% g'(y) = N - ∂F/∂y = x^2 - 1 - x^2 = -1
% g(y) = -y
g_y = -sym('y');
disp('g(y) = -y');

% 完整的F
F_complete = F_x + g_y;
disp('F(x,y) = x^2*y + 3x - y');

% 通解
disp('通解: F(x,y) = C');
disp('x^2*y + 3x - y = C');

disp(' ');
disp(' ');

%% 4. 数值求解示例
disp('4. 数值求解一阶ODE');
disp('-------------------');

% 定义ODE函数
f = @(t, y) -2*y + sin(t);

% 设置初始条件和时间范围
tspan = [0, 10];
y0 = 1;

% 使用ode45求解
[t, y] = ode45(f, tspan, y0);

% 计算解析解（如果存在）
syms t_sym y_sym(t_sym)
ode_sym = diff(y_sym, t_sym) == -2*y_sym + sin(t_sym);
y_analytical = dsolve(ode_sym, y_sym(0) == 1);
disp('解析解:');
disp(y_analytical);

% 比较数值解和解析解
y_analytical_handle = matlabFunction(y_analytical, 'vars', {t_sym});
max_error = max(abs(y - y_analytical_handle(t)));
fprintf('数值解与解析解的最大误差: %.2e\n', max_error);

% 绘制数值解和解析解对比
figure('Name', '一阶ODE数值解与解析解');
plot(t, y, 'b-', 'LineWidth', 2);
hold on;
t_fine = linspace(0, 10, 500);
plot(t_fine, y_analytical_handle(t_fine), 'r--', 'LineWidth', 2);
hold off;
title('一阶ODE: dy/dt = -2y + sin(t)');
xlabel('t'); ylabel('y');
legend('数值解 (ode45)', '解析解');
grid on;

disp(' ');
disp('=== 一阶ODE示例完成 ===');