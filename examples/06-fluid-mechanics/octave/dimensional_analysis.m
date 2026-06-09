% Dimensional Analysis in Fluid Mechanics
% 流体力学中的量纲分析
%
% 物理背景：
%   量纲分析是将物理问题中的变量组合成无量纲参数的方法
%   Buckingham Pi定理是量纲分析的基础
%   通过量纲分析可以减少实验参数数量，揭示物理相似律
%
% 作者: CAS Learn Tutorial


%% 1. Buckingham Pi定理
fprintf('=== Buckingham Pi定理 ===\n\n');

fprintf('Buckingham Pi定理:\n');
fprintf('  如果一个物理问题涉及n个物理量，这些物理量包含m个基本量纲，\n');
fprintf('  则该问题可以用 (n - m) 个独立的无量纲参数（Pi项）来描述。\n\n');

fprintf('基本步骤:\n');
fprintf('  1. 列出所有相关的物理变量\n');
fprintf('  2. 确定基本量纲（通常为 M, L, T 或 M, L, T, Θ）\n');
fprintf('  3. 选择m个重复变量（包含所有基本量纲）\n');
fprintf('  4. 构建(n-m)个Pi项\n');
fprintf('  5. 验证每个Pi项无量纲\n\n');

%% 2. 量纲矩阵方法
fprintf('=== 量纲矩阵方法 ===\n\n');

% 示例：圆管流动的摩擦系数
% 相关变量：Δp, D, L, ρ, μ, ε, v
% Δp: 压降 [ML⁻¹T⁻²]
% D: 管径 [L]
% L: 管长 [L]
% ρ: 密度 [ML⁻³]
% μ: 粘度 [ML⁻¹T⁻¹]
% ε: 粗糙度 [L]
% v: 速度 [LT⁻¹]

fprintf('圆管流动摩擦系数问题:\n');
fprintf('  变量: Δp, D, L, ρ, μ, ε, v\n');
fprintf('  基本量纲: M, L, T (m=3)\n');
fprintf('  变量数: n=7\n');
fprintf('  Pi项数: n-m = 4\n\n');

% 量纲矩阵
%        Δp   D   L   ρ   μ   ε   v
%  M  [  1   0   0   1   1   0   0 ]
%  L  [ -1   1   1  -3  -1   1   1 ]
%  T  [ -2   0   0   0  -1   0  -1 ]

dim_matrix = [1  0  0  1  1  0  0;    % M
             -1  1  1 -3 -1  1  1;    % L
             -2  0  0  0 -1  0 -1];   % T

fprintf('量纲矩阵:\n');
fprintf('        Δp   D   L   ρ   μ   ε   v\n');
fprintf('  M  [ %2d  %2d  %2d  %2d  %2d  %2d  %2d ]\n', dim_matrix(1,:));
fprintf('  L  [ %2d  %2d  %2d  %2d  %2d  %2d  %2d ]\n', dim_matrix(2,:));
fprintf('  T  [ %2d  %2d  %2d  %2d  %2d  %2d  %2d ]\n\n', dim_matrix(3,:));

% 选择重复变量：D, ρ, v
% 构建Pi项

% Pi1 = Δp · D^a · ρ^b · v^c
% [ML⁻¹T⁻²][L]^a[ML⁻³]^b[LT⁻¹]^c = M⁰L⁰T⁰
% M: 1 + b = 0  → b = -1
% L: -1 + a - 3b + c = 0 → a + c = -2
% T: -2 - c = 0 → c = -2, a = 0
% Pi1 = Δp / (ρv²)  （Euler数 Eu）

fprintf('Pi项推导:\n\n');
fprintf('Pi1 (Euler数):\n');
fprintf('  Δp · D^a · ρ^b · v^c = 无量纲\n');
fprintf('  M: 1 + b = 0 → b = -1\n');
fprintf('  T: -2 - c = 0 → c = -2\n');
fprintf('  L: -1 + a + 3 + (-2) = 0 → a = 0\n');
fprintf('  Pi1 = Δp / (ρv²) = Eu (Euler数)\n\n');

% Pi2 = μ · D^a · ρ^b · v^c
% [ML⁻¹T⁻¹][L]^a[ML⁻³]^b[LT⁻¹]^c = M⁰L⁰T⁰
% M: 1 + b = 0 → b = -1
% T: -1 - c = 0 → c = -1
% L: -1 + a + 3 - 1 = 0 → a = -1
% Pi2 = μ / (ρvD) = 1/Re

