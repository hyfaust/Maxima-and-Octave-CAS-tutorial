% Simple Flow Solutions
% 简单流动解
%
% 物理背景：
%   求解几种经典的层流流动解析解
%   包括管道流动（Poiseuille）、平板间流动（Couette）、
%   低Reynolds数流动（Stokes）和势流绕圆柱
%   这些解是流体力学的基础，也是验证数值方法的标准算例
%
% 作者: CAS Learn Tutorial


%% 1. Poiseuille流动（圆管中的层流）
fprintf('=== Poiseuille流动（圆管层流） ===\n\n');

% 物理描述：粘性流体在恒定压力梯度驱动下在圆管中的稳态流动
% 假设：稳态、不可压缩、充分发展、轴对称
% 坐标：柱坐标 (r, θ, z)，流动方向为z

syms r z mu_dp positive
syms R_pipe positive         % 管道半径
syms dpdz                    % 压力梯度 dp/dz (负值，驱动流动)
syms mu_pipe positive        % 动力粘度

% 控制方程（简化后的z方向动量方程）
% 0 = -dp/dz + μ(1/r)d/dr(r·dv_z/dr)
% 边界条件：v_z(R) = 0（无滑移），v_z(0) 有限

% 求解ODE
% d/dr(r·dv_z/dr) = (r/μ)(dp/dz)
% 积分两次，应用边界条件

% 解析解
v_z_poiseuille = -(dpdz) / (4 * mu_pipe) * (R_pipe^2 - r^2);

fprintf('Poiseuille流动解:\n');
fprintf('  控制方程: 0 = -dp/dz + μ(1/r)d/dr(r·dv_z/dr)\n');
fprintf('  边界条件: v_z(R) = 0, v_z(0) 有限\n\n');
fprintf('  速度分布: v_z(r) = -(1/4μ)(dp/dz)(R² - r²)\n');
fprintf('  即: %s\n\n', char(v_z_poiseuille));

% 最大速度（在管道中心 r=0）
v_max = -dpdz * R_pipe^2 / (4 * mu_pipe);
fprintf('最大速度（中心线）:\n');
fprintf('  v_max = -(R²/4μ)(dp/dz) = %s\n\n', char(v_max));

% 体积流量（对截面积分）
% Q = ∫₀ᴿ v_z(r)·2πr·dr
Q_flow = int(v_z_poiseuille * 2 * sym(pi) * r, r, 0, R_pipe);
Q_flow = simplify(Q_flow);
fprintf('体积流量（Hagen-Poiseuille定律）:\n');
fprintf('  Q = ∫₀ᴿ v_z·2πr·dr = %s\n', char(Q_flow));
fprintf('  Q = (πR⁴/8μ)|dp/dz|\n\n');

% 平均速度
v_avg = Q_flow / (sym(pi) * R_pipe^2);
v_avg = simplify(v_avg);
fprintf('平均速度:\n');
fprintf('  v_avg = Q/(πR²) = %s\n', char(v_avg));
fprintf('  即 v_avg = v_max / 2\n\n');

% 壁面剪应力
tau_wall = mu_pipe * subs(diff(v_z_poiseuille, r), r, R_pipe);
tau_wall = simplify(tau_wall);
fprintf('壁面剪应力:\n');
fprintf('  τ_w = μ(dv_z/dr)|_(r=R) = %s\n', char(tau_wall));
fprintf('  τ_w = (R/2)|dp/dz|\n\n');

% 摩擦系数
% f = 64/Re (Darcy摩擦系数)
syms Re_p positive
fprintf('摩擦系数:\n');
fprintf('  Darcy摩擦系数: f = 64/Re\n');
fprintf('  其中 Re = ρ·v_avg·D/μ, D = 2R\n\n');


%% 3. Couette流动（平行平板间流动）
fprintf('=== Couette流动（平行平板间流动） ===\n\n');

% 物理描述：两平行平板间的粘性流动
% 下板固定，上板以速度U运动
% 可能同时存在压力梯度驱动

syms y_c U_plate h positive   % y坐标、上板速度、板间距
syms K_param                   % 压力梯度参数 K = -(h²/2μ)(dp/dx)

% 控制方程
% 0 = dp/dx + μ·d²v_x/dy²
% 边界条件：v_x(0) = 0, v_x(h) = U

% 一般Couette-Poiseuille组合解
% v_x(y) = U(y/h) + (h²/2μ)(-dp/dx)(y/h)(1 - y/h)
v_x_couette = U_plate * (y_c / h) + ...
    (h^2 / (2 * mu_pipe)) * (-dpdz) * (y_c / h) * (1 - y_c / h);

fprintf('Couette-Poiseuille组合流动:\n');
fprintf('  下板 y=0 固定，上板 y=h 以速度U运动\n');
fprintf('  同时存在压力梯度 dp/dx\n\n');
fprintf('  速度分布: v_x(y) = U(y/h) + (h²/2μ)(-dp/dx)(y/h)(1-y/h)\n\n');

