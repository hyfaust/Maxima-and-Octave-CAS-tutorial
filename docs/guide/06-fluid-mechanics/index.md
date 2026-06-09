# 第6章：流体力学应用

> 难度：★★★★★ 专家
>
> 本章将计算机代数系统（CAS）应用于流体力学领域，从基本方程推导到经典问题的符号求解，
> 重点讲解瑞利空化泡问题的完整分析流程。

---

## 6.1 流体力学基本方程

### 6.1.1 连续性方程

流体力学的质量守恒表达为**连续性方程**。对于可压缩流体：

$$
\frac{\partial \rho}{\partial t} + \nabla \cdot (\rho \mathbf{v}) = 0
$$

其中 $\rho$ 为流体密度，$\mathbf{v}$ 为速度矢量。展开后在笛卡尔坐标系中：

$$
\frac{\partial \rho}{\partial t} + \frac{\partial (\rho u)}{\partial x} + \frac{\partial (\rho v)}{\partial y} + \frac{\partial (\rho w)}{\partial z} = 0
$$

对于**不可压缩流体**（$\rho = \text{const}$），连续性方程简化为：

$$
\nabla \cdot \mathbf{v} = \frac{\partial u}{\partial x} + \frac{\partial v}{\partial y} + \frac{\partial w}{\partial z} = 0
$$

### 6.1.2 Navier-Stokes 方程

Navier-Stokes 方程是流体力学的核心动量方程。对于不可压缩牛顿流体：

$$
\rho \left( \frac{\partial \mathbf{v}}{\partial t} + (\mathbf{v} \cdot \nabla) \mathbf{v} \right) = -\nabla p + \mu \nabla^2 \mathbf{v} + \rho \mathbf{f}
$$

其中：
- $p$ 为压力
- $\mu$ 为动力粘度
- $\mathbf{f}$ 为体积力（如重力）

$x$ 方向分量展开：

$$
\rho \left( \frac{\partial u}{\partial t} + u\frac{\partial u}{\partial x} + v\frac{\partial u}{\partial y} + w\frac{\partial u}{\partial z} \right) = -\frac{\partial p}{\partial x} + \mu \left( \frac{\partial^2 u}{\partial x^2} + \frac{\partial^2 u}{\partial y^2} + \frac{\partial^2 u}{\partial z^2} \right) + \rho f_x
$$

### 6.1.3 CAS 求解示例

使用 CAS 可以方便地进行向量微积分运算，验证方程的简化形式：

```maxima
/* 定义速度场和散度计算 */
v: [u(x,y,z), v(x,y,z), w(x,y,z)];
div_v: diff(v[1], x) + diff(v[2], y) + diff(v[3], z);
/* 不可压缩条件 */
incompressible: div_v = 0;
```

```octave
% Octave 验证不可压缩条件
% 给定一个速度场，计算其散度
syms x y z u v w
velocity_field = [sin(x)*cos(y), -cos(x)*sin(y), 0];
div_v = diff(velocity_field(1), x) + diff(velocity_field(2), y) + diff(velocity_field(3), z);
% 结果应为 0，满足不可压缩条件
```

---

## 6.2 流函数与势函数

### 6.2.1 流函数

对于二维不可压缩流动，连续性方程 $\frac{\partial u}{\partial x} + \frac{\partial v}{\partial y} = 0$ 自动被**流函数** $\psi(x, y)$ 满足：

$$
u = \frac{\partial \psi}{\partial y}, \quad v = -\frac{\partial \psi}{\partial x}
$$

流函数的重要性质：
- **等流函数线**即为流线（$\psi = \text{const}$）
- 两条流线之间的流量差等于流函数值之差：$Q = \psi_2 - \psi_1$

### 6.2.2 速度势

对于**无旋流动**（$\nabla \times \mathbf{v} = 0$），存在**速度势** $\phi(x, y)$ 使得：

$$
u = \frac{\partial \phi}{\partial x}, \quad v = \frac{\partial \phi}{\partial y}
$$

即 $\mathbf{v} = \nabla \phi$。

### 6.2.3 拉普拉斯方程

将速度势代入不可压缩连续性方程：

$$
\nabla^2 \phi = \frac{\partial^2 \phi}{\partial x^2} + \frac{\partial^2 \phi}{\partial y^2} = 0
$$

