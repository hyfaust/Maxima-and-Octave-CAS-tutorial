% =========================================================================
% 欧拉-拉格朗日方程 - Octave 实现
% =========================================================================
% 本文件演示欧拉-拉格朗日方程的推导和应用
% 需要安装 Octave 的符号包（symbolic）
% =========================================================================

% 加载符号包

% 清除工作空间
clear;
clc;

fprintf('========================================\n');
fprintf('      欧拉-拉格朗日方程示例\n');
fprintf('========================================\n\n');

% -------------------------------------------------------------------------
% 1. 欧拉-拉格朗日方程的一般形式
% -------------------------------------------------------------------------
% 对于泛函 J[y] = ∫_a^b F(x, y, y') dx
% 欧拉-拉格朗日方程为：
% ∂F/∂y - d/dx(∂F/∂y') = 0

% 定义符号变量
syms x y(x) C1 C2;

% 示例1：F = y^2 + y'^2
fprintf('1. 欧拉-拉格朗日方程的一般形式\n');
fprintf("   对于泛函 J[y] = ∫_a^b F(x, y, y') dx\n");
fprintf("   欧拉-拉格朗日方程为：∂F/∂y - d/dx(∂F/∂y') = 0\n\n");

% 示例1
F1 = y(x)^2 + diff(y(x), x)^2;
F1_y = diff(F1, y(x));
F1_yp = diff(F1, diff(y(x), x));
EL1 = F1_y - diff(F1_yp, x);

fprintf('   示例1：F = y^2 + y''^2\n');
fprintf('   ∂F/∂y = %s\n', char(F1_y));
fprintf('   ∂F/∂y'' = %s\n', char(F1_yp));
fprintf('   d/dx(∂F/∂y'') = %s\n', char(diff(F1_yp, x)));
fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n\n', char(EL1));

% -------------------------------------------------------------------------
% 2. 特殊形式的欧拉-拉格朗日方程
% -------------------------------------------------------------------------

fprintf('2. 特殊形式的欧拉-拉格朗日方程\n\n');

% 情况1：F 不显含 x
fprintf('   情况1：F 不显含 x\n');
fprintf("   如果 F = F(y, y')，则欧拉-拉格朗日方程可简化为：\n");
fprintf('   F - y'' * ∂F/∂y'' = C (贝尔特拉米恒等式)\n\n');

% 示例：F = y'^2 / y
F2 = diff(y(x), x)^2 / y(x);
F2_y = diff(F2, y(x));
F2_yp = diff(F2, diff(y(x), x));
EL2 = F2_y - diff(F2_yp, x);

% 计算贝尔特拉米恒等式
Beltrami = F2 - diff(y(x), x) * F2_yp;
Beltrami_simplified = simplify(Beltrami);

fprintf('   示例：F = y''^2 / y\n');
fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n', char(EL2));
fprintf('   贝尔特拉米恒等式：\n');
fprintf('   F - y'' * ∂F/∂y'' = %s = C\n\n', char(Beltrami_simplified));

% 情况2：F 不显含 y
fprintf('   情况2：F 不显含 y\n');
fprintf("   如果 F = F(x, y')，则欧拉-拉格朗日方程简化为：\n");
fprintf('   ∂F/∂y'' = C\n\n');

% 示例：F = y'^2 / x
F3 = diff(y(x), x)^2 / x;
F3_yp = diff(F3, diff(y(x), x));

fprintf('   示例：F = y''^2 / x\n');
fprintf('   ∂F/∂y'' = %s = C\n\n', char(F3_yp));

% 情况3：F 不显含 y'
fprintf('   情况3：F 不显含 y''\n');
fprintf('   如果 F = F(x, y)，则欧拉-拉格朗日方程简化为：\n');
fprintf('   ∂F/∂y = 0\n\n');

% 示例：F = x*y^2
F4 = x * y(x)^2;
F4_y = diff(F4, y(x));

fprintf('   示例：F = x*y^2\n');
fprintf('   ∂F/∂y = %s = 0\n\n', char(F4_y));

% -------------------------------------------------------------------------
% 3. 自然边界条件
% -------------------------------------------------------------------------
% 当边界值未指定时，需要添加自然边界条件

fprintf('3. 自然边界条件\n');
fprintf('   当边界值 y(a) 或 y(b) 未指定时，需要添加自然边界条件：\n');
fprintf('   ∂F/∂y''|_{x=a} = 0 或 ∂F/∂y''|_{x=b} = 0\n\n');

% 示例：J[y] = ∫_0^1 (y'^2 - 2*y) dx，y(0)=0，y(1) 自由
F5 = diff(y(x), x)^2 - 2*y(x);
F5_yp = diff(F5, diff(y(x), x));

fprintf('   示例：J[y] = ∫_0^1 (y''^2 - 2*y) dx，y(0)=0，y(1) 自由\n');
fprintf('   ∂F/∂y'' = %s\n', char(F5_yp));

% 欧拉-拉格朗日方程
F5_y = diff(F5, y(x));
EL5 = F5_y - diff(F5_yp, x);

fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n', char(EL5));
fprintf('   即：y'' = -1\n\n');

% 求解微分方程
y5_sol = dsolve(diff(y(x), 2) == -1, y(0) == 0);
y5_sol = simplify(y5_sol);
fprintf('   通解：y(x) = %s\n\n', char(y5_sol));

% 应用自然边界条件 ∂F/∂y''|_{x=1} = 0
% ∂F/∂y'' = 2*y'，所以 y'(1) = 0
% 从通解 y = -x^2/2 + C1*x + C2，有 y' = -x + C1
% y'(1) = -1 + C1 = 0 => C1 = 1
% y(0) = 0 => C2 = 0

y5_particular = -x^2/2 + x;
fprintf('   应用自然边界条件 y''(1) = 0：\n');
fprintf('   y(x) = %s\n\n', char(y5_particular));

% -------------------------------------------------------------------------
% 4. 包含高阶导数的欧拉-拉格朗日方程
% -------------------------------------------------------------------------
% 对于泛函 J[y] = ∫_a^b F(x, y, y', y'') dx
% 欧拉-拉格朗日方程为：
% ∂F/∂y - d/dx(∂F/∂y') + d^2/dx^2(∂F/∂y'') = 0

fprintf('4. 包含高阶导数的欧拉-拉格朗日方程\n');
fprintf("   对于泛函 J[y] = ∫_a^b F(x, y, y', y'') dx\n");
fprintf('   欧拉-拉格朗日方程为：\n');
fprintf('   ∂F/∂y - d/dx(∂F/∂y'') + d^2/dx^2(∂F/∂y'') = 0\n\n');

% 示例：F = y''^2
F6 = diff(y(x), 2)^2;
F6_y = diff(F6, y(x));
F6_yp = diff(F6, diff(y(x), 1));
F6_ypp = diff(F6, diff(y(x), 2));

% 计算各项
dF6_yp_dx = diff(F6_yp, x);
d2F6_ypp_dx2 = diff(F6_ypp, x, 2);

EL6 = F6_y - dF6_yp_dx + d2F6_ypp_dx2;

fprintf('   示例：F = y''^2\n');
fprintf('   ∂F/∂y = %s\n', char(F6_y));
fprintf('   ∂F/∂y'' = %s\n', char(F6_yp));
fprintf('   ∂F/∂y'' = %s\n', char(F6_ypp));
fprintf('   d/dx(∂F/∂y'') = %s\n', char(dF6_yp_dx));
fprintf('   d^2/dx^2(∂F/∂y'') = %s\n', char(d2F6_ypp_dx2));
fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n\n', char(EL6));

% 化简
EL6_simplified = simplify(EL6);
fprintf('   化简后：\n');
fprintf('   %s = 0\n\n', char(EL6_simplified));

% -------------------------------------------------------------------------
% 5. 等周问题
% -------------------------------------------------------------------------
% 等周问题：在满足约束条件 ∫G(x,y,y')dx = L 的函数中，
% 寻找使泛函 J[y] = ∫F(x,y,y')dx 取极值的函数

fprintf('5. 等周问题\n');
fprintf('   等周问题：在约束条件下求泛函极值\n');
fprintf("   约束条件：∫_a^b G(x, y, y') dx = L\n");
fprintf("   目标泛函：J[y] = ∫_a^b F(x, y, y') dx\n\n");
fprintf('   解法：引入拉格朗日乘子 λ，构造新泛函：\n');
fprintf('   J̃[y] = ∫_a^b (F + λG) dx\n');
fprintf('   然后求解欧拉-拉格朗日方程：\n');
fprintf("   ∂(F+λG)/∂y - d/dx(∂(F+λG)/∂y') = 0\n\n");

% 示例：在长度固定的曲线中，寻找面积最大的曲线
% 设曲线 y(x) 从 (0,0) 到 (1,0)，长度 L
% 约束条件：∫_0^1 √(1 + y'^2) dx = L
% 目标泛函（面积）：J[y] = ∫_0^1 y dx

syms lambda;
F7 = y(x);  % 目标泛函的被积函数
G7 = sqrt(1 + diff(y(x), x)^2);  % 约束条件的被积函数

% 构造拉格朗日函数
L7 = F7 + lambda * G7;
L7_y = diff(L7, y(x));
L7_yp = diff(L7, diff(y(x), x));
EL7 = L7_y - diff(L7_yp, x);

fprintf('   示例：在长度固定的曲线中，寻找面积最大的曲线\n');
fprintf('   目标泛函：J[y] = ∫_0^1 y dx\n');
fprintf('   约束条件：∫_0^1 √(1 + y''^2) dx = L\n\n');
fprintf('   拉格朗日函数：L = y + λ√(1 + y''^2)\n');
fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n\n', char(EL7));

% 化简
EL7_simplified = simplify(EL7);
fprintf('   化简后：\n');
fprintf('   %s = 0\n\n', char(EL7_simplified));

% -------------------------------------------------------------------------
% 6. 数值求解示例
% -------------------------------------------------------------------------
fprintf('6. 数值求解示例\n');
fprintf('   使用有限差分法求解欧拉-拉格朗日方程\n\n');

% 求解边值问题：y'' = -1，y(0)=0，y(1)=0
% 解析解：y = -x^2/2 + x/2

% 有限差分法
N = 10;  % 网格点数
h = 1/N;  % 步长
x_vals = linspace(0, 1, N+1);

% 构建系数矩阵
A = zeros(N-1, N-1);
b = zeros(N-1, 1);

for i = 1:N-1
    if i > 1
        A(i, i-1) = 1/h^2;
    end
    A(i, i) = -2/h^2;
    if i < N-1
        A(i, i+1) = 1/h^2;
    end
    b(i) = -1;  % 右端项
end

% 边界条件
b(1) = b(1) - 0/h^2;  % y(0) = 0
b(end) = b(end) - 0/h^2;  % y(1) = 0

% 求解线性方程组
y_numerical = A \ b;
y_numerical = [0; y_numerical; 0];  % 添加边界值

% 解析解
y_exact = -x_vals.^2/2 + x_vals/2;

% 计算误差
error = max(abs(y_numerical - y_exact'));

fprintf('   边值问题：y'''' = -1，y(0)=0，y(1)=0\n');
fprintf('   网格点数：N = %d\n', N);
fprintf('   最大误差：%.2e\n\n', error);

% 绘制结果
% 不同网格点数的误差
N_values = [5, 10, 20, 50, 100];
errors = zeros(size(N_values));

for k = 1:length(N_values)
    N = N_values(k);
    h = 1/N;
    x_vals = linspace(0, 1, N+1);
    
    A = zeros(N-1, N-1);
    b = zeros(N-1, 1);
    
    for i = 1:N-1
        if i > 1
            A(i, i-1) = 1/h^2;
        end
        A(i, i) = -2/h^2;
        if i < N-1
            A(i, i+1) = 1/h^2;
        end
        b(i) = -1;
    end
    
    b(1) = b(1) - 0/h^2;
    b(end) = b(end) - 0/h^2;
    
    y_numerical = A \ b;
    y_numerical = [0; y_numerical; 0];
    y_exact = -x_vals.^2/2 + x_vals/2;
    
    errors(k) = max(abs(y_numerical - y_exact'));
end

% 显示收敛阶
fprintf('   误差收敛性：\n');
for k = 1:length(N_values)
    fprintf('   N = %3d, 误差 = %.2e\n', N_values(k), errors(k));
end

% 计算收敛阶
p = polyfit(log(N_values), log(errors), 1);
fprintf('\n   收敛阶：O(h^%.1f)\n\n', -p(1));

% 绘制收敛性分析
figure('Name', '欧拉-拉格朗日方程数值求解');
subplot(2, 2, 1);
plot(x_vals, y_numerical, 'b-', 'LineWidth', 2);
hold on;
plot(x_vals, y_exact, 'r--', 'LineWidth', 2);
hold off;
title('数值解 vs 解析解 (N=10)');
xlabel('x'); ylabel('y');
legend('数值解', '解析解');
grid on;

subplot(2, 2, 2);
loglog(N_values, errors, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
ref_line = errors(1) * (N_values(1) ./ N_values).^2;
loglog(N_values, ref_line, 'r--', 'LineWidth', 1.5);
hold off;
title('误差收敛性');
xlabel('网格点数 N'); ylabel('最大误差');
legend('数值误差', 'O(h^2) 参考线');
grid on;

% -------------------------------------------------------------------------
% 7. 总结
% -------------------------------------------------------------------------
fprintf('========================================\n');
fprintf('            总结\n');
fprintf('========================================\n');
fprintf('1. 欧拉-拉格朗日方程是变分法的核心\n');
fprintf('2. 有多种特殊形式可以简化计算\n');
fprintf('3. 自然边界条件处理自由边界\n');
fprintf('4. 高阶导数情况需要扩展方程\n');
fprintf('5. 等周问题使用拉格朗日乘子法\n');
fprintf('6. 数值方法可以求解复杂问题\n\n');

fprintf('示例完成。\n');