fprintf('Pi2 (Reynolds数的倒数):\n');
fprintf('  μ · D^a · ρ^b · v^c = 无量纲\n');
fprintf('  M: 1 + b = 0 → b = -1\n');
fprintf('  T: -1 - c = 0 → c = -1\n');
fprintf('  L: -1 + a + 3 - 1 = 0 → a = -1\n');
fprintf('  Pi2 = μ/(ρvD) = 1/Re\n\n');

% Pi3 = ε · D^a · ρ^b · v^c = ε/D (相对粗糙度)
fprintf('Pi3 (相对粗糙度):\n');
fprintf('  Pi3 = ε/D\n\n');

% Pi4 = L · D^a · ρ^b · v^c = L/D (长径比)
fprintf('Pi4 (长径比):\n');
fprintf('  Pi4 = L/D\n\n');

% 最终关系
fprintf('最终无量纲关系:\n');
fprintf('  Eu = f(Re, ε/D, L/D)\n');
fprintf('  即: Δp/(ρv²) = f(Re, ε/D, L/D)\n\n');

%% 3. Reynolds数推导
fprintf('=== Reynolds数推导 ===\n\n');

syms rho_r mu_r U_r L_r positive

% Reynolds数 = 惯性力 / 粘性力
% 惯性力 ~ ρU²/L  (单位体积)
% 粘性力 ~ μU/L²  (单位体积)
Re_expr = (rho_r * U_r^2 / L_r) / (mu_r * U_r / L_r^2);
Re_simplified = simplify(Re_expr);

fprintf('Reynolds数的物理意义:\n');
fprintf('  Re = 惯性力 / 粘性力\n');
fprintf('  惯性力 ~ ρU²/L\n');
fprintf('  粘性力 ~ μU/L²\n');
fprintf('  Re = (ρU²/L) / (μU/L²) = ρUL/μ = %s\n\n', char(Re_simplified));

% 也可以从N-S方程无量纲化得到
fprintf('从N-S方程无量纲化得到:\n');
fprintf('  将 x*=x/L, v*=v/U, t*=tU/L, p*=p/(ρU²) 代入N-S方程\n');
fprintf('  得到: ∂v*/∂t* + v*·∇*v* = -∇*p* + (1/Re)∇*²v*\n');
fprintf('  其中 Re = ρUL/μ 出现在粘性项的系数中\n\n');

fprintf('Reynolds数的典型值:\n');
fprintf('  微流体: Re ~ 0.01 - 10\n');
fprintf '  管道流动: Re ~ 1000 - 10000\n');
fprintf('  汽车绕流: Re ~ 10⁶\n');
fprintf('  飞机机翼: Re ~ 10⁷\n\n');

%% 4. Froude数推导
fprintf('=== Froude数推导 ===\n\n');

% 有自由面的流动，重力很重要
% 相关变量：v, L, g
% Froude数 = 惯性力 / 重力 = v / √(gL)

syms g_f positive

Fr_expr = U_r / sqrt(g_f * L_r);
fprintf('Froude数:\n');
fprintf('  Fr = v / √(gL)\n');
fprintf('  物理意义：惯性力与重力之比\n');
fprintf('  Fr = %s\n\n', char(Fr_expr));

fprintf('Froude数的应用:\n');
fprintf('  Fr < 1: 亚临界流动（缓流）\n');
fprintf('  Fr = 1: 临界流动\n');
fprintf('  Fr > 1: 超临界流动（急流）\n\n');

% 用Buckingham Pi定理推导
fprintf('Buckingham Pi定理推导:\n');
fprintf('  变量: v, L, g, ρ, μ\n');
fprintf('  基本量纲: M, L, T (m=3)\n');
fprintf('  Pi项: 5-3 = 2\n');
fprintf('  Pi1 = v/√(gL) = Fr\n');
fprintf('  Pi2 = μ/(ρvL) = 1/Re\n\n');

%% 5. Mach数推导
fprintf('=== Mach数推导 ===\n\n');

% 可压缩流动中，声速很重要
% 相关变量：v, a (声速), ρ, p
% Mach数 = 流速 / 声速 = v / a

syms a_sound positive   % 声速

Ma_expr = U_r / a_sound;
fprintf('Mach数:\n');
fprintf('  Ma = v / a\n');
fprintf('  其中 a = √(γRT) = √(γp/ρ) 是声速\n');
fprintf('  Ma = %s\n\n', char(Ma_expr));

fprintf('Mach数的应用:\n');
fprintf('  Ma < 0.3: 不可压缩流动（密度变化 < 5%%）\n');
fprintf('  0.3 < Ma < 1: 亚声速流动\n');
fprintf('  Ma = 1: 声速流动\n');
fprintf('  Ma > 1: 超声速流动\n');
fprintf('  Ma > 5: 高超声速流动\n\n');