同理，对于无旋流动，流函数也满足拉普拉斯方程：

$$
\nabla^2 \psi = \frac{\partial^2 \psi}{\partial x^2} + \frac{\partial^2 \psi}{\partial y^2} = 0
$$

因此，无旋不可压缩流动的求解归结为**求解拉普拉斯方程**。

### 6.2.4 流函数与势函数的关系

对于既无旋又不可压缩的流动，流函数和势函数互为**共轭调和函数**：

$$
\frac{\partial \phi}{\partial x} = \frac{\partial \psi}{\partial y}, \quad \frac{\partial \phi}{\partial y} = -\frac{\partial \psi}{\partial x}
$$

这正是 **Cauchy-Riemann 条件**，意味着复势 $W(z) = \phi + i\psi$ 是解析函数。

---

## 6.3 简单流动问题的符号解

### 6.3.1 均匀流

速度场：$\mathbf{v} = (U_\infty, 0)$，即沿 $x$ 方向的均匀流。

$$
\phi = U_\infty x, \quad \psi = U_\infty y
$$

复势：$W(z) = U_\infty z$

### 6.3.2 点源 / 点汇

位于原点的二维点源（强度 $m > 0$ 为源，$m < 0$ 为汇）：

$$
\phi = \frac{m}{2\pi} \ln r, \quad \psi = \frac{m}{2\pi} \theta
$$

其中 $r = \sqrt{x^2 + y^2}$，$\theta = \arctan(y/x)$。

复势：$W(z) = \frac{m}{2\pi} \ln z$

### 6.3.3 点涡

位于原点、环量为 $\Gamma$ 的点涡：

$$
\phi = \frac{\Gamma}{2\pi} \theta, \quad \psi = -\frac{\Gamma}{2\pi} \ln r
$$

复势：$W(z) = -\frac{i\Gamma}{2\pi} \ln z$

速度场为纯切向：$v_r = 0$，$v_\theta = \frac{\Gamma}{2\pi r}$

### 6.3.4 偶极子

由等强度的点源和点汇在极限距离趋于零时构成，偶极矩为 $\mu$：

$$
W(z) = \frac{\mu}{2\pi z}
$$

### 6.3.5 绕圆柱流动（有环量）

将均匀流与偶极子叠加，得到绕圆柱流动。再叠加点涡：

$$
W(z) = U_\infty z + \frac{a^2 U_\infty}{z} - \frac{i\Gamma}{2\pi} \ln z
$$

其中 $a$ 为圆柱半径。这产生了著名的 **Magnus 效应**——升力：

$$
L = \rho U_\infty \Gamma
$$

### 6.3.6 CAS 代码示例

```maxima
/* 定义复势并计算速度场 */
kill(all);
declare(z, complex);

/* 均匀流 + 偶极子 + 点涡 */
W: U*z + mu/(2*%pi*z) - %i*Gamma/(2*%pi)*log(z);

/* 速度 = dW/dz */
V: diff(W, z);

/* 提取实部和虚部 */
V_expanded: expand(V);
```

```octave
pkg load symbolic;
syms x y z U a Gamma real
syms mu real

% 绕圆柱流动的复势
W = U*z + a^2*U/z - 1i*Gamma/(2*pi)*log(z);

% 复速度
V_complex = diff(W, z);

% 在圆柱表面 z = a*exp(i*theta) 上评估
syms theta real
z_surface = a * exp(1i*theta);
V_surface = subs(V_complex, z, z_surface);
V_surface_simplified = simplify(V_surface);

% 计算压力系数
V_abs_sq = V_surface_simplified * conj(V_surface_simplified);
Cp = 1 - simplify(V_abs_sq / U^2);
```

---

## 6.4 量纲分析与相似性

### 6.4.1 Buckingham $\Pi$ 定理

若一个物理问题涉及 $n$ 个物理量，其中有 $m$ 个独立的基本量纲，则无量纲参数的个数为 $n - m$。

**定理表述**：若物理关系 $f(q_1, q_2, \ldots, q_n) = 0$ 成立，则等价于 $g(\Pi_1, \Pi_2, \ldots, \Pi_{n-m}) = 0$，其中 $\Pi_i$ 为无量纲组合。

### 6.4.2 量纲分析步骤

