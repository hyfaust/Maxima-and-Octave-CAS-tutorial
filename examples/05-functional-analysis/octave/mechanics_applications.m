% =========================================================================
% 力学中的应用 - Octave 实现
% =========================================================================
% 本文件演示变分法在力学中的应用，包括拉格朗日力学和哈密顿力学
% 需要安装 Octave 的符号包（symbolic）
% =========================================================================

% 加载符号包

% 清除工作空间
clear;
clc;

fprintf('========================================\n');
fprintf('        力学中的应用示例\n');
fprintf('========================================\n\n');

% -------------------------------------------------------------------------
% 1. 拉格朗日力学基础
% -------------------------------------------------------------------------
% 拉格朗日函数 L = T - V，其中 T 是动能，V 是势能
% 哈密顿原理：系统的实际运动路径使作用量泛函 S = ∫L dt 取极值
% 欧拉-拉格朗日方程：∂L/∂q - d/dt(∂L/∂q̇) = 0

% 定义符号变量
syms t q(t) m g k L0;

fprintf('1. 拉格朗日力学基础\n');
fprintf('   拉格朗日函数：L = T - V\n');
fprintf('   哈密顿原理：作用量 S = ∫L dt 取极值\n');
fprintf('   运动方程：∂L/∂q - d/dt(∂L/∂q̇) = 0\n\n');

% 示例1：自由粒子
fprintf('   示例1：自由粒子\n');
fprintf('   动能：T = m*q̇^2/2\n');
fprintf('   势能：V = 0\n\n');

% 自由粒子的拉格朗日函数
T_free = m * diff(q(t), t)^2 / 2;
V_free = 0;
L_free = T_free - V_free;

% 计算运动方程
L_free_q = diff(L_free, q(t));
L_free_qt = diff(L_free, diff(q(t), t));
EL_free = L_free_q - diff(L_free_qt, t);

fprintf('   拉格朗日函数：L = %s\n', char(L_free));
fprintf('   运动方程：\n');
fprintf('   %s = 0\n', char(simplify(EL_free)));
fprintf('   即：m*q̈ = 0\n\n');

% -------------------------------------------------------------------------
% 2. 简谐振子
% -------------------------------------------------------------------------
% 简谐振子：质量为 m 的质点连接到弹簧常数为 k 的弹簧
% 动能：T = m*q̇^2/2
% 势能：V = k*q^2/2

fprintf('2. 简谐振子\n');
fprintf('   简谐振子：质量为 m，弹簧常数为 k\n');
fprintf('   动能：T = m*q̇^2/2\n');
fprintf('   势能：V = k*q^2/2\n\n');

% 简谐振子的拉格朗日函数
T_harm = m * diff(q(t), t)^2 / 2;
V_harm = k * q(t)^2 / 2;
L_harm = T_harm - V_harm;

% 计算运动方程
L_harm_q = diff(L_harm, q(t));
L_harm_qt = diff(L_harm, diff(q(t), t));
EL_harm = L_harm_q - diff(L_harm_qt, t);

fprintf('   拉格朗日函数：L = %s\n', char(L_harm));
fprintf('   运动方程：\n');
fprintf('   %s = 0\n', char(simplify(EL_harm)));
fprintf('   即：m*q̈ + k*q = 0\n\n');

% 求解微分方程
q_harm = dsolve(m*diff(q(t), 2) + k*q(t) == 0);
q_harm = simplify(q_harm);

fprintf('   解析解：\n');
fprintf('   q(t) = %s\n\n', char(q_harm));

% 特解：q(0) = A，q̇(0) = 0
omega = sqrt(k/m);
q_harm_particular = dsolve(m*diff(q(t), 2) + k*q(t) == 0, q(0) == sym('A'), diff(q)(0) == 0);
q_harm_particular = simplify(q_harm_particular);

fprintf('   特解（q(0)=A，q̇(0)=0）：\n');
fprintf('   q(t) = %s\n\n', char(q_harm_particular));

% -------------------------------------------------------------------------
% 3. 单摆
% -------------------------------------------------------------------------
% 单摆：长度为 l 的轻杆，末端质量为 m
% 广义坐标：θ（与垂直方向的夹角）
% 动能：T = m*l^2*θ̇^2/2
% 势能：V = -m*g*l*cos(θ)

fprintf('3. 单摆\n');
fprintf('   单摆：长度 l，质量 m\n');
fprintf('   广义坐标：θ（与垂直方向的夹角）\n');
fprintf('   动能：T = m*l^2*θ̇^2/2\n');
fprintf('   势能：V = -m*g*l*cos(θ)\n\n');

