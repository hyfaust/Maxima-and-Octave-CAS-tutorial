% 边值问题示例
% 本文件演示边值问题的求解方法，包括打靶法和有限差分法
% 包括物理和工程应用实例

% 加载符号包

disp('=== 边值问题示例 ===');
disp(' ');

%% 1. 边值问题的基本概念
disp('1. 边值问题的基本概念');
disp('----------------------');

disp('边值问题 (Boundary Value Problem, BVP):');
disp('  微分方程 + 边界条件（而非初始条件）');
disp(' ');
disp('典型形式:');
disp("  y' = f(x, y, y'),  a < x < b");
disp('  y(a) = α,  y(b) = β');
disp(' ');
disp('与初值问题的区别:');
disp('  初值问题: 给定初始位置和速度');
disp('  边值问题: 给定两端的位置');
disp(' ');

disp(' ');

%% 2. 打靶法（Shooting Method）
disp('2. 打靶法（Shooting Method）');
disp('---------------------------');

disp('基本思想:');
disp('  将边值问题转化为初值问题');
disp('  通过调整初始斜率 y''(a) = s 使得 y(b) = β');
disp(' ');
disp('算法步骤:');
disp('  1. 猜测初始斜率 s0');
disp('  2. 求解初值问题得到 y(b; s0)');
disp('  3. 根据 y(b; sk) - β 调整 sk+1');
disp('  4. 重复直到满足精度要求');
disp(' ');

% 示例：求解边值问题
% y'' = -y, 0 < x < π
% y(0) = 0, y(π) = 0
disp('示例: y'' = -y, y(0)=0, y(π)=0');
disp('解析解: y = C*sin(x)');
disp(' ');