% 声速公式
syms gamma_air R_gas T_temp positive   % 比热比、气体常数、温度
a_formula = sqrt(gamma_air * R_gas * T_temp);
fprintf('声速公式:\n');
fprintf('  a = √(γRT)\n');
fprintf('  空气 (γ=1.4, R=287 J/kg·K): a = %s\n', char(a_formula));
fprintf('  在 T=288K (15°C): a ≈ 340 m/s\n\n');

%% 6. 其他重要无量纲数
fprintf('=== 其他重要无量纲数 ===\n\n');

% Weber数 (表面张力)
syms sigma_w rho_w L_w U_w positive
We_expr = rho_w * U_w^2 * L_w / sigma_w;
fprintf('Weber数（表面张力）:\n');
fprintf('  We = ρU²L/σ = %s\n', char(We_expr));
fprintf('  物理意义：惯性力与表面张力之比\n');
fprintf('  We >> 1: 表面张力可忽略\n');
fprintf('  We ~ 1: 表面张力重要\n\n');

% Strouhal数 (非定常流动)
syms f_str L_str U_str positive
St_expr = f_str * L_str / U_str;
fprintf('Strouhal数（非定常性）:\n');
fprintf('  St = fL/U = %s\n', char(St_expr));
fprintf('  物理意义：局部加速度与对流加速度之比\n');
fprintf('  应用：涡脱落频率、振动问题\n\n');

% Prandtl数 (传热)
syms mu_p cp_p kappa_p positive
Pr_expr = mu_p * cp_p / kappa_p;
fprintf('Prandtl数（传热）:\n');
fprintf('  Pr = μcp/κ = ν/α = %s\n', char(Pr_expr));
fprintf('  物理意义：动量扩散率与热扩散率之比\n');
fprintf('  空气: Pr ≈ 0.7\n');
fprintf('  水: Pr ≈ 7\n');
fprintf('  液态金属: Pr << 1\n\n');

% Nusselt数 (对流传热)
syms h_conv k_conv L_conv positive
Nu_expr = h_conv * L_conv / k_conv;
fprintf('Nusselt数（对流传热）:\n');
fprintf('  Nu = hL/κ = %s\n', char(Nu_expr));
fprintf('  物理意义：对流传热与导热之比\n');
fprintf('  Nu = f(Re, Pr, Gr, ...)\n\n');

%% 7. 相似性和建模原理
fprintf('=== 相似性和建模原理 ===\n\n');

% 几何相似
fprintf('几何相似:\n');
fprintf('  模型与原型的对应长度成比例\n');
fprintf('  L_m/L_p = λ（几何缩尺比）\n');
fprintf('  所有角度相等\n\n');

% 运动相似
fprintf('运动相似:\n');
fprintf('  模型与原型的速度场几何相似\n');
fprintf('  v_m/v_p = 对应位置速度成比例\n\n');

% 动力相似
fprintf('动力相似:\n');
fprintf('  模型与原型的无量纲数相等\n');
fprintf('  Re_m = Re_p, Fr_m = Fr_p, Ma_m = Ma_p, ...\n\n');

% 相似准则的矛盾
fprintf('完全相似的困难:\n');
fprintf('  通常无法同时满足所有相似准则\n');
fprintf('  例如：同时满足Re和Fr相似\n');
fprintf('  Re_m = Re_p → ρ_m v_m L_m / μ_m = ρ_p v_p L_p / μ_p\n');
fprintf('  Fr_m = Fr_p → v_m/√(gL_m) = v_p/√(gL_p)\n');
fprintf('  如果 L_m < L_p 且使用相同流体，则这两个条件矛盾\n\n');

% 解决方案
fprintf('解决方案:\n');
fprintf('  1. 选择主要相似准则（根据问题特点）\n');
fprintf('  2. 使用不同流体（改变ρ或μ）\n');
fprintf('  3. 分区模拟（不同区域用不同模型）\n');
fprintf('  4. 修正系数（经验修正）\n\n');

%% 8. 相似准则推导示例：船舶阻力
fprintf('=== 相似准则推导示例：船舶阻力 ===\n\n');

% 船舶阻力问题
% 相关变量：F (阻力), ρ, μ, g, v, L
fprintf('船舶阻力问题:\n');
fprintf('  变量: F, ρ, μ, g, v, L\n');
fprintf('  基本量纲: M, L, T (m=3)\n');
fprintf('  Pi项: 6-3 = 3\n\n');

