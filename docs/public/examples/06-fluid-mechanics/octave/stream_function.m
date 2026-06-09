% Stream Function and Velocity Potential
% 流函数与速度势函数
%
% 物理背景：
%   流函数ψ是二维不可压缩流动中描述流线的函数
%   速度势φ是无旋流动（势流）中描述速度场的函数
%   两者通过Laplace方程联系，是求解势流问题的核心工具
%
% 作者: CAS Learn Tutorial


%% 1. 流函数的定义和性质
fprintf('=== 流函数的定义和性质 ===\n\n');

% 定义符号变量
syms x y r theta positive
syms psi(x, y)         % 流函数
syms phi(x, y)         % 速度势函数
syms U_inf positive     % 来流速度
syms Q positive         % 源强度
syms Gamma positive     % 环量

% 流函数定义（二维笛卡尔坐标）
% u = ∂ψ/∂y,  v = -∂ψ/∂x
fprintf('流函数定义:\n');
fprintf('  u = ∂ψ/∂y\n');
fprintf('  v = -∂ψ/∂x\n\n');

% 关键性质
fprintf('流函数的关键性质:\n');
fprintf('  1. 自动满足连续性方程: ∂u/∂x + ∂v/∂y = 0\n');
fprintf('  2. 等流函数线(ψ=const)就是流线\n');
fprintf('  3. 两条流线之间的流量: ΔQ = ψ₂ - ψ₁\n\n');

% 验证连续性方程
u_sym = diff(psi, y);
v_sym = -diff(psi, x);
cont_check = diff(u_sym, x) + diff(v_sym, y);
fprintf('验证连续性: ∂u/∂x + ∂v/∂y = %s = 0 ✓\n\n', char(simplify(cont_check)));

%% 2. 柱坐标下的流函数
fprintf('=== 柱坐标下的流函数 ===\n\n');

syms psi_r(r, theta)

% 柱坐标流函数
% v_r = (1/r)∂ψ/∂θ,  v_θ = -∂ψ/∂r
fprintf('柱坐标流函数:\n');
fprintf('  v_r = (1/r)∂ψ/∂θ\n');
fprintf('  v_θ = -∂ψ/∂r\n\n');

% 验证柱坐标连续性
v_r_sym = diff(psi_r, theta) / r;
v_theta_sym = -diff(psi_r, r);
cont_r = diff(r * v_r_sym, r) / r + diff(v_theta_sym, theta) / r;
fprintf('柱坐标连续性验证: (1/r)∂(r·v_r)/∂r + (1/r)∂v_θ/∂θ = %s = 0 ✓\n\n', ...
    char(simplify(cont_r)));

%% 3. 速度势函数
fprintf('=== 速度势函数 ===\n\n');

% 速度势函数定义
% u = ∂φ/∂x,  v = ∂φ/∂y
fprintf('速度势函数定义:\n');
fprintf('  u = ∂φ/∂x\n');
fprintf('  v = ∂φ/∂y\n\n');

fprintf('速度势函数的关键性质:\n');
fprintf('  1. 适用于无旋流动（∇×v = 0）\n');
fprintf('  2. 等势线(φ=const)与流线(ψ=const)正交\n');
fprintf('  3. 满足Laplace方程: ∇²φ = 0\n\n');

% Cauchy-Riemann条件
% ∂φ/∂x = ∂ψ/∂y,  ∂φ/∂y = -∂ψ/∂x
fprintf('Cauchy-Riemann条件:\n');
fprintf('  ∂φ/∂x = ∂ψ/∂y\n');
fprintf('  ∂φ/∂y = -∂ψ/∂x\n');
fprintf('  这使得 f(z) = φ + iψ 是解析函数（复势）\n\n');

%% 4. 均匀流（Uniform Flow）
fprintf('=== 均匀流 ===\n\n');

% 均匀流：速度为常数 U_inf 沿x方向
% u = U_inf, v = 0
% ψ = U_inf * y
% φ = U_inf * x

psi_uniform = U_inf * y;
phi_uniform = U_inf * x;

fprintf('均匀流（沿x方向）:\n');
fprintf('  速度: u = U, v = 0\n');
fprintf('  流函数: ψ = U·y\n');
fprintf('  速度势: φ = U·x\n');
fprintf('  流线: y = const（水平线）\n\n');

% 均匀流（任意方向）
syms alpha   % 与x轴的夹角
psi_uniform_angle = U_inf * (y * cos(alpha) - x * sin(alpha));
fprintf('倾斜均匀流（与x轴夹角α）:\n');
fprintf('  ψ = U(y·cos α - x·sin α)\n\n');

%% 5. 点源/点汇（Source/Sink）
fprintf('=== 点源/点汇 ===\n\n');

% 位于原点的点源
% 柱坐标：v_r = Q/(2πr), v_θ = 0
% 流函数：ψ = Q·θ/(2π)
% 速度势：φ = Q·ln(r)/(2π)

psi_source = Q * theta / (2 * sym(pi));
phi_source = Q * log(r) / (2 * sym(pi));