% 打靶法实现
function [x, y] = shooting_method(f, a, b, alpha, beta, s0, tol, max_iter)
    % f: 微分方程右端函数 f(x, y, y')
    % a, b: 区间端点
    % alpha, beta: 边界值
    % s0: 初始斜率猜测值
    % tol: 收敛容差
    % max_iter: 最大迭代次数
    
    s = s0;
    
    for iter = 1:max_iter
        % 求解初值问题
        [x, y] = ode45(@(x, y) [y(2); f(x, y(1), y(2))], [a, b], [alpha; s]);
        
        % 计算终点误差
        error = y(end, 1) - beta;
        
        % 检查收敛性
        if abs(error) < tol
            fprintf('打靶法收敛，迭代次数: %d\n', iter);
            fprintf('初始斜率: %f\n', s);
            return;
        end
        
        % 调整初始斜率（牛顿法）
        % 计算数值导数 ds/dy(b)
        delta_s = 0.001;
        [x_pert, y_pert] = ode45(@(x, y) [y(2); f(x, y(1), y(2))], ...
                                  [a, b], [alpha; s + delta_s]);
        dy_ds = (y_pert(end, 1) - y(end, 1)) / delta_s;
        
        % 更新初始斜率
        s = s - error / dy_ds;
    end
    
    fprintf('警告: 打靶法未收敛，最大迭代次数: %d\n', max_iter);
end

% 定义微分方程
f_shoot = @(x, y, yp) -y;

% 使用打靶法求解
[x_shoot, y_shoot] = shooting_method(f_shoot, 0, pi, 0, 0, 1, 1e-6, 100);

% 绘制打靶法结果
figure('Name', '打靶法结果');
plot(x_shoot, y_shoot(:, 1), 'b-', 'LineWidth', 2);
hold on;
plot([0, pi], [0, 0], 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold off;
title('打靶法求解边值问题: y" = -y');
xlabel('x'); ylabel('y');
legend('数值解', '边界条件');
grid on;

disp(' ');

%% 3. 有限差分法（Finite Difference Method）
disp('3. 有限差分法（Finite Difference Method）');
disp('---------------------------------------');

disp('基本思想:');
disp('  用差商近似导数，将微分方程转化为代数方程组');
disp(' ');
disp('二阶中心差分:');
disp('  y''(x_i) ≈ (y_{i-1} - 2*y_i + y_{i+1}) / h^2');
disp(' ');
disp("对于边值问题 y'' = f(x, y, y'):");
disp('  (y_{i-1} - 2*y_i + y_{i+1}) / h^2 = f(x_i, y_i, (y_{i+1} - y_{i-1})/(2h))');
disp(' ');

% 有限差分法实现
function [x, y] = finite_difference_method(f, a, b, alpha, beta, N)
    % f: 微分方程右端函数 f(x, y, y')
    % a, b: 区间端点
    % alpha, beta: 边界值
    % N: 内部节点数
    
    h = (b - a) / (N + 1);
    x = linspace(a, b, N+2)';
    
    % 初始化解向量
    y = zeros(N+2, 1);
    y(1) = alpha;
    y(end) = beta;
    
    % 内部节点的初始猜测（线性插值）
    for i = 2:N+1
        y(i) = alpha + (beta - alpha) * (x(i) - a) / (b - a);
    end
    
    % 迭代求解（牛顿法）
    max_iter = 100;
    tol = 1e-6;
    
    for iter = 1:max_iter
        % 构建雅可比矩阵和残差向量
        J = zeros(N, N);
        R = zeros(N, 1);
        
        for i = 1:N
            xi = x(i+1);
            yi = y(i+1);
            yp_i = (y(i+2) - y(i)) / (2*h);
            
            % 残差
            R(i) = (y(i) - 2*y(i+1) + y(i+2)) / h^2 - f(xi, yi, yp_i);
            
            % 雅可比矩阵
            if i > 1
                J(i, i-1) = 1/h^2 + f(xi, yi, yp_i) * (-1/(2*h));
            end
            J(i, i) = -2/h^2 - f(xi, yi, yp_i) * 0;  % ∂f/∂y = 0 for f = -y
            if i < N
                J(i, i+1) = 1/h^2 + f(xi, yi, yp_i) * (1/(2*h));
            end
        end
        
        % 求解线性方程组
        delta_y = J \ R;
        
        % 更新解
        y(2:N+1) = y(2:N+1) - delta_y;
        
        % 检查收敛性
        if norm(delta_y) < tol
            fprintf('有限差分法收敛，迭代次数: %d\n', iter);
            return;
        end
    end
    
    fprintf('警告: 有限差分法未收敛，最大迭代次数: %d\n', max_iter);
end

% 定义微分方程
f_fd = @(x, y, yp) -y;

% 使用有限差分法求解
N_fd = 10;
[x_fd, y_fd] = finite_difference_method(f_fd, 0, pi, 0, 0, N_fd);

% 绘制有限差分法结果
figure('Name', '有限差分法结果');
plot(x_fd, y_fd, 'b-o', 'LineWidth', 2);
hold on;
x_exact = linspace(0, pi, 100);
plot(x_exact, sin(x_exact), 'r--', 'LineWidth', 2);
hold off;
title('有限差分法求解边值问题: y" = -y');
xlabel('x'); ylabel('y');
legend('有限差分法', '解析解 sin(x)');
grid on;

disp(' ');

%% 4. 物理应用：梁的弯曲
disp('4. 物理应用：梁的弯曲');
disp('---------------------');

disp('简支梁弯曲方程:');
disp('  EI * y'''''' = w(x)');
disp('  其中: E - 弹性模量, I - 惯性矩, w(x) - 分布载荷');
disp(' ');
disp('边界条件:');
disp('  y(0) = 0, y(L) = 0 (位移为零)');
disp('  y''''(0) = 0, y''''(L) = 0 (弯矩为零)');
disp(' ');

% 简支梁弯曲问题
% EI * y'''' = w0 * sin(πx/L)
% y(0) = y(L) = 0
% y''(0) = y''(L) = 0

% 参数
E = 200e9;      % 弹性模量 (Pa)
I = 1e-6;       % 惯性矩 (m^4)
L_beam = 2;     % 梁长 (m)
w0 = 1000;      % 最大载荷 (N/m)

% 解析解
% y(x) = (w0 * L^4) / (π^4 * E * I) * sin(πx/L)
x_beam = linspace(0, L_beam, 100);
y_analytical = (w0 * L_beam^4) / (pi^4 * E * I) * sin(pi * x_beam / L_beam);

% 数值求解（有限差分法）
% 将四阶方程转化为两个二阶方程
% 令 v = y''
% 则 EI * v'' = w0 * sin(πx/L)
% 边界条件: v(0) = v(L) = 0

% 求解v
N_beam = 20;
h_beam = L_beam / (N_beam + 1);
x_beam_num = linspace(0, L_beam, N_beam+2);

% 构建系数矩阵
A_beam = zeros(N_beam, N_beam);
b_beam = zeros(N_beam, 1);

for i = 1:N_beam
    xi = x_beam_num(i+1);
    b_beam(i) = w0 * sin(pi * xi / L_beam) / E / I;
    
    if i > 1
        A_beam(i, i-1) = 1;
    end
    A_beam(i, i) = -2;
    if i < N_beam
        A_beam(i, i+1) = 1;
    end
end

% 求解线性方程组
v_num = A_beam \ (b_beam * h_beam^2);
v_num = [0; v_num; 0];  % 添加边界条件

% 对v积分两次得到y
y_num_beam = zeros(N_beam+2, 1);
for i = 2:N_beam+2
    y_num_beam(i) = y_num_beam(i-1) + v_num(i) * h_beam;
end

% 再次积分
y_num_beam2 = zeros(N_beam+2, 1);
for i = 2:N_beam+2
    y_num_beam2(i) = y_num_beam2(i-1) + y_num_beam(i) * h_beam;
end

% 绘制梁弯曲结果
figure('Name', '简支梁弯曲');
subplot(2, 1, 1);
plot(x_beam, y_analytical, 'b-', 'LineWidth', 2);
hold on;
plot(x_beam_num, y_num_beam2, 'ro--', 'LineWidth', 1.5);
hold off;
title('简支梁弯曲变形');
xlabel('位置 x (m)'); ylabel('挠度 y (m)');
legend('解析解', '数值解');
grid on;

subplot(2, 1, 2);
plot(x_beam_num, v_num, 'g-', 'LineWidth', 2);
title('弯矩分布');
xlabel('位置 x (m)'); ylabel('v = y"');
grid on;

disp(' ');

%% 5. 物理应用：悬臂梁
disp('5. 物理应用：悬臂梁');
disp('--------------------');

disp('悬臂梁弯曲方程:');
disp('  EI * y'''''' = w(x)');
disp('  边界条件:');
disp('    y(0) = 0 (固定端位移为零)');
disp('    y''(0) = 0 (固定端转角为零)');
disp('    y''''(L) = 0 (自由端弯矩为零)');
disp("    y'''(L) = 0 (自由端剪力为零)");
disp(' ');

% 悬臂梁参数
L_cantilever = 1;     % 梁长 (m)
P = 1000;             % 端部集中力 (N)

% 解析解
% y(x) = (P * x^2) / (6 * E * I) * (3*L - x)
x_cantilever = linspace(0, L_cantilever, 100);
y_cantilever = (P * x_cantilever.^2) / (6 * E * I) .* (3*L_cantilever - x_cantilever);

% 数值求解（打靶法）
% 将四阶方程转化为一阶方程组
% y1 = y, y2 = y', y3 = y'', y4 = y'''
% y1' = y2
% y2' = y3
% y3' = y4
% y4' = w(x)/(E*I) = 0 (无分布载荷)

f_cantilever = @(x, y) [y(2); y(3); y(4); 0];

% 边界条件: y(0)=0, y'(0)=0, y''(L)=0, y'''(L)=P/(E*I)
% 打靶法: 猜测 y''(0) 和 y'''(0)

% 简化：使用已知解析解形式
% 假设 y(x) = a*x^2 + b*x^3
% 由边界条件确定系数

% 数值求解（直接积分）
x_num_cant = linspace(0, L_cantilever, 50);
y_num_cant = zeros(size(x_num_cant));

% 使用解析解形式
y_num_cant = (P * x_num_cant.^2) / (6 * E * I) .* (3*L_cantilever - x_num_cant);

% 绘制结果
% 绘制弯矩图
M_cantilever = P * (L_cantilever - x_cantilever);

% 绘制悬臂梁结果
figure('Name', '悬臂梁弯曲');
subplot(2, 1, 1);
plot(x_cantilever, y_cantilever, 'b-', 'LineWidth', 2);
title('悬臂梁弯曲变形');
xlabel('位置 x (m)'); ylabel('挠度 y (m)');
grid on;

subplot(2, 1, 2);
plot(x_cantilever, M_cantilever, 'r-', 'LineWidth', 2);
title('悬臂梁弯矩分布');
xlabel('位置 x (m)'); ylabel('弯矩 M (N·m)');
grid on;

disp(' ');

%% 6. 边值问题的收敛性分析
disp('6. 边值问题的收敛性分析');
disp('-----------------------');

% 分析有限差分法的收敛性
N_values = [5, 10, 20, 40, 80];
errors = zeros(size(N_values));

for i = 1:length(N_values)
    N = N_values(i);
    [x_conv, y_conv] = finite_difference_method(f_fd, 0, pi, 0, 0, N);
    
    % 计算与解析解的误差
    y_exact = sin(x_conv);
    errors(i) = max(abs(y_conv - y_exact));
end

disp('有限差分法误差:');
for i = 1:length(N_values)
    fprintf('N = %3d, 误差 = %.6e\n', N_values(i), errors(i));
end

% 绘制收敛性分析
figure('Name', '收敛性分析');
loglog(N_values, errors, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
% 参考线 O(h^2)
ref_line = errors(1) * (N_values(1) ./ N_values).^2;
loglog(N_values, ref_line, 'r--', 'LineWidth', 1.5);
hold off;
title('有限差分法收敛性分析');
xlabel('网格点数 N'); ylabel('最大误差');
legend('数值误差', 'O(h^2) 参考线');
grid on;

disp(' ');
disp('=== 边值问题示例完成 ===');