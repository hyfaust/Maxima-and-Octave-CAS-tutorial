% Rayleigh Cavitation Bubble Problem - Octave Implementation
% 瑞利空化泡问题 - Octave实现
%
% 物理背景：不可压缩流体中突然出现一个球形空泡的瞬态问题
% 控制方程：Rayleigh-Plesset方程
%   R*R'' + (3/2)*(R')^2 = (p_v - p_inf) / rho
%
% 作者: CAS Learn Tutorial


%% 1. 符号推导Rayleigh-Plesset方程
fprintf('=== Rayleigh-Plesset方程符号推导 ===\n\n');

% 定义符号变量
syms R(t)
syms R0 R_dot R_ddot rho p_v p_inf sigma positive
syms r v_r p_r t_sym

% 从连续性方程出发：不可压缩球对称流动
% v_r(r,t) = R^2 * R_dot / r^2
% 其中R(t)是空泡半径，R_dot是空泡壁速度

% 伯努利方程（径向流动）
% p_r + rho/2 * v_r^2 + rho * integral(dv_r/dt, dr) = p_inf

% 在空泡壁 r = R 处：
% p_v + rho/2 * R_dot^2 - rho * R * R_ddot - rho * R^2 * R_dot / (2*R) ...
%   = p_inf （简化后）

% 推导Rayleigh-Plesset方程
fprintf('从连续性方程和伯努利方程推导：\n');
fprintf('  连续性方程（不可压缩）：v_r = R²·Ṙ/r²\n');
fprintf('  伯努利方程积分后得到：\n');
fprintf("  p_v - p_∞ = ρ·(R·R''̈ + 3/2·Ṙ²)\n\n");

% 定义Rayleigh-Plesset方程
R_P_eq = 'R*R_ddot + (3/2)*R_dot^2 == (p_v - p_inf)/rho';
fprintf("Rayleigh-Plesset方程:\n  %s\n\n", R_P_eq);

%% 2. 无量纲化
fprintf('=== 无量纲化 ===\n');

% 引入无量纲变量
% R* = R/R0,  t* = t/T,  T = R0 * sqrt(rho/(p_inf - p_v))
% 定义特征时间
syms T_char
T_char = R0 * sqrt(rho / (p_inf - p_v));
fprintf('特征时间 T = R₀·√(ρ/(p_∞-p_v))\n');

% 无量纲方程
% R*·d²R*/dt*² + 3/2·(dR*/dt*)² = -1
fprintf("无量纲方程：R*·R*'' + 3/2·(R*')² = -1\n");
fprintf("初始条件：R*(0) = 1,  R*'(0) = 0\n\n");

%% 3. 数值求解（无量纲形式）
fprintf('=== 数值求解 ===\n');

% 定义ODE系统：y(1) = R*, y(2) = dR*/dt*
% dy(1)/dt = y(2)
% dy(2)/dt = (-1 - 3/2*y(2)^2) / y(1)

% 定义右端函数
function dydt = rayleigh_ode(t, y)
  if y(1) <= 0.01  % 防止除零
    dydt = [0; 0];
  else
    dydt = [y(2); (-1 - 1.5*y(2)^2) / y(1)];
  end
end

% 初始条件
y0 = [1.0; 0.0];  % R*(0) = 1, R*'(0) = 0

% 时间区间（无量纲时间）
tspan = [0, 1.5];

% 使用ode45求解
opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[t, y] = ode45(@rayleigh_ode, tspan, y0, opts);

% 计算加速度
accel = (-1 - 1.5*y(:, 2).^2) ./ y(:, 1);

%% 4. 溃灭时间计算
fprintf('=== 溃灭时间分析 ===\n');

% 检测空泡半径接近零的时刻
idx_collapse = find(y(:, 1) < 0.01, 1);
if ~isempty(idx_collapse)
  fprintf('数值计算的溃灭时间: t*_c ≈ %.6f\n', t(idx_collapse));
else
  fprintf('在计算时间范围内未检测到完全溃灭\n');
  fprintf('最小半径 R* = %.6f at t* = %.4f\n', min(y(:, 1)), t(y(:, 1) == min(y(:, 1))));
end

% Rayleigh溃灭时间的解析近似
% t_c = 0.91468 * T_char
t_c_analytical = 0.91468;
fprintf('Rayleigh解析溃灭时间: t*_c ≈ %.5f\n', t_c_analytical);

%% 5. 物理参数示例
fprintf('\n=== 物理参数示例 ===\n');

% 典型参数
R0_phys = 1e-3;        % 初始半径 1mm
rho_phys = 1000;       % 水的密度 kg/m³
p_inf_phys = 1e5;      % 大气压力 Pa
p_v_phys = 2337;       % 水在20°C的蒸汽压 Pa

% 特征时间
T_char_phys = R0_phys * sqrt(rho_phys / (p_inf_phys - p_v_phys));
fprintf('初始半径 R₀ = %.1e m\n', R0_phys);
fprintf('流体密度 ρ = %.0f kg/m³\n', rho_phys);
fprintf('远场压力 p_∞ = %.0f Pa\n', p_inf_phys);
fprintf('蒸汽压力 p_v = %.0f Pa\n', p_v_phys);
fprintf('特征时间 T = %.4e s\n', T_char_phys);
fprintf('溃灭时间 t_c ≈ %.4e s\n', t_c_analytical * T_char_phys);

%% 6. Rayleigh渐近解（空泡壁接近溃灭时）
fprintf('\n=== 渐近分析 ===\n');
fprintf('当 R* → 0 时，R* ~ (t*_c - t*)^(2/5)\n');
fprintf('即溃灭速度趋于无穷（奇异性）\n');

fprintf('\n瑞利空化泡问题分析完成！\n');