1. 列出所有相关物理量 $q_1, q_2, \ldots, q_n$
2. 确定基本量纲（通常 M, L, T）
3. 选择 $m$ 个重复变量（包含所有基本量纲）
4. 对每个剩余变量构造无量纲 $\Pi$ 项
5. 写出无量纲关系

### 6.4.3 管内流动的量纲分析

考虑管内压降 $\Delta p$ 与以下参数相关：直径 $D$、长度 $L$、平均速度 $V$、密度 $\rho$、粘度 $\mu$、管壁粗糙度 $\epsilon$。

| 物理量 | 符号 | 量纲 |
|--------|------|------|
| 压降 | $\Delta p$ | $ML^{-1}T^{-2}$ |
| 直径 | $D$ | $L$ |
| 长度 | $L$ | $L$ |
| 速度 | $V$ | $LT^{-1}$ |
| 密度 | $\rho$ | $ML^{-3}$ |
| 粘度 | $\mu$ | $ML^{-1}T^{-1}$ |
| 粗糙度 | $\epsilon$ | $L$ |

选择 $\rho, V, D$ 为重复变量，得到无量纲参数：

$$
\Pi_1 = \frac{\Delta p}{\rho V^2}, \quad \Pi_2 = \frac{L}{D}, \quad \Pi_3 = \frac{\mu}{\rho V D} = \frac{1}{Re}, \quad \Pi_4 = \frac{\epsilon}{D}
$$

### 6.4.4 雷诺数与相似性

**雷诺数** $Re$ 是流体力学中最重要的无量纲数：

$$
Re = \frac{\rho V D}{\mu} = \frac{\text{惯性力}}{\text{粘性力}}
$$

- $Re \ll 1$：粘性力主导（Stokes 流）
- $Re \gg 1$：惯性力主导（湍流）

**动力相似**要求模型与原型的无量纲参数相同：

$$
Re_{\text{model}} = Re_{\text{prototype}}
$$

### 6.4.5 其他重要无量纲数

| 名称 | 定义 | 物理意义 |
|------|------|----------|
| 雷诺数 $Re$ | $\frac{\rho V L}{\mu}$ | 惯性力/粘性力 |
| 马赫数 $Ma$ | $\frac{V}{a}$ | 惯性力/弹性力 |
| 弗劳德数 $Fr$ | $\frac{V}{\sqrt{gL}}$ | 惯性力/重力 |
| 韦伯数 $We$ | $\frac{\rho V^2 L}{\sigma}$ | 惯性力/表面张力 |
| 斯特劳哈尔数 $St$ | $\frac{fL}{V}$ | 非定常性/对流 |

---

## 6.5 瑞利空化泡问题（重点！）

### 6.5.1 物理背景

**空化（Cavitation）** 是流体力学中的重要现象：当液体中的局部压力降至饱和蒸汽压以下时，液体会"沸腾"产生蒸汽泡。当泡溃灭时，会产生极高的局部压力和温度，可能导致材料损伤。

**应用场景**：
- 螺旋桨、水泵中的空蚀破坏
- 水下爆炸冲击波
- 医学超声碎石（碎石术）
- 声化学反应

瑞利（Lord Rayleigh, 1917）首次分析了**不可压缩流体内突然出现一个球形空泡**后的运动规律。

### 6.5.2 物理模型

考虑一个半径为 $R(t)$ 的球形空泡，浸没在无限大不可压缩流体中。假设：
- 流体不可压缩、无粘性
- 流动为球对称径向运动
- 泡内压力为常数 $p_v$（蒸汽压）
- 无穷远处压力为 $p_\infty$

### 6.5.3 Rayleigh-Plesset 方程推导

**步骤 1**：从连续性方程出发，球坐标下的径向速度场：

$$
\nabla \cdot \mathbf{v} = \frac{1}{r^2} \frac{\partial}{\partial r}(r^2 v_r) = 0
$$

积分得：$v_r(r, t) = \frac{f(t)}{r^2}$

由泡壁运动学边界条件 $v_r(R, t) = \dot{R}$：

$$
v_r(r, t) = \frac{R^2 \dot{R}}{r^2}
$$

**步骤 2**：将速度场代入无粘动量方程（Euler 方程）：

$$
\frac{\partial v_r}{\partial t} + v_r \frac{\partial v_r}{\partial r} = -\frac{1}{\rho} \frac{\partial p}{\partial r}
$$

