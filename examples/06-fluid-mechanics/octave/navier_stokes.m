% Navier-Stokes Equations - Symbolic Representation
% Navier-Stokes方程 - 符号表示
%
% 物理背景：描述粘性不可压缩流体运动的基本方程组
% 由质量守恒（连续性方程）和动量守恒（N-S方程）组成
% 是流体力学中最核心的控制方程
%
% 作者: CAS Learn Tutorial


%% 1. 笛卡尔坐标系中的N-S方程
fprintf('=== 笛卡尔坐标系中的Navier-Stokes方程 ===\n\n');

% 定义符号变量
syms x y z t_sym positive
syms rho mu positive         % 密度和动力粘度
syms u_func(x,y,z,t_sym) v_func(x,y,z,t_sym) w_func(x,y,z,t_sym)  % 速度分量
syms p_func(x,y,z,t_sym)     % 压力
syms f_x f_y f_z             % 体积力分量

% 连续性方程（质量守恒）：∇·v = 0
% 对于不可压缩流体，密度为常数
continuity_eq = diff(u_func, x) + diff(v_func, y) + diff(w_func, z);
fprintf('连续性方程（不可压缩）:\n');
fprintf('  ∇·v = ∂u/∂x + ∂v/∂y + ∂w/∂z = 0\n');
fprintf('  符号形式: %s = 0\n\n', char(continuity_eq));

% 动量方程（N-S方程）的各个分量
% ρ(∂v/∂t + v·∇v) = -∇p + μ∇²v + f
% 其中 ∇² = ∂²/∂x² + ∂²/∂y² + ∂²/∂z² 是拉普拉斯算子

% x方向动量方程
laplacian_u = diff(u_func, x, 2) + diff(u_func, y, 2) + diff(u_func, z, 2);
momentum_x = rho * (diff(u_func, t_sym) + ...
    u_func * diff(u_func, x) + v_func * diff(u_func, y) + w_func * diff(u_func, z)) ...
    + diff(p_func, x) - mu * laplacian_u - f_x;

fprintf('x方向动量方程:\n');
fprintf('  ρ(∂u/∂t + u∂u/∂x + v∂u/∂y + w∂u/∂z) = -∂p/∂x + μ∇²u + f_x\n\n');

% y方向动量方程
laplacian_v = diff(v_func, x, 2) + diff(v_func, y, 2) + diff(v_func, z, 2);
momentum_y = rho * (diff(v_func, t_sym) + ...
    u_func * diff(v_func, x) + v_func * diff(v_func, y) + w_func * diff(v_func, z)) ...
    + diff(p_func, y) - mu * laplacian_v - f_y;

% z方向动量方程
laplacian_w = diff(w_func, x, 2) + diff(w_func, y, 2) + diff(w_func, z, 2);
momentum_z = rho * (diff(w_func, t_sym) + ...
    u_func * diff(w_func, x) + v_func * diff(w_func, y) + w_func * diff(w_func, z)) ...
    + diff(p_func, z) - mu * laplacian_w - f_z;

fprintf('完整的N-S方程组（笛卡尔坐标）:\n');
fprintf('  连续性: ∂u/∂x + ∂v/∂y + ∂w/∂z = 0\n');
fprintf('  x动量:  ρDu/Dt = -∂p/∂x + μ∇²u + f_x\n');
fprintf('  y动量:  ρDv/Dt = -∂p/∂y + μ∇²v + f_y\n');
fprintf('  z动量:  ρDw/Dt = -∂p/∂z + μ∇²w + f_z\n');
fprintf('  其中 D/Dt = ∂/∂t + v·∇ 是物质导数\n\n');

%% 2. 柱坐标系中的N-S方程
fprintf('=== 柱坐标系中的Navier-Stokes方程 ===\n\n');

% 柱坐标 (r, θ, z)
syms r theta z_cyl positive
syms v_r_func(r, theta, z_cyl, t_sym)
syms v_theta_func(r, theta, z_cyl, t_sym)
syms v_z_func(r, theta, z_cyl, t_sym)
syms p_cyl(r, theta, z_cyl, t_sym)

fprintf('柱坐标系 (r, θ, z) 中的方程:\n\n');

% 柱坐标连续性方程
% (1/r)∂(r·v_r)/∂r + (1/r)∂v_θ/∂θ + ∂v_z/∂z = 0
fprintf('连续性方程:\n');
fprintf('  (1/r)∂(r·v_r)/∂r + (1/r)∂v_θ/∂θ + ∂v_z/∂z = 0\n\n');

% 柱坐标r方向动量方程
fprintf('r方向动量方程:\n');
fprintf('  ρ(∂v_r/∂t + v_r∂v_r/∂r + (v_θ/r)∂v_r/∂θ - v_θ²/r + v_z∂v_r/∂z)\n');
fprintf('    = -∂p/∂r + μ[∇²v_r - v_r/r² - (2/r²)∂v_θ/∂θ]\n\n');

% 柱坐标θ方向动量方程
fprintf('θ方向动量方程:\n');
fprintf('  ρ(∂v_θ/∂t + v_r∂v_θ/∂r + (v_θ/r)∂v_θ/∂θ + v_r·v_θ/r + v_z∂v_θ/∂z)\n');
fprintf('    = -(1/r)∂p/∂θ + μ[∇²v_θ + (2/r²)∂v_r/∂θ - v_θ/r²]\n\n');