% 定义符号变量
syms theta(t) l m g;

% 单摆的拉格朗日函数
T_pend = m * l^2 * diff(theta(t), t)^2 / 2;
V_pend = -m * g * l * cos(theta(t));
L_pend = T_pend - V_pend;

% 计算运动方程
L_pend_q = diff(L_pend, theta(t));
L_pend_qt = diff(L_pend, diff(theta(t), t));
EL_pend = L_pend_q - diff(L_pend_qt, t);

fprintf('   拉格朗日函数：L = %s\n', char(L_pend));
fprintf('   运动方程：\n');
fprintf('   %s = 0\n', char(simplify(EL_pend)));
fprintf('   即：l*θ̈ + g*sin(θ) = 0\n\n');

% 小角度近似：sin(θ) ≈ θ
fprintf('   小角度近似（sin(θ) ≈ θ）：\n');
EL_pend_small = subs(simplify(EL_pend), sin(theta(t)), theta(t));
EL_pend_small = simplify(EL_pend_small);
fprintf('   %s = 0\n', char(EL_pend_small));
fprintf('   即：l*θ̈ + g*θ = 0\n\n');

% 求解小角度近似下的运动方程
theta_small = dsolve(l*diff(theta(t), 2) + g*theta(t) == 0);
theta_small = simplify(theta_small);

fprintf('   小角度近似下的解：\n');
fprintf('   θ(t) = %s\n\n', char(theta_small));

% -------------------------------------------------------------------------
% 4. 耦合振子
% -------------------------------------------------------------------------
% 两个质量为 m 的质点，由三个弹簧连接
% 广义坐标：x1, x2
% 动能：T = m*(ẋ1^2 + ẋ2^2)/2
% 势能：V = k*x1^2/2 + k*(x2-x1)^2/2 + k*x2^2/2

fprintf('4. 耦合振子\n');
fprintf('   两个质量为 m 的质点，由三个弹簧连接\n');
fprintf('   广义坐标：x1, x2\n');
fprintf('   动能：T = m*(ẋ1^2 + ẋ2^2)/2\n');
fprintf('   势能：V = k*x1^2/2 + k*(x2-x1)^2/2 + k*x2^2/2\n\n');

% 定义符号变量
syms x1(t) x2(t) m k;

% 耦合振子的拉格朗日函数
T_coupled = m * (diff(x1(t), t)^2 + diff(x2(t), t)^2) / 2;
V_coupled = k * x1(t)^2 / 2 + k * (x2(t) - x1(t))^2 / 2 + k * x2(t)^2 / 2;
L_coupled = T_coupled - V_coupled;

% 计算运动方程
% 对于 x1
L_x1 = diff(L_coupled, x1(t));
L_x1t = diff(L_coupled, diff(x1(t), t));
EL_x1 = L_x1 - diff(L_x1t, t);

% 对于 x2
L_x2 = diff(L_coupled, x2(t));
L_x2t = diff(L_coupled, diff(x2(t), t));
EL_x2 = L_x2 - diff(L_x2t, t);

fprintf('   拉格朗日函数：L = %s\n', char(L_coupled));
fprintf('   运动方程：\n');
fprintf('   对于 x1：\n');
fprintf('   %s = 0\n', char(simplify(EL_x1)));
fprintf('   对于 x2：\n');
fprintf('   %s = 0\n\n', char(simplify(EL_x2)));

% 化简
EL_x1_simplified = simplify(EL_x1);
EL_x2_simplified = simplify(EL_x2);

fprintf('   化简后：\n');
fprintf('   对于 x1：\n');
fprintf('   %s = 0\n', char(EL_x1_simplified));
fprintf('   对于 x2：\n');
fprintf('   %s = 0\n\n', char(EL_x2_simplified));

% -------------------------------------------------------------------------
% 5. 哈密顿力学
% -------------------------------------------------------------------------
% 定义广义动量 p = ∂L/∂q̇
% 哈密顿量 H = p*q̇ - L
% 哈密顿正则方程：q̇ = ∂H/∂p，ṗ = -∂H/∂q

fprintf('5. 哈密顿力学\n');
fprintf('   广义动量：p = ∂L/∂q̇\n');
fprintf('   哈密顿量：H = p*q̇ - L\n');
fprintf('   正则方程：q̇ = ∂H/∂p，ṗ = -∂H/∂q\n\n');

% 示例：简谐振子的哈密顿力学
fprintf('   示例：简谐振子的哈密顿力学\n\n');

% 定义独立的广义坐标和广义动量（不使用q(t)函数）
syms q_h p_h;