**步骤 3**：代入 $v_r = R^2\dot{R}/r^2$，从 $r = R$ 到 $r = \infty$ 积分：

$$
\frac{R^2 \ddot{R} + 2R\dot{R}^2}{r} - \frac{R^4 \dot{R}^2}{2r^4} = \frac{p(r) - p(R)}{\rho}
$$

取 $r \to \infty$，$p(\infty) = p_\infty$，$p(R) = p_v$：

$$
\boxed{R\ddot{R} + \frac{3}{2}\dot{R}^2 = \frac{p_v - p_\infty}{\rho}}
$$

这就是著名的 **Rayleigh-Plesset 方程**。

### 6.5.4 初始条件

泡从初始半径 $R_0$ 静止开始运动：

$$
R(0) = R_0, \quad \dot{R}(0) = 0
$$

### 6.5.5 无量纲化

定义无量纲变量：

$$
\hat{R} = \frac{R}{R_0}, \quad \hat{t} = \frac{t}{t_c}, \quad t_c = R_0 \sqrt{\frac{\rho}{|p_\infty - p_v|}}
$$

其中 $t_c$ 为特征时间尺度（瑞利溃灭时间量级）。

无量纲化后的方程：

$$
\hat{R}\frac{d^2\hat{R}}{d\hat{t}^2} + \frac{3}{2}\left(\frac{d\hat{R}}{d\hat{t}}\right)^2 = -\text{sgn}(p_\infty - p_v)
$$

当 $p_\infty > p_v$（溃灭情形），右端为 $-1$。初始条件变为：

$$
\hat{R}(0) = 1, \quad \frac{d\hat{R}}{d\hat{t}}(0) = 0
$$

### 6.5.6 渐近分析

在溃灭末期（$\hat{R} \to 0$），可以忽略常数项，得到：

$$
\hat{R}\frac{d^2\hat{R}}{d\hat{t}^2} + \frac{3}{2}\left(\frac{d\hat{R}}{d\hat{t}}\right)^2 \approx 0
$$

假设 $\hat{R} \sim (\hat{t}_c - \hat{t})^\alpha$，代入得 $\alpha = 2/5$，即：

$$
R(t) \sim (t_c - t)^{2/5}
$$

瑞利溃灭时间的精确估计：

$$
t_{\text{collapse}} = 0.91468 \cdot R_0 \sqrt{\frac{\rho}{p_\infty - p_v}}
$$

### 6.5.7 CAS 符号推导

以下展示如何用 CAS 推导 Rayleigh-Plesset 方程的关键步骤：

```maxima
/* Rayleigh-Plesset 方程符号推导 */
kill(all);

/* 速度场 v_r = R(t)^2 * diff(R(t),t) / r^2 */
depends(R, t);
v_r: R^2 * diff(R, t) / r^2;

/* 时间导数 */
dv_r_dt: diff(v_r, t);

/* 空间导数 */
dv_r_dr: diff(v_r, r);

/* 对流项 v_r * dv_r/dr */
convective: v_r * dv_r_dr;

/* 动量方程左端 */
lhs: dv_r_dt + convective;
lhs_simplified: ratsimp(lhs);
```

```octave
pkg load symbolic;
syms R(t) r rho p_v p_inf R0 real

% 速度场
v_r = R^2 * diff(R, t) / r^2;

% Euler方程左端
dv_r_dt = diff(v_r, t);
dv_r_dr = diff(v_r, r);
lhs_momentum = dv_r_dt + v_r * dv_r_dr;

% 从 r=R 到 r=inf 积分
% 积分后得到 Rayleigh-Plesset 方程
lhs_rp = R*diff(R, t, 2) + (3/2)*diff(R, t)^2;
rhs_rp = (p_v - p_inf) / rho;
RP_equation = lhs_rp == rhs_rp;

disp('Rayleigh-Plesset equation:');
disp(RP_equation);
```

### 6.5.8 数值求解

将二阶 ODE 化为一阶方程组：

$$
\begin{cases}
y_1 = \hat{R} \\
y_2 = \dfrac{d\hat{R}}{d\hat{t}}
\end{cases}
$$

$$
\frac{dy_1}{d\hat{t}} = y_2, \quad \frac{dy_2}{d\hat{t}} = \frac{-1 - \frac{3}{2}y_2^2}{y_1}
$$