% 纯Couette流动（无压力梯度）
v_x_pure_couette = U_plate * y_c / h;
fprintf('纯Couette流动（dp/dx = 0）:\n');
fprintf('  v_x(y) = U·y/h （线性分布）\n');
fprintf('  剪应力: τ = μU/h = 常数\n\n');

% 纯Poiseuille流动（无上板运动）
v_x_pure_poiseuille = (h^2 / (2 * mu_pipe)) * (-dpdz) * (y_c / h) * (1 - y_c / h);
fprintf('纯压力驱动流动（U = 0）:\n');
fprintf('  v_x(y) = (h²/2μ)(-dp/dx)(y/h)(1-y/h)\n');
fprintf('  最大速度在 y = h/2: v_max = (h²/8μ)(-dp/dx)\n');
fprintf('  平均速度: v_avg = (2/3)v_max\n\n');


%% 5. Stokes流动（低Reynolds数流动）
fprintf('=== Stokes流动（低Reynolds数流动） ===\n\n');

% Stokes方程：0 = -∇p + μ∇²v
% 特点：忽略惯性项，方程线性化

% Stokes第一问题：突然启动的平板（Stokes振荡层）
% ∂u/∂t = ν·∂²u/∂y²
% 边界条件：u(0,t) = U, u(y,0) = 0, u(∞,t) = 0

syms eta_st positive   % 相似变量
syms nu_st positive    % 运动粘度

% 解析解（用误差函数表示）
% u(y,t) = U·erfc(y/(2√(νt)))
% 或用相似变量 η = y/(2√(νt)): u = U·erfc(η)

fprintf('Stokes第一问题（突然启动平板）:\n');
fprintf('  控制方程: ∂u/∂t = ν·∂²u/∂y²\n');
fprintf('  边界条件: u(0,t) = U, u(y,0) = 0, u(∞,t) = 0\n');
fprintf('  解析解: u(y,t) = U·erfc(y/(2√(νt)))\n');
fprintf('  相似变量: η = y/(2√(νt))\n');
fprintf('  无量纲解: u/U = erfc(η)\n\n');

% Stokes层厚度
% δ ~ √(νt)
fprintf('Stokes层厚度:\n');
fprintf('  δ ~ √(νt)\n');
fprintf('  粘性扩散的特征尺度\n\n');

% 数值计算Stokes第一问题
nu_val = 0.01;   % 运动粘度
U_wall = 1.0;    % 壁面速度

y_stokes = linspace(0, 0.5, 100);
t_vals = [0.01, 0.05, 0.1, 0.5];

for t_val = t_vals
    eta = y_stokes / (2 * sqrt(nu_val * t_val));
    u_stokes = U_wall * erfc(eta);
end

%% 6. Stokes流动 - 绕球流动
fprintf('\n=== Stokes流动 - 绕球流动 ===\n\n');

% Stokes绕球流动的解
% 适用于 Re = ρUd/μ << 1

syms a_sphere positive    % 球半径
syms U_inf_s positive     % 来流速度
syms r_s theta_s positive

% 速度场（球坐标）
% v_r = U·cos(θ)[1 - (3a)/(2r) + a³/(2r³)]
% v_θ = -U·sin(θ)[1 - (3a)/(4r) - a³/(4r³)]

v_r_stokes = U_inf_s * cos(theta_s) * (1 - 3*a_sphere/(2*r_s) + a_sphere^3/(2*r_s^3));
v_theta_stokes = -U_inf_s * sin(theta_s) * (1 - 3*a_sphere/(4*r_s) - a_sphere^3/(4*r_s^3));

fprintf('Stokes绕球流动解:\n');
fprintf('  v_r = U·cos(θ)[1 - 3a/(2r) + a³/(2r³)]\n');
fprintf('  v_θ = -U·sin(θ)[1 - 3a/(4r) - a³/(4r³)]\n\n');

% Stokes阻力公式（阻力 = 6πμaU）
D_stokes = 6 * sym(pi) * mu_pipe * a_sphere * U_inf_s;
fprintf('Stokes阻力公式:\n');
fprintf('  D = 6πμaU\n');
fprintf('  阻力系数: C_D = 24/Re\n\n');

% 修正：Oseen近似（考虑部分惯性效应）
% D = 6πμaU(1 + 3Re/16)
syms Re_s positive
D_oseen = D_stokes * (1 + 3 * Re_s / 16);
fprintf('Oseen修正:\n');
fprintf('  D = 6πμaU(1 + 3Re/16)\n');
fprintf('  适用于 Re < 1 的修正\n\n');

%% 7. 势流绕圆柱（补充详细分析）
fprintf('=== 势流绕圆柱（详细分析） ===\n\n');