fprintf('位于原点的点源:\n');
fprintf('  强度: Q（单位时间单位深度的体积流量）\n');
fprintf('  径向速度: v_r = Q/(2πr)\n');
fprintf('  流函数: ψ = Q·θ/(2π)\n');
fprintf('  速度势: φ = Q·ln(r)/(2π)\n');
fprintf('  流线: θ = const（射线）\n');
fprintf('  等势线: r = const（同心圆）\n\n');

% 位于任意点 (x0, y0) 的源
syms x0 y0
r_shifted = sqrt((x - x0)^2 + (y - y0)^2);
theta_shifted = atan2(y - y0, x - x0);

psi_source_shifted = Q * atan2(y - y0, x - x0) / (2 * sym(pi));
fprintf('位于(x₀, y₀)的点源:\n');
fprintf('  ψ = Q·arctan((y-y₀)/(x-x₀))/(2π)\n\n');

%% 6. 点涡（Point Vortex）
fprintf('=== 点涡（点涡） ===\n\n');

% 位于原点的点涡（Rankine vortex的外区）
% 柱坐标：v_r = 0, v_θ = Γ/(2πr)
% 流函数：ψ = -Γ·ln(r)/(2π)
% 速度势：φ = Γ·θ/(2π)

psi_vortex = -Gamma * log(r) / (2 * sym(pi));
phi_vortex = Gamma * theta / (2 * sym(pi));

fprintf('位于原点的点涡（环量Γ）:\n');
fprintf('  切向速度: v_θ = Γ/(2πr)\n');
fprintf('  流函数: ψ = -Γ·ln(r)/(2π)\n');
fprintf('  速度势: φ = Γ·θ/(2π)\n');
fprintf('  流线: r = const（同心圆）\n');
fprintf('  注意：原点处速度无穷大（奇点）\n\n');

% 点涡的环量
% Γ = ∮ v·dl = 2πr·v_θ = 常数
fprintf('环量定义:\n');
fprintf('  Γ = ∮ v·dl = 2πr·(Γ/(2πr)) = Γ（与r无关）\n\n');

%% 7. 偶极子（Doublet/Dipole）
fprintf('=== 偶极子 ===\n\n');

% 偶极子 = 等强度的源和汇无限接近
% 强度 μ = Q·Δx（源强×距离）
% 流函数：ψ = -μ·sin(θ)/(2πr)
% 速度势：φ = μ·cos(θ)/(2πr)

syms mu_dipole positive   % 偶极子强度
psi_doublet = -mu_dipole * sin(theta) / (2 * sym(pi) * r);
phi_doublet = mu_dipole * cos(theta) / (2 * sym(pi) * r);

fprintf('位于原点的偶极子（强度μ）:\n');
fprintf('  构造：等强度源和汇无限接近\n');
fprintf('  流函数: ψ = -μ·sin(θ)/(2πr)\n');
fprintf('  速度势: φ = μ·cos(θ)/(2πr)\n');
fprintf('  流线: r² = -μ·sin(θ)/(2πψ) → 圆族\n');
fprintf('  物理意义：模拟绕圆柱的流动\n\n');

%% 8. 超级叠加（Superposition）
fprintf('=== 流动的超级叠加 ===\n\n');

% 原理：对于势流（无旋不可压缩），Laplace方程是线性的
% 因此多个基本解可以叠加
fprintf('叠加原理:\n');
fprintf('  对于势流，∇²φ = 0 是线性方程\n');
fprintf('  因此 φ_total = φ₁ + φ₂ + ... + φₙ\n');
fprintf('  同样 ψ_total = ψ₁ + ψ₂ + ... + ψₙ\n\n');

%% 9. 叠加示例1：均匀流 + 点源
fprintf('=== 叠加示例1：均匀流 + 点源 ===\n\n');

% 半体（half-body）流动
psi_half_body = U_inf * r * sin(theta) + Q * theta / (2 * sym(pi));
phi_half_body = U_inf * r * cos(theta) + Q * log(r) / (2 * sym(pi));

fprintf('均匀流 + 点源 = 半体流动:\n');
fprintf('  ψ = U·r·sin(θ) + Q·θ/(2π)\n');
fprintf('  φ = U·r·cos(θ) + Q·ln(r)/(2π)\n\n');

% 驻点位置
% v_r = U·cos(θ) + Q/(2πr) = 0
% v_θ = -U·sin(θ) = 0  → θ = π
% 代入: -U + Q/(2πr_s) = 0 → r_s = Q/(2πU)
r_stagnation = Q / (2 * sym(pi) * U_inf);
fprintf('驻点位置:\n');
fprintf('  θ = π,  r_s = Q/(2πU)\n');
fprintf('  即: r_s = %s\n\n', char(r_stagnation));

% 半体边界（ψ = 0 的分界流线）
fprintf('半体边界: ψ = 0 的流线\n');
fprintf('  当 θ → 0 时, r → ∞（半体延伸至无穷远）\n');
fprintf('  当 θ → π 时, r = r_s（驻点）\n\n');

%% 10. 叠加示例2：均匀流 + 偶极子 = 绕圆柱流动
fprintf('=== 叠加示例2：绕圆柱流动 ===\n\n');