初始条件：$y_1(0) = 1$，$y_2(0) = 0$。

```octave
% Rayleigh-Plesset 方程数值求解
function dydt = rayleigh_plesset(t, y)
  % y(1) = R_hat, y(2) = dR_hat/dt_hat
  R_hat = y(1);
  dRdt = y(2);
  
  % 防止除零
  if abs(R_hat) < 1e-10
    R_hat = 1e-10;
  end
  
  dydt = zeros(2, 1);
  dydt(1) = dRdt;
  dydt(2) = (-1 - 1.5 * dRdt^2) / R_hat;
end

% 求解
[t, y] = ode45(@rayleigh_plesset, [0, 0.92], [1; 0]);

% 绘图
figure;
plot(t, y(:,1), 'b-', 'LineWidth', 2);
xlabel('Dimensionless time');
ylabel('Dimensionless radius R/R_0');
title('Rayleigh Bubble Collapse');
grid on;
```

### 6.5.9 扩展：Rayleigh-Plesset 方程的完整形式

考虑表面张力、粘性和可压缩性的完整形式：

$$
R\ddot{R} + \frac{3}{2}\dot{R}^2 = \frac{1}{\rho}\left[ \left(p_0 + \frac{2\sigma}{R_0}\right)\left(\frac{R_0}{R}\right)^{3\gamma} - p_\infty(t) - \frac{2\sigma}{R} - \frac{4\mu\dot{R}}{R} \right]
$$

其中：
- $\sigma$ 为表面张力系数
- $\mu$ 为动力粘度
- $\gamma$ 为多方指数（气体可压缩性）
- $p_0$ 为初始泡内压力

### 6.5.10 应用展望

| 应用领域 | 关键物理 | 典型参数 |
|----------|----------|----------|
| 空蚀破坏 | 溃灭冲击波 | $R_0 \sim 10\,\mu\text{m}$, $t_c \sim 1\,\mu\text{s}$ |
| 水下爆炸 | 高压气体泡 | $R_0 \sim 1\,\text{m}$, $p \sim 10^9\,\text{Pa}$ |
| 医学超声 | 声驱动泡振动 | $R_0 \sim 1\,\mu\text{m}$, $f \sim 1\,\text{MHz}$ |
| 声化学 | 泡内高温高压 | $T_{\text{max}} \sim 5000\,\text{K}$ |

---

## 章节总结

| 节 | 核心概念 | CAS 工具 |
|----|----------|----------|
| 6.1 | 连续性方程、N-S 方程 | 向量微积分、张量运算 |
| 6.2 | 流函数、速度势、拉普拉斯方程 | 解析函数、PDE 求解 |
| 6.3 | 均匀流、点源/汇、点涡、偶极子 | 复势运算、级数展开 |
| 6.4 | Buckingham $\Pi$ 定理、雷诺数 | 量纲矩阵运算 |
| 6.5 | Rayleigh-Plesset 方程 | 符号推导 + 数值 ODE 求解 |

> **关键收获**：CAS 工具在流体力学中不仅是符号计算器，更是连接物理直觉与数学推导的桥梁。
> 尤其在瑞利空化泡问题中，CAS 帮助我们完成从物理假设到数学方程的完整推导链，
> 并通过数值求解获得直观的物理图像。

---

## 代码文件

本章配套的 CAS 代码文件：

| 文件 | 内容 |
|------|------|
| `octave/navier_stokes.m` | N-S 方程简化形式的符号推导 |
| `octave/stream_function.m` | 流函数与势函数计算 |
| `octave/simple_flows.m` | 简单流动的复势与速度场 |
| `octave/dimensional_analysis.m` | 量纲分析与 Buckingham Pi 定理 |
| `octave/rayleigh_bubble.m` | 瑞利空化泡完整实现 |
| `maxima/navier_stokes.mac` | N-S 方程 Maxima 实现 |
| `maxima/stream_function.mac` | 流函数 Maxima 实现 |
| `maxima/simple_flows.mac` | 简单流动 Maxima 实现 |
| `maxima/dimensional_analysis.mac` | 量纲分析 Maxima 实现 |
| `maxima/rayleigh_bubble.mac` | 瑞利空化泡 Maxima 实现 |