% 柱坐标z方向动量方程
fprintf('z方向动量方程:\n');
fprintf('  ρ(∂v_z/∂t + v_r∂v_z/∂r + (v_θ/r)∂v_z/∂θ + v_z∂v_z/∂z)\n');
fprintf('    = -∂p/∂z + μ∇²v_z\n\n');

% 柱坐标拉普拉斯算子
fprintf('柱坐标拉普拉斯算子:\n');
fprintf('  ∇² = (1/r)∂/∂r(r∂/∂r) + (1/r²)∂²/∂θ² + ∂²/∂z²\n\n');

%% 3. 二维不可压缩流函数形式
fprintf('=== 二维不可压缩流函数形式 ===\n\n');

% 对于二维不可压缩流动，自动满足连续性方程
syms psi(x, y, t_sym)   % 流函数
syms omega(x, y, t_sym)  % 涡量

% 速度与流函数的关系
% u = ∂ψ/∂y,  v = -∂ψ/∂x
u_from_psi = diff(psi, y);
v_from_psi = -diff(psi, x);

fprintf('流函数定义:\n');
fprintf('  u = ∂ψ/∂y,  v = -∂ψ/∂x\n');
fprintf('  自动满足连续性方程: ∂u/∂x + ∂v/∂y = 0\n\n');

% 验证连续性方程自动满足
check_continuity = diff(u_from_psi, x) + diff(v_from_psi, y);
fprintf('验证: ∂u/∂x + ∂v/∂y = %s = 0 ✓\n\n', char(simplify(check_continuity)));

%% 4. 涡量-流函数方程
fprintf('=== 涡量-流函数方程 ===\n\n');

% 涡量定义：ω = ∂v/∂x - ∂u/∂y
% 用流函数表示：ω = -∇²ψ
omega_from_psi = -(diff(psi, x, 2) + diff(psi, y, 2));
fprintf('涡量-流函数关系:\n');
fprintf('  ω = ∂v/∂x - ∂u/∂y = -∇²ψ\n');
fprintf('  即: ∇²ψ = -ω\n\n');

% 涡量输运方程（二维不可压缩）
% ∂ω/∂t + u∂ω/∂x + v∂ω/∂y = ν∇²ω
% 其中 ν = μ/ρ 是运动粘度
syms nu positive   % 运动粘度

fprintf('涡量输运方程:\n');
fprintf('  ∂ω/∂t + u∂ω/∂x + v∂ω/∂y = ν∇²ω\n');
fprintf('  用流函数表示:\n');
fprintf('  ∂ω/∂t + ∂ψ/∂y·∂ω/∂x - ∂ψ/∂x·∂ω/∂y = ν∇²ω\n\n');

% 流函数形式的完整方程组
fprintf('流函数-涡量形式的完整方程组:\n');
fprintf('  (1) ∇²ψ = -ω          （运动学关系）\n');
fprintf('  (2) ∂ω/∂t + {ψ,ω} = ν∇²ω  （涡量输运）\n');
fprintf('  其中 {ψ,ω} = ∂ψ/∂y·∂ω/∂x - ∂ψ/∂x·∂ω/∂y 是Poisson括号\n\n');

%% 5. Stokes方程（低Reynolds数近似）
fprintf('=== Stokes方程（低Reynolds数近似） ===\n\n');

% 当 Re << 1 时，忽略非线性对流项
% 简化为：0 = -∇p + μ∇²v
fprintf('Stokes方程（忽略惯性项）:\n');
fprintf('  0 = -∇p + μ∇²v\n');
fprintf('  连续性: ∇·v = 0\n\n');

% Stokes方程的流函数形式
% ∇⁴ψ = 0 （双调和方程）
fprintf('流函数形式（双调和方程）:\n');
fprintf('  ∇⁴ψ = 0\n');
fprintf('  即 ∇²(∇²ψ) = 0\n\n');

%% 6. 无量纲形式
fprintf('=== 无量纲N-S方程 ===\n\n');

% 引入特征量：L（长度）, U（速度）, T=L/U（时间）, P=ρU²（压力）
% 无量纲变量：x* = x/L, v* = v/U, p* = p/(ρU²), t* = t/(L/U)

syms Re positive   % Reynolds数

fprintf('无量纲形式（用 * 表示无量纲量）:\n');
fprintf('  ∇*·v* = 0\n');
fprintf('  ∂v*/∂t* + v*·∇*v* = -∇*p* + (1/Re)∇*²v*\n\n');

fprintf('Reynolds数的物理意义:\n');
fprintf('  Re = ρUL/μ = UL/ν = 惯性力/粘性力\n');
fprintf('  Re << 1: 粘性主导，Stokes流动\n');
fprintf('  Re >> 1: 惯性主导，湍流\n\n');

% 展示无量纲化过程
syms L_char U_char P_char
fprintf('无量纲化过程:\n');
fprintf('  x = L·x*,  v = U·v*,  t = (L/U)·t*,  p = ρU²·p*\n');
fprintf('  代入原方程，各项除以 ρU²/L 得到无量纲形式\n\n');

%% 7. 能量方程（补充）
fprintf('=== 能量方程 ===\n\n');

syms T_temp(x,y,z,t_sym)     % 温度
syms cp kappa positive        % 比热容和热导率

fprintf('能量方程（忽略粘性耗散）:\n');
fprintf('  ρcp(∂T/∂t + v·∇T) = κ∇²T\n\n');

fprintf('完整的能量方程（含粘性耗散Φ）:\n');
fprintf('  ρcp DT/Dt = κ∇²T + Φ\n');
fprintf('  其中 Φ 是粘性耗散函数\n\n');

fprintf('Navier-Stokes方程分析完成！\n');