% 均匀流 + 偶极子
% ψ = U·r·sin(θ) - μ·sin(θ)/(2πr)
% 选择 μ = 2πU·a² 使得圆柱半径为a
syms a positive   % 圆柱半径
mu_cylinder = 2 * sym(pi) * U_inf * a^2;

psi_cylinder = U_inf * r * sin(theta) - mu_cylinder * sin(theta) / (2 * sym(pi) * r);
phi_cylinder = U_inf * r * cos(theta) + mu_cylinder * cos(theta) / (2 * sym(pi) * r);

fprintf('均匀流 + 偶极子 = 绕圆柱流动:\n');
fprintf('  μ = 2πUa²\n');
fprintf('  ψ = U·r·sin(θ)(1 - a²/r²)\n');
fprintf('  φ = U·r·cos(θ)(1 + a²/r²)\n\n');

% 简化流函数
psi_cylinder_simplified = U_inf * r * sin(theta) * (1 - a^2 / r^2);
fprintf('圆柱表面 r = a 处: ψ = 0（流线与圆柱重合）\n\n');

% 圆柱表面的速度分布
% v_r|_(r=a) = 0,  v_θ|_(r=a) = -2U·sin(θ)
fprintf('圆柱表面速度:\n');
fprintf('  v_r|_(r=a) = 0\n');
fprintf('  v_θ|_(r=a) = -2U·sin(θ)\n');
fprintf('  最大速度在 θ = π/2 和 3π/2: |v_max| = 2U\n\n');

% 压力分布（Bernoulli方程）
syms p_inf positive   % 远场压力
fprintf('圆柱表面压力（Bernoulli方程）:\n');
fprintf('  p + ρv²/2 = p_∞ + ρU²/2\n');
fprintf('  p(θ) = p_∞ + ρU²/2·(1 - 4sin²θ)\n');
fprintf('  压力系数: Cp = (p - p_∞)/(ρU²/2) = 1 - 4sin²θ\n\n');

%% 11. 叠加示例3：绕圆柱流动 + 环量（Kutta条件）
fprintf('=== 叠加示例3：有环量的绕圆柱流动 ===\n\n');

% 均匀流 + 偶极子 + 点涡（Kutta-Joukowski定理的原型）
psi_kutta = U_inf * r * sin(theta) * (1 - a^2/r^2) ...
    + Gamma * log(r/a) / (2 * sym(pi));

fprintf('均匀流 + 偶极子 + 点涡:\n');
fprintf('  ψ = U·r·sin(θ)(1 - a²/r²) + Γ·ln(r/a)/(2π)\n\n');

% 升力（Kutta-Joukowski定理）
syms rho positive
L_lift = rho * U_inf * Gamma;
fprintf('Kutta-Joukowski升力定理:\n');
fprintf('  L = ρ·U·Γ （单位展长的升力）\n');
fprintf('  升力方向：来流方向逆时针旋转90°\n');
fprintf('  环量Γ的正方向：逆时针\n\n');

% 驻点位置
fprintf('驻点位置（有环量时）:\n');
fprintf('  在圆柱表面: sin(θ_s) = Γ/(4πUa)\n');
fprintf('  当 Γ < 4πUa 时：两个驻点在下半圆柱对称分布\n');
fprintf('  当 Γ = 4πUa 时：两驻点合并于底部\n');
fprintf('  当 Γ > 4πUa 时：一个驻点离开圆柱\n\n');


%% 13. 复势函数
fprintf('=== 复势函数 ===\n\n');

syms z_complex   % 复变量 z = x + iy

% 均匀流的复势：W(z) = U·z
fprintf('均匀流复势:\n');
fprintf('  W(z) = U·z = U(x + iy)\n');
fprintf('  φ = Re(W) = Ux,  ψ = Im(W) = Uy\n\n');

% 点源复势：W(z) = Q/(2π)·ln(z)
fprintf('点源复势:\n');
fprintf('  W(z) = Q/(2π)·ln(z)\n');
fprintf('  φ = Q·ln(r)/(2π),  ψ = Q·θ/(2π)\n\n');

% 点涡复势：W(z) = -iΓ/(2π)·ln(z)
fprintf('点涡复势:\n');
fprintf('  W(z) = -iΓ/(2π)·ln(z)\n');
fprintf('  φ = Γ·θ/(2π),  ψ = -Γ·ln(r)/(2π)\n\n');

% 偶极子复势：W(z) = μ/(2πz)
fprintf('偶极子复势:\n');
fprintf('  W(z) = μ/(2πz)\n\n');

% 绕圆柱复势：W(z) = U(z + a²/z) + iΓ/(2π)·ln(z)
fprintf('绕圆柱（有环量）复势:\n');
fprintf('  W(z) = U(z + a²/z) + iΓ/(2π)·ln(z)\n\n');

% Kutta-Joukowski定理
fprintf('Kutta-Joukowski定理:\n');
fprintf('  升力 L = ρ·U·Γ（单位展长）\n');
fprintf("  阻力 D = 0（d'Alembert佯谬）\n");
fprintf('  注意：实际流体有阻力，因为存在粘性和分离\n\n');

fprintf('流函数与速度势分析完成！\n');
