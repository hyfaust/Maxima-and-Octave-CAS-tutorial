% 偏微分方程基础示例
% 本文件演示偏微分方程的基本概念和数值求解方法
% 包括分类、经典方程和分离变量法

% 加载符号包

disp('=== 偏微分方程基础示例 ===');
disp(' ');

%% 1. 偏微分方程的分类
disp('1. 偏微分方程的分类');
disp('------------------');

% 二阶线性PDE的一般形式: A*u_xx + 2B*u_xy + C*u_yy + D*u_x + E*u_y + F*u = G
% 判别式: Δ = B^2 - A*C

disp('二阶线性偏微分方程分类:');
disp('  A*u_xx + 2B*u_xy + C*u_yy + ... = 0');
disp('  判别式 Δ = B^2 - A*C');
disp('  Δ > 0: 双曲型 (波动方程)');
disp('  Δ = 0: 抛物型 (热传导方程)');
disp('  Δ < 0: 椭圆型 (拉普拉斯方程)');
disp(' ');

% 示例：波动方程 u_tt = c^2 * u_xx
disp('波动方程: u_tt = c^2 * u_xx');
disp('  A = c^2, B = 0, C = -1');
disp('  Δ = 0^2 - c^2 * (-1) = c^2 > 0 → 双曲型');
disp(' ');

% 示例：热传导方程 u_t = k * u_xx
disp('热传导方程: u_t = k * u_xx');
disp('  A = k, B = 0, C = 0, D = 0, E = 1, F = 0');
disp('  Δ = 0^2 - k*0 = 0 → 抛物型');
disp(' ');

% 示例：拉普拉斯方程 u_xx + u_yy = 0
disp('拉普拉斯方程: u_xx + u_yy = 0');
disp('  A = 1, B = 0, C = 1');
disp('  Δ = 0^2 - 1*1 = -1 < 0 → 椭圆型');
disp(' ');

disp(' ');

%% 2. 一维波动方程的分离变量法
disp('2. 一维波动方程的分离变量法');
disp('---------------------------');

disp('考虑初边值问题:');
disp('  u_tt = c^2 * u_xx,  0 < x < L, t > 0');
disp('  u(0,t) = u(L,t) = 0,  t > 0');
disp('  u(x,0) = f(x),  u_t(x,0) = 0,  0 < x < L');
disp(' ');

disp('分离变量: 设 u(x,t) = X(x)T(t)');
disp('代入方程得: X*T'' = c^2 * X''*T');
disp('分离变量: T''/(c^2*T) = X''/X = -λ');
disp(' ');

disp('得到两个常微分方程:');
disp('  X'' + λX = 0,  X(0) = X(L) = 0');
disp('  T'' + c^2*λT = 0');
disp(' ');

disp('求解X的方程（特征值问题）:');
disp('  特征值: λ_n = (nπ/L)^2, n = 1,2,3,...');
disp('  特征函数: X_n(x) = sin(nπx/L)');
disp(' ');

disp('求解T的方程:');
disp('  T_n(t) = A_n*cos(nπct/L) + B_n*sin(nπct/L)');
disp('  由初始条件 u_t(x,0)=0 得 B_n = 0');
disp(' ');

disp('通解: u(x,t) = Σ A_n * sin(nπx/L) * cos(nπct/L)');
disp('  其中 A_n = (2/L) * ∫_0^L f(x)*sin(nπx/L) dx');
disp(' ');

disp(' ');

%% 3. 数值求解一维波动方程
disp('3. 数值求解一维波动方程');
disp('------------------------');

% 参数设置
L = 1;          % 弦长
c = 1;          % 波速
T_max = 2;      % 最大时间
Nx = 50;        % 空间步数
Nt = 100;       % 时间步数

dx = L / Nx;
dt = T_max / Nt;
r = c * dt / dx;  % CFL数

% 网格
x = linspace(0, L, Nx+1);
t = linspace(0, T_max, Nt+1);

% 初始条件: f(x) = sin(πx)
f = sin(pi * x);

% 初始化解矩阵
u = zeros(Nx+1, Nt+1);

% 初始条件
u(:, 1) = f;
u(:, 2) = f;  % u_t(x,0) = 0

% 边界条件
u(1, :) = 0;
u(end, :) = 0;

% 有限差分法求解
for n = 2:Nt
    for i = 2:Nx
        u(i, n+1) = 2*u(i, n) - u(i, n-1) + r^2 * (u(i+1, n) - 2*u(i, n) + u(i-1, n));
    end
end

% 绘制波动方程解
figure('Name', '一维波动方程');
subplot(2, 1, 1);
[X_plot, T_plot] = meshgrid(t, x);
surf(X_plot, T_plot, u);
title('一维波动方程数值解');
xlabel('时间 t'); ylabel('位置 x'); zlabel('u(x,t)');
shading interp;
colorbar;

subplot(2, 1, 2);
plot(x, u(:, 1), 'b-', 'LineWidth', 2);
hold on;
plot(x, u(:, round(Nt/4)+1), 'r--', 'LineWidth', 2);
plot(x, u(:, round(Nt/2)+1), 'g-.', 'LineWidth', 2);
plot(x, u(:, Nt+1), 'm:', 'LineWidth', 2);
hold off;
legend('t=0', 't=T/4', 't=T/2', 't=T');
title('波动方程不同时刻的解');
xlabel('位置 x'); ylabel('u(x,t)');
grid on;

disp(' ');

%% 4. 数值求解一维热传导方程
disp('4. 数值求解一维热传导方程');
disp('------------------------');

disp('考虑初边值问题:');
disp('  u_t = k * u_xx,  0 < x < L, t > 0');
disp('  u(0,t) = u(L,t) = 0,  t > 0');
disp('  u(x,0) = f(x),  0 < x < L');
disp(' ');