% 推导过程
syms F_d positive   % 阻力

% 选择重复变量：ρ, v, L
% Pi1 = F / (ρ v² L²)  （阻力系数）
% Pi2 = μ / (ρ v L) = 1/Re
% Pi3 = g L / v² = 1/Fr²

syms rho positive
Pi1_ship = F_d / (rho * U_r^2 * L_r^2);
Pi2_ship = mu_r / (rho * U_r * L_r);
Pi3_ship = g_f * L_r / U_r^2;

fprintf('船舶阻力的Pi项:\n');
fprintf('  Pi1 = F/(ρv²L²) = C_D (阻力系数)\n');
fprintf('  Pi2 = μ/(ρvL) = 1/Re\n');
fprintf('  Pi3 = gL/v² = 1/Fr²\n\n');

fprintf('无量纲关系:\n');
fprintf('  C_D = f(Re, Fr)\n');
fprintf('  即: F/(ρv²L²) = f(Re, Fr)\n\n');

% 模型试验相似条件
fprintf('模型试验设计:\n');
fprintf('  如果使用相同流体（水）:\n');
fprintf('  Fr相似: v_m/v_p = √(L_m/L_p) = √λ\n');
fprintf('  Re相似: v_m/v_p = L_p/L_m = 1/λ\n');
fprintf('  矛盾！需要妥协\n\n');

fprintf('  实际做法:\n');
fprintf('  1. 低速（Fr不重要）：满足Re相似\n');
fprintf('  2. 高速（Fr重要）：满足Fr相似，修正Re效应\n');
fprintf('  3. 全尺寸试验或CFD验证\n\n');

%% 9. 相似准则推导示例：泵的性能
fprintf('=== 相似准则推导示例：泵的性能 ===\n\n');

% 泵的性能参数
% 相关变量：Q (流量), H (扬程), P (功率), ρ, μ, g, n (转速), D (直径)
syms Q_pump H_pump P_pump n_pump D_pump positive

fprintf('泵的性能问题:\n');
fprintf('  变量: Q, H, P, ρ, μ, g, n, D\n');
fprintf('  基本量纲: M, L, T (m=3)\n');
fprintf('  Pi项: 8-3 = 5\n\n');

% 选择重复变量：ρ, n, D
% Pi1 = Q/(nD³)  （流量系数）
% Pi2 = gH/(n²D²)  （扬程系数）
% Pi3 = P/(ρn³D⁵)  （功率系数）
% Pi4 = μ/(ρnD²) = 1/Re_rotational
% Pi5 = (NPSH)/(n²D²/g)  （汽蚀系数）

fprintf('泵的Pi项:\n');
fprintf('  Pi1 = Q/(nD³) = C_Q (流量系数)\n');
fprintf('  Pi2 = gH/(n²D²) = C_H (扬程系数)\n');
fprintf('  Pi3 = P/(ρn³D⁵) = C_P (功率系数)\n');
fprintf('  Pi4 = μ/(ρnD²) = 1/Re_rot\n');
fprintf('  Pi5 = g·NPSH/(n²D²) = σ (汽蚀系数)\n\n');

fprintf('泵的相似律:\n');
fprintf('  Q ∝ nD³\n');
fprintf('  H ∝ n²D²\n');
fprintf('  P ∝ ρn³D⁵\n');
fprintf('  效率 η = ρgQH/P\n\n');

%% 10. 量纲分析的矩阵方法（系统化）
fprintf('=== 量纲分析的矩阵方法（系统化） ===\n\n');

% 使用符号计算自动推导Pi项
fprintf('系统化量纲分析步骤:\n\n');

% 示例：湍流边界层
% 变量：δ (边界层厚度), x, ρ, μ, U
syms delta_bl x_bl positive

fprintf('湍流边界层厚度问题:\n');
fprintf('  变量: δ, x, ρ, μ, U\n');
fprintf('  假设: δ = f(x, ρ, μ, U)\n\n');

% 量纲矩阵
%        δ   x   ρ   μ   U
%  M  [  0   0   1   1   0 ]
%  L  [  1   1  -3  -1   1 ]
%  T  [  0   0   0  -1  -1 ]

dim_matrix_bl = [0 0 1 1 0;    % M
                1 1 -3 -1 1;    % L
                0 0 0 -1 -1];   % T

fprintf('量纲矩阵:\n');
fprintf('        δ   x   ρ   μ   U\n');
fprintf('  M  [ %2d  %2d  %2d  %2d  %2d ]\n', dim_matrix_bl(1,:));
fprintf('  L  [ %2d  %2d  %2d  %2d  %2d ]\n', dim_matrix_bl(2,:));
fprintf('  T  [ %2d  %2d  %2d  %2d  %2d ]\n\n', dim_matrix_bl(3,:));