% 复势：W(z) = U(z + a²/z)
% 速度分量（柱坐标）
% v_r = U(1 - a²/r²)cos(θ)
% v_θ = -U(1 + a²/r²)sin(θ)

syms a_cyl positive
syms U_inf positive
syms theta

v_r_potential = U_inf * (1 - a_cyl^2/r^2) * cos(theta);
v_theta_potential = -U_inf * (1 + a_cyl^2/r^2) * sin(theta);

fprintf('势流绕圆柱速度场:\n');
fprintf('  v_r = U(1 - a²/r²)cos(θ)\n');
fprintf('  v_θ = -U(1 + a²/r²)sin(θ)\n\n');

% 圆柱表面速度
v_theta_surface = subs(v_theta_potential, r, a_cyl);
fprintf('圆柱表面速度 (r = a):\n');
fprintf('  v_θ = -2U·sin(θ)\n');
fprintf('  v_r = 0\n\n');

% 速度在驻点为零
fprintf('驻点位置: θ = 0 和 θ = π (前驻点和后驻点)\n\n');

% 压力系数
% Cp = 1 - (v/U)² = 1 - 4sin²(θ)
Cp = 1 - 4 * sin(theta)^2;
fprintf('压力系数分布:\n');
fprintf('  Cp(θ) = 1 - 4sin²(θ)\n');
fprintf('  前驻点 θ=0: Cp = 1（总压）\n');
fprintf('  侧壁 θ=π/2: Cp = -3（最大吸力）\n');
fprintf('  后驻点 θ=π: Cp = 1（总压恢复）\n\n');

% 总阻力（d'Alembert佯谬）
% 对压力积分得到零阻力
fprintf("d'Alembert佯谬:\n");
fprintf('  理想流体势流理论预测：圆柱阻力为零\n');
fprintf('  这与实验不符，因为忽略了粘性和流动分离\n');
fprintf('  实际流动中，边界层分离导致压差阻力\n\n');

%% 8. Hagen-Poiseuille流动数值解
fprintf('=== Hagen-Poiseuille流动数值解 ===\n\n');

% 用有限差分法求解圆管流动
% 方程: μ(1/r)d/dr(r·dv_z/dr) = dp/dz

N_r = 50;             % 径向网格数
R_num = 1.0;          % 管道半径
dr = R_num / N_r;
r_num = linspace(dr/2, R_num - dr/2, N_r)';  % 单元中心
dpdz_num = -1.0;      % 压力梯度
mu_num = 1.0;         % 粘度

% 构建系数矩阵
% 对于每个内部节点 i:
% μ/r_i * [(r_{i+1/2}(v_{i+1}-v_i)/dr - r_{i-1/2}(v_i-v_{i-1})/dr)] / dr = dpdz

A = zeros(N_r, N_r);
b = zeros(N_r, 1);

for i = 1:N_r
    r_plus = r_num(i) + dr/2;
    r_minus = r_num(i) - dr/2;

    if i == 1
        % 内部节点（对称边界条件：dv/dr = 0 at r = 0）
        A(i, i) = -mu_num * (r_plus + r_minus) / (r_num(i) * dr^2);
        A(i, i+1) = mu_num * r_plus / (r_num(i) * dr^2);
    elseif i == N_r
        % 壁面节点（无滑移：v = 0）
        A(i, i) = 1;
        b(i) = 0;
    else
        % 内部节点
        A(i, i-1) = mu_num * r_minus / (r_num(i) * dr^2);
        A(i, i) = -mu_num * (r_plus + r_minus) / (r_num(i) * dr^2);
        A(i, i+1) = mu_num * r_plus / (r_num(i) * dr^2);
    end

    if i < N_r
        b(i) = dpdz_num;
    end
end

% 求解
v_numerical = A \ b;

% 解析解
v_analytical = -dpdz_num / (4 * mu_num) * (R_num^2 - r_num.^2);

% 误差分析
error = abs(v_numerical - v_analytical) ./ abs(v_analytical) * 100;
error(1) = 0;  % 中心点误差设为0（解析解不为零）

fprintf('数值解与解析解的最大相对误差: %.4f%%\n', max(error(2:end)));
fprintf('有限差分法求解圆管流动完成！\n\n');

%% 9. 总结
fprintf('=== 简单流动解总结 ===\n\n');
fprintf('流动类型        | 特征参数    | 速度分布         | 应用\n');
fprintf('----------------|-------------|------------------|------------------\n');
fprintf('Poiseuille (管) | Re < 2300   | 抛物线           | 管道流动\n');
fprintf('Couette (板)    | 任意Re      | 线性+抛物线      | 润滑、测量\n');
fprintf('Stokes (球)     | Re << 1     | 解析解           | 微流体、粉尘\n');
fprintf('势流 (圆柱)     | 理想流体    | 解析解           | 理论分析\n\n');

fprintf('简单流动解分析完成！\n');