% 拉格朗日函数（用广义速度表示）
% L = m*qdot^2/2 - k*q_h^2/2
% 广义动量: p_h = m*qdot => qdot = p_h/m

fprintf('   拉格朗日函数：L = m*q̇^2/2 - k*q^2/2\n');
fprintf('   广义动量：p = m*q̇\n');

% 解出 q̇
qdot = p_h / m;

fprintf('   解出 q̇：q̇ = p/m\n\n');

% 哈密顿量 H = p*q̇ - L
H_harm = p_h * qdot - (m * qdot^2 / 2 - k * q_h^2 / 2);
H_harm = simplify(H_harm);

fprintf('   哈密顿量：H = %s\n\n', char(H_harm));

% 哈密顿正则方程
H_q = diff(H_harm, q_h);
H_p = diff(H_harm, p_h);

fprintf('   哈密顿正则方程：\n');
fprintf('   q̇ = ∂H/∂p = %s\n', char(H_p));
fprintf('   ṗ = -∂H/∂q = %s\n\n', char(-H_q));

% -------------------------------------------------------------------------
% 6. 最速降线问题
% -------------------------------------------------------------------------
% 最速降线问题：在重力场中，寻找从点 A 到点 B 的曲线，
% 使得质点沿该曲线滑下的时间最短

fprintf('6. 最速降线问题\n');
fprintf('   最速降线问题：在重力场中，寻找从点 A 到点 B 的曲线，\n');
fprintf('   使得质点沿该曲线滑下的时间最短\n\n');