% 选择重复变量：x, ρ, U
% Pi1 = δ/x
% Pi2 = μ/(ρUx) = 1/Re_x

fprintf('Pi项:\n');
fprintf('  Pi1 = δ/x (无量纲边界层厚度)\n');
fprintf('  Pi2 = μ/(ρUx) = 1/Re_x\n\n');

fprintf('无量纲关系:\n');
fprintf('  δ/x = f(Re_x)\n\n');

% 层流边界层解
fprintf('层流边界层 (Blasius解):\n');
fprintf('  δ/x ≈ 5.0/√Re_x\n');
fprintf('  即 δ ≈ 5.0·x/√(ρUx/μ) = 5.0·√(μx/(ρU))\n\n');

% 湍流边界层
fprintf('湍流边界层:\n');
fprintf('  δ/x ≈ 0.37/Re_x^(1/5)\n');
fprintf('  湍流边界层比层流边界层厚\n\n');

%% 11. 数值示例：量纲分析应用
fprintf('=== 数值示例：量纲分析应用 ===\n\n');

% 例1：模型试验
fprintf('例1：船舶模型试验\n');
fprintf('  模型缩尺比: λ = 1/20\n');
fprintf('  原型速度: v_p = 10 m/s\n');
fprintf('  流体: 水 (ν = 1e-6 m²/s)\n\n');

lambda = 1/20;
v_p = 10;  % m/s
L_p = 100; % m 船长
nu = 1e-6; % m²/s

% Fr相似
v_m_fr = v_p * sqrt(lambda);
L_m = L_p * lambda;
Re_p = v_p * L_p / nu;
Re_m_fr = v_m_fr * L_m / nu;

fprintf('  模型长度: L_m = %.1f m\n', L_m);
fprintf('  Fr相似的模型速度: v_m = %.2f m/s\n', v_m_fr);
fprintf('  原型Re: Re_p = %.2e\n', Re_p);
fprintf('  模型Re (Fr相似): Re_m = %.2e\n', Re_m_fr);
fprintf('  Re比值: Re_m/Re_p = %.4f (不相等！)\n\n', Re_m_fr/Re_p);

% 例2：泵的相似设计
fprintf('例2：泵的相似设计\n');
fprintf('  已知泵: D1 = 0.3 m, n1 = 1500 rpm, Q1 = 0.1 m³/s\n');
fprintf('  设计泵: D2 = 0.5 m, 相同流量系数\n\n');

D1 = 0.3; n1 = 1500; Q1 = 0.1;
D2 = 0.5;

% Q1/(n1*D1^3) = Q2/(n2*D2^3)
% 如果要求相同流量 Q2 = Q1
n2_same_Q = n1 * (D1/D2)^3;
Q2_same = Q1;  % 相同流量

fprintf('  相同流量时: n2 = %.0f rpm\n', n2_same_Q);
fprintf('  扬程比: H2/H1 = (n2/n1)²·(D2/D1)² = %.4f\n', ...
    (n2_same_Q/n1)^2 * (D2/D1)^2);
fprintf('  功率比: P2/P1 = (n2/n1)³·(D2/D1)⁵ = %.4f\n\n', ...
    (n2_same_Q/n1)^3 * (D2/D1)^5);

%% 12. 总结
fprintf('=== 无量纲数总结 ===\n\n');
fprintf('无量纲数        | 定义          | 物理意义           | 应用领域\n');
fprintf('----------------|---------------|--------------------|--------------------\n');
fprintf('Reynolds数 Re   | ρUL/μ         | 惯性力/粘性力       | 所有流动\n');
fprintf('Froude数 Fr     | U/√(gL)       | 惯性力/重力         | 自由面流动\n');
fprintf('Mach数 Ma       | U/a           | 流速/声速           | 可压缩流动\n');
fprintf('Weber数 We      | ρU²L/σ        | 惯性力/表面张力     | 两相流\n');
fprintf('Strouhal数 St   | fL/U          | 非定常性           | 涡脱落\n');
fprintf('Prandtl数 Pr    | μcp/κ         | 动量/热扩散率       | 传热\n');
fprintf('Nusselt数 Nu    | hL/κ          | 对流/导热           | 传热\n');
fprintf('Euler数 Eu      | Δp/(ρU²)      | 压力/惯性力         | 管道流动\n\n');

fprintf('量纲分析完成！\n');