% 参数设置
L = 1;          % 长度
k = 0.01;       % 热扩散系数
T_max = 10;     % 最大时间
Nx = 50;        % 空间步数
Nt = 1000;      % 时间步数

dx = L / Nx;
dt = T_max / Nt;
r = k * dt / dx^2;  % 稳定性条件: r ≤ 0.5

% 网格
x_heat = linspace(0, L, Nx+1);
t_heat = linspace(0, T_max, Nt+1);

% 初始条件: f(x) = sin(πx)
f_heat = sin(pi * x_heat);

% 初始化解矩阵
u_heat = zeros(Nx+1, Nt+1);

% 初始条件
u_heat(:, 1) = f_heat;

% 边界条件
u_heat(1, :) = 0;
u_heat(end, :) = 0;

% 显式有限差分法求解
for n = 1:Nt
    for i = 2:Nx
        u_heat(i, n+1) = u_heat(i, n) + r * (u_heat(i+1, n) - 2*u_heat(i, n) + u_heat(i-1, n));
    end
end

% 绘制热传导方程解
figure('Name', '一维热传导方程');
subplot(2, 1, 1);
[X_h, T_h] = meshgrid(t_heat, x_heat);
surf(X_h, T_h, u_heat);
title('一维热传导方程数值解');
xlabel('时间 t'); ylabel('位置 x'); zlabel('u(x,t)');
shading interp;
colorbar;

subplot(2, 1, 2);
plot(x_heat, u_heat(:, 1), 'b-', 'LineWidth', 2);
hold on;
plot(x_heat, u_heat(:, round(Nt/4)+1), 'r--', 'LineWidth', 2);
plot(x_heat, u_heat(:, round(Nt/2)+1), 'g-.', 'LineWidth', 2);
plot(x_heat, u_heat(:, Nt+1), 'm:', 'LineWidth', 2);
hold off;
legend('t=0', 't=T/4', 't=T/2', 't=T');
title('热传导方程不同时刻的解');
xlabel('位置 x'); ylabel('u(x,t)');
grid on;

disp(' ');

%% 5. 二维拉普拉斯方程
disp('5. 二维拉普拉斯方程');
disp('-------------------');

disp('拉普拉斯方程: ∂²u/∂x² + ∂²u/∂y² = 0');
disp('在矩形区域 [0,L]×[0,H] 上求解');
disp('边界条件: u(0,y)=u(L,y)=0, u(x,0)=0, u(x,H)=f(x)');
disp(' ');

% 分离变量法求解
disp('分离变量: u(x,y) = X(x)Y(y)');
disp('得到: X''/X = -Y''/Y = -λ');
disp(' ');
disp('X的方程: X'' + λX = 0, X(0)=X(L)=0');
disp('  特征值: λ_n = (nπ/L)^2');
disp('  特征函数: X_n(x) = sin(nπx/L)');
disp(' ');
disp('Y的方程: Y'' - λY = 0');
disp('  通解: Y_n(y) = A_n*sinh(nπy/L) + B_n*cosh(nπy/L)');
disp('  由边界条件 Y(0)=0 得 B_n = 0');
disp('  所以 Y_n(y) = A_n*sinh(nπy/L)');
disp(' ');
disp('通解: u(x,y) = Σ A_n * sin(nπx/L) * sinh(nπy/L)');
disp('  其中 A_n = (2/(L*sinh(nπH/L))) * ∫_0^L f(x)*sin(nπx/L) dx');
disp(' ');

% 数值求解二维拉普拉斯方程
disp('数值求解二维拉普拉斯方程...');

% 参数设置
Lx = 1;        % x方向长度
Ly = 1;        % y方向长度
Nx = 20;       % x方向步数
Ny = 20;       % y方向步数
max_iter = 1000; % 最大迭代次数
tol = 1e-6;    % 收敛容差

dx = Lx / Nx;
dy = Ly / Ny;

% 网格
x_lap = linspace(0, Lx, Nx+1);
y_lap = linspace(0, Ly, Ny+1);

% 初始化解矩阵
u_lap = zeros(Nx+1, Ny+1);

% 边界条件
u_lap(:, 1) = 0;           % u(x,0) = 0
u_lap(:, end) = sin(pi*x_lap'); % u(x,H) = sin(πx)
u_lap(1, :) = 0;           % u(0,y) = 0
u_lap(end, :) = 0;         % u(L,y) = 0

% 迭代求解（Jacobi迭代）
for iter = 1:max_iter
    u_old = u_lap;
    
    for i = 2:Nx
        for j = 2:Ny
            u_lap(i, j) = 0.25 * (u_old(i+1, j) + u_old(i-1, j) + ...
                                   u_old(i, j+1) + u_old(i, j-1));
        end
    end
    
    % 检查收敛性
    error = max(max(abs(u_lap - u_old)));
    if error < tol
        fprintf('Jacobi迭代收敛，迭代次数: %d\n', iter);
        break;
    end
end

% 绘制拉普拉斯方程解
figure('Name', '二维拉普拉斯方程');
subplot(1, 2, 1);
[X_lap_plot, Y_lap_plot] = meshgrid(x_lap, y_lap);
surf(X_lap_plot, Y_lap_plot, u_lap');
title('二维拉普拉斯方程数值解');
xlabel('x'); ylabel('y'); zlabel('u(x,y)');
shading interp;
colorbar;

subplot(1, 2, 2);
contour(X_lap_plot, Y_lap_plot, u_lap', 20);
title('拉普拉斯方程等高线图');
xlabel('x'); ylabel('y');
colorbar;
grid on;

disp(' ');
disp('=== 偏微分方程基础示例完成 ===');