% 设曲线为 y(x)，从 (0,0) 到 (1,h)
% 质点的速度由能量守恒给出：v = √(2gy)
% 滑下时间泛函：T[y] = ∫_0^1 √(1 + y'^2)/√(2gy) dx

% 定义符号变量
syms x y(x) g h;

% 被积函数
F_brach = sqrt(1 + diff(y(x), x)^2) / sqrt(2*g*y(x));

fprintf('   设曲线为 y(x)，从 (0,0) 到 (1,h)\n');
fprintf('   速度：v = √(2gy)\n');
fprintf('   时间泛函：T[y] = ∫_0^1 √(1 + y''^2)/√(2gy) dx\n\n');

% 计算欧拉-拉格朗日方程
F_brach_y = diff(F_brach, y(x));
F_brach_yp = diff(F_brach, diff(y(x), x));
EL_brach = F_brach_y - diff(F_brach_yp, x);

fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n\n', char(simplify(EL_brach)));

% 由于 F 不显含 x，使用贝尔特拉米恒等式
Beltrami_brach = F_brach - diff(y(x), x) * F_brach_yp;
Beltrami_brach_simplified = simplify(Beltrami_brach);

fprintf('   由于 F 不显含 x，使用贝尔特拉米恒等式：\n');
fprintf('   F - y''*∂F/∂y'' = C\n');
fprintf('   %s = C\n\n', char(Beltrami_brach_simplified));

% 解析解是摆线
fprintf('   解析解：摆线\n');
fprintf('   x = a*(θ - sin(θ))\n');
fprintf('   y = a*(1 - cos(θ))\n');
fprintf('   其中 a 由边界条件确定\n\n');

% -------------------------------------------------------------------------
% 7. 悬链线问题
% -------------------------------------------------------------------------
% 悬链线问题：在重力场中，寻找两端固定、长度固定的柔软链条
% 在平衡状态下的形状

fprintf('7. 悬链线问题\n');
fprintf('   悬链线问题：在重力场中，寻找两端固定、长度固定的柔软链条\n');
fprintf('   在平衡状态下的形状\n\n');

% 设链条密度为 ρ，长度为 L，两端点为 (x1,y1) 和 (x2,y2)
% 势能泛函：V[y] = ρg ∫ y√(1 + y'^2) dx
% 约束条件：∫ √(1 + y'^2) dx = L

% 定义符号变量
syms x y(x) rho g L_chain lambda;

% 势能泛函的被积函数
F_chain = rho * g * y(x) * sqrt(1 + diff(y(x), x)^2);

% 约束条件的被积函数
G_chain = sqrt(1 + diff(y(x), x)^2);

% 拉格朗日函数
L_chain_func = F_chain + lambda * G_chain;

fprintf('   设链条密度为 ρ，长度为 L\n');
fprintf('   势能泛函：V[y] = ρg ∫ y√(1 + y''^2) dx\n');
fprintf('   约束条件：∫ √(1 + y''^2) dx = L\n\n');

fprintf('   拉格朗日函数：L = ρgy√(1 + y''^2) + λ√(1 + y''^2)\n');

% 计算欧拉-拉格朗日方程
L_chain_y = diff(L_chain_func, y(x));
L_chain_yp = diff(L_chain_func, diff(y(x), x));
EL_chain = L_chain_y - diff(L_chain_yp, x);

fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n\n', char(simplify(EL_chain)));

% 解析解是悬链线
fprintf('   解析解：悬链线\n');
fprintf('   y = a*cosh((x-x0)/a) + y0\n');
fprintf('   其中 a, x0, y0 由边界条件和长度约束确定\n\n');

% -------------------------------------------------------------------------
% 8. 数值求解：有限元方法
% -------------------------------------------------------------------------
% 使用有限元方法求解简单的一维问题

fprintf('8. 数值求解：有限元方法\n');
fprintf('   使用有限元方法求解简单的一维问题\n\n');

% 求解边值问题：-y'' = f(x)，y(0)=0，y(1)=0
% 其中 f(x) = 6x

fprintf('   求解边值问题：-y'' = 6x，y(0)=0，y(1)=0\n\n');

% 解析解
fprintf('   解析解：y = x - x^3\n\n');

% 有限元方法
% 使用线性基函数
N = 10;  % 单元数
h = 1/N;  % 单元长度
x_nodes = linspace(0, 1, N+1)';

% 刚度矩阵
K = zeros(N+1, N+1);
f = zeros(N+1, 1);

for e = 1:N
    % 单元节点
    n1 = e;
    n2 = e+1;
    
    % 单元刚度矩阵
    k_e = [1, -1; -1, 1] / h;
    
    % 单元载荷向量
    x_mid = (x_nodes(n1) + x_nodes(n2)) / 2;
    f_e = [6*x_mid; 6*x_mid] * h / 2;
    
    % 组装
    K(n1:n2, n1:n2) = K(n1:n2, n1:n2) + k_e;
    f(n1:n2) = f(n1:n2) + f_e;
end

% 应用边界条件
% y(0) = 0, y(1) = 0
K(1, :) = 0; K(1, 1) = 1; f(1) = 0;
K(end, :) = 0; K(end, end) = 1; f(end) = 0;

% 求解
y_fem = K \ f;

% 解析解
y_exact = x_nodes - x_nodes.^3;

% 计算误差
error_fem = max(abs(y_fem - y_exact));

fprintf('   有限元方法结果：\n');
fprintf('   节点数：N+1 = %d\n', N+1);
fprintf('   最大误差：%.2e\n\n', error_fem);

% 不同单元数的误差
N_values = [5, 10, 20, 50, 100];
errors_fem = zeros(size(N_values));

for ki = 1:length(N_values)
    N = N_values(ki);
    h = 1/N;
    x_nodes = linspace(0, 1, N+1)';

    K_fem = zeros(N+1, N+1);
    f_fem = zeros(N+1, 1);

    for e = 1:N
        n1 = e;
        n2 = e+1;

        k_e = [1, -1; -1, 1] / h;
        x_mid = (x_nodes(n1) + x_nodes(n2)) / 2;
        f_e = [6*x_mid; 6*x_mid] * h / 2;

        K_fem(n1:n2, n1:n2) = K_fem(n1:n2, n1:n2) + k_e;
        f_fem(n1:n2) = f_fem(n1:n2) + f_e;
    end

    K_fem(1, :) = 0; K_fem(1, 1) = 1; f_fem(1) = 0;
    K_fem(end, :) = 0; K_fem(end, end) = 1; f_fem(end) = 0;

    y_fem = K_fem \ f_fem;
    y_exact = x_nodes - x_nodes.^3;

    errors_fem(ki) = max(abs(y_fem - y_exact));
end

fprintf('   有限元方法收敛性：\n');
for ki = 1:length(N_values)
    fprintf('   N = %3d, 误差 = %.2e\n', N_values(ki), errors_fem(ki));
end

% 计算收敛阶
p_fem = polyfit(log(N_values), log(errors_fem), 1);
fprintf('\n   收敛阶：O(h^%.1f)\n\n', -p_fem(1));

% -------------------------------------------------------------------------
% 9. 总结
% -------------------------------------------------------------------------
fprintf('========================================\n');
fprintf('            总结\n');
fprintf('========================================\n');
fprintf('1. 拉格朗日力学：L = T - V，运动方程由欧拉-拉格朗日方程给出\n');
fprintf('2. 哈密顿力学：正则方程描述系统演化\n');
fprintf('3. 最速降线问题：摆线是最速降线\n');
fprintf('4. 悬链线问题：悬链线是平衡形状\n');
fprintf('5. 有限元方法：数值求解边值问题\n\n');

fprintf('示例完成。\n');