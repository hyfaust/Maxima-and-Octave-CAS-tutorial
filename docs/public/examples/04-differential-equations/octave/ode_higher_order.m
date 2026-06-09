% 高阶常微分方程示例
% 本文件演示如何使用Octave求解高阶常微分方程
% 包括常系数线性齐次/非齐次方程

% 加载符号包

disp('=== 高阶常微分方程示例 ===');
disp(' ');

%% 1. 二阶常系数线性齐次方程
disp('1. 二阶常系数线性齐次方程: y'' - 3y'' + 2y = 0');
disp('-----------------------------------------------');

% 定义符号变量
syms x y(x)

% 定义微分方程
ode1 = diff(y, x, 2) - 3*diff(y, x) + 2*y == 0;

% 求解微分方程
y1_sol = dsolve(ode1);
disp('通解:');
disp(y1_sol);

% 求满足初始条件 y(0)=1, y'(0)=0 的特解
Dy = diff(y, x);
y1_specific = dsolve(ode1, y(0) == 1, Dy(0) == 0);
disp('满足 y(0)=1, y''(0)=0 的特解:');
disp(y1_specific);

% 绘制特解曲线
% 绘制解及其导数
disp(' ');
disp(' ');

%% 2. 二阶常系数线性非齐次方程
disp('2. 二阶常系数线性非齐次方程: y'' - 3y'' + 2y = e^{3x}');
disp('-----------------------------------------------------');

% 定义微分方程
ode2 = diff(y, x, 2) - 3*diff(y, x) + 2*y == exp(3*x);

% 求解微分方程
y2_sol = dsolve(ode2);
disp('通解:');
disp(y2_sol);

% 求满足初始条件 y(0)=0, y'(0)=1 的特解
y2_specific = dsolve(ode2, y(0) == 0, Dy(0) == 1);
disp('满足 y(0)=0, y''(0)=1 的特解:');
disp(y2_specific);

% 绘制特解曲线
disp(' ');
disp(' ');

%% 3. 阻尼振动示例（物理应用）
disp('3. 阻尼振动: y'' + 0.5y'' + 4y = 0');
disp('----------------------------------');

% 定义微分方程（阻尼振动）
ode3 = diff(y, x, 2) + 0.5*diff(y, x) + 4*y == 0;

% 求解微分方程
y3_sol = dsolve(ode3);
disp('通解:');
disp(y3_sol);

% 求满足初始条件 y(0)=1, y'(0)=0 的特解
y3_specific = dsolve(ode3, y(0) == 1, Dy(0) == 0);
disp('满足 y(0)=1, y''(0)=0 的特解:');
disp(y3_specific);

disp(' ');
disp(' ');

%% 4. 受迫振动示例（物理应用）
disp('4. 受迫振动: y'' + 0.1y'' + y = cos(t)');
disp('------------------------------------');

% 定义微分方程（受迫振动）
ode4 = diff(y, x, 2) + 0.1*diff(y, x) + y == cos(x);

% 求解微分方程
y4_sol = dsolve(ode4);
disp('通解:');
disp(y4_sol);

% 求满足初始条件 y(0)=0, y'(0)=0 的特解
y4_specific = dsolve(ode4, y(0) == 0, Dy(0) == 0);
disp('满足 y(0)=0, y''(0)=0 的特解:');
disp(y4_specific);

disp(' ');
disp(' ');

%% 5. 数值求解高阶ODE
disp('5. 数值求解高阶ODE');
disp('-------------------');

% 将二阶ODE转化为一阶ODE系统
% y'' + 0.5y' + 4y = 0
% 令 y1 = y, y2 = y'
% 则 y1' = y2, y2' = -0.5*y2 - 4*y1

f_system = @(t, y) [y(2); -0.5*y(2) - 4*y(1)];

% 初始条件
y0 = [1; 0]; % y(0)=1, y'(0)=0

% 时间范围
tspan = [0, 20];

% 使用ode45求解
[t, y_num] = ode45(f_system, tspan, y0);

disp(' ');
disp(' ');

%% 6. 高阶ODE的参数研究
disp('6. 高阶ODE的参数研究');
disp('--------------------');

% 研究不同阻尼系数对振动的影响
damping_coefficients = [0.1, 0.5, 1.0, 2.0];

for i = 1:length(damping_coefficients)
    c = damping_coefficients(i);

    % 定义微分方程
    ode_param = diff(y, x, 2) + c*diff(y, x) + 4*y == 0;

    % 求解
    y_param = dsolve(ode_param, y(0) == 1, Dy(0) == 0);

    fprintf('  c = %.1f: y(x) = %s\n', c, char(y_param));
end

disp(' ');
disp('=== 高阶ODE示例完成 ===');