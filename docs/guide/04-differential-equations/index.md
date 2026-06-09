# 第4章：微分方程

<div class="difficulty-indicator">★★★☆☆</div>

## 概述

微分方程是描述自然现象和工程问题的核心数学工具。本章将介绍如何使用计算机代数系统（CAS）求解各类微分方程，包括常微分方程（ODE）和偏微分方程（PDE）的基础概念。

## 什么是微分方程？

微分方程是包含未知函数及其导数的方程。根据导数类型的不同，可分为：

<div class="concept-tooltip" data-tooltip="仅包含一个自变量的导数">**常微分方程（ODE）**</div>：仅包含一个自变量的导数  
<div class="concept-tooltip" data-tooltip="包含多个自变量的偏导数">**偏微分方程（PDE）**</div>：包含多个自变量的偏导数

### 基本概念

- **阶数**：方程中出现的最高阶导数的阶数
- **解**：满足微分方程的函数
- **通解**：包含任意常数的解族
- **特解**：满足初始/边界条件的特定解

## 1. 一阶常微分方程

### 1.1 可分离变量方程

形如 $\frac{dy}{dx} = f(x)g(y)$ 的方程称为可分离变量方程。

**求解步骤**：
1. 分离变量：$\frac{1}{g(y)} dy = f(x) dx$
2. 两边积分：$\int \frac{1}{g(y)} dy = \int f(x) dx$

**示例**：求解 $\frac{dy}{dx} = xy$

分离变量：$\frac{1}{y} dy = x dx$

积分：$\ln|y| = \frac{x^2}{2} + C$

解：$y = Ce^{x^2/2}$

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```octave
% 使用符号包求解可分离变量方程
pkg load symbolic

% 定义符号变量
syms x y(x)

% 定义微分方程：dy/dx = x*y
ode = diff(y, x) == x * y;

% 求解微分方程
y_sol = dsolve(ode);

% 显示通解
disp('通解:');
disp(y_sol);

% 求满足初始条件 y(0)=1 的特解
y_specific = dsolve(ode, y(0) == 1);
disp('满足 y(0)=1 的特解:');
disp(y_specific);

% 可视化解曲线
figure;
fplot(@(x) exp(x.^2/2), [-2, 2], 'b-', 'LineWidth', 2);
hold on;
fplot(@(x) 2*exp(x.^2/2), [-2, 2], 'r--', 'LineWidth', 2);
fplot(@(x) 0.5*exp(x.^2/2), [-2, 2], 'g-.', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('微分方程 dy/dx = xy 的解曲线');
legend('C=1', 'C=2', 'C=0.5');
grid on;
```

</div>
</div>
</div>

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 使用 Maxima 求解可分离变量方程 */

/* 定义微分方程 dy/dx = x*y */
ode: 'diff(y, x) = x * y;

/* 求解微分方程通解 */
sol: ode2(ode, y, x);
print("通解: ", sol);

/* 求满足初始条件 y(0)=1 的特解 */
sol_specific: ic1(sol, x=0, y=1);
print("满足 y(0)=1 的特解: ", sol_specific);

/* 绘制解曲线 */
wxplot2d([exp(x^2/2), 2*exp(x^2/2), 0.5*exp(x^2/2)], 
         [x, -2, 2], 
         [title, "微分方程 dy/dx = xy 的解曲线"],
         [legend, "C=1", "C=2", "C=0.5"],
         [xlabel, "x"], [ylabel, "y"]);
```

</div>
</div>
</div>

### 1.2 线性微分方程

一阶线性微分方程的标准形式为：$\frac{dy}{dx} + P(x)y = Q(x)$

**通解公式**：$y = e^{-\int P(x)dx} \left( \int Q(x)e^{\int P(x)dx} dx + C \right)$

**示例**：求解 $\frac{dy}{dx} + \frac{2}{x}y = x^2$

这里 $P(x) = \frac{2}{x}$，$Q(x) = x^2$

计算积分因子：$\mu(x) = e^{\int \frac{2}{x} dx} = e^{2\ln|x|} = x^2$

通解：$y = \frac{1}{x^2} \left( \int x^2 \cdot x^2 dx + C \right) = \frac{1}{x^2} \left( \frac{x^5}{5} + C \right) = \frac{x^3}{5} + \frac{C}{x^2}$

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```octave
% 求解一阶线性微分方程
pkg load symbolic

syms x y(x)

% 定义微分方程：dy/dx + (2/x)*y = x^2
P = 2/x;
Q = x^2;
ode = diff(y, x) + P * y == Q;

% 求解微分方程
y_sol = dsolve(ode);
disp('通解:');
disp(y_sol);

% 求满足初始条件 y(1)=1 的特解
y_specific = dsolve(ode, y(1) == 1);
disp('满足 y(1)=1 的特解:');
disp(y_specific);

% 绘制特解曲线
figure;
fplot(@(x) x.^3/5 + 4./(5*x.^2), [0.5, 3], 'b-', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('微分方程 dy/dx + (2/x)y = x^2 的特解 (y(1)=1)');
grid on;
```

</div>
</div>
</div>

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 求解一阶线性微分方程 */

/* 定义微分方程 dy/dx + (2/x)*y = x^2 */
ode: 'diff(y, x) + (2/x)*y = x^2;

/* 求解微分方程通解 */
sol: ode2(ode, y, x);
print("通解: ", sol);

/* 求满足初始条件 y(1)=1 的特解 */
sol_specific: ic1(sol, x=1, y=1);
print("满足 y(1)=1 的特解: ", sol_specific);

/* 绘制特解曲线 */
wxplot2d(x^3/5 + 4/(5*x^2), [x, 0.5, 3],
         [title, "微分方程 dy/dx + (2/x)y = x^2 的特解"],
         [xlabel, "x"], [ylabel, "y"]);
```

</div>
</div>
</div>

### 1.3 恰当微分方程

形如 $M(x,y)dx + N(x,y)dy = 0$ 的方程，若满足 $\frac{\partial M}{\partial y} = \frac{\partial N}{\partial x}$，则称为恰当方程。

**求解方法**：存在函数 $F(x,y)$ 使得 $dF = Mdx + Ndy$，则通解为 $F(x,y) = C$。

**示例**：求解 $(2xy + 3)dx + (x^2 - 1)dy = 0$

验证恰当性：$\frac{\partial}{\partial y}(2xy + 3) = 2x$，$\frac{\partial}{\partial x}(x^2 - 1) = 2x$，相等，所以是恰当方程。

求解：$F = \int (2xy + 3)dx = x^2y + 3x + g(y)$

$\frac{\partial F}{\partial y} = x^2 + g'(y) = x^2 - 1$，所以 $g'(y) = -1$，$g(y) = -y$

通解：$x^2y + 3x - y = C$

## 2. 高阶常微分方程

### 2.1 常系数线性齐次方程

二阶常系数线性齐次方程：$y'' + py' + qy = 0$

**特征方程**：$r^2 + pr + q = 0$

根据特征根的情况：
- 两个不同实根 $r_1, r_2$：$y = C_1 e^{r_1 x} + C_2 e^{r_2 x}$
- 重根 $r$：$y = (C_1 + C_2 x)e^{rx}$
- 共轭复根 $\alpha \pm \beta i$：$y = e^{\alpha x}(C_1 \cos\beta x + C_2 \sin\beta x)$

**示例**：求解 $y'' - 3y' + 2y = 0$

特征方程：$r^2 - 3r + 2 = 0$，解得 $r_1 = 1$，$r_2 = 2$

通解：$y = C_1 e^x + C_2 e^{2x}$

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```octave
% 求解二阶常系数线性齐次方程
pkg load symbolic

syms x y(x)

% 定义微分方程：y'' - 3y' + 2y = 0
ode = diff(y, x, 2) - 3*diff(y, x) + 2*y == 0;

% 求解微分方程
y_sol = dsolve(ode);
disp('通解:');
disp(y_sol);

% 求满足初始条件 y(0)=1, y'(0)=0 的特解
Dy = diff(y, x);
y_specific = dsolve(ode, y(0) == 1, Dy(0) == 0);
disp('满足 y(0)=1, y''(0)=0 的特解:');
disp(y_specific);

% 绘制特解曲线
figure;
fplot(@(x) 2*exp(x) - exp(2*x), [-1, 2], 'b-', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('微分方程 y'''' - 3y'' + 2y = 0 的特解');
grid on;
```

</div>
</div>
</div>

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 求解二阶常系数线性齐次方程 */

/* 定义微分方程 y'' - 3y' + 2y = 0 */
ode: 'diff(y, x, 2) - 3*'diff(y, x) + 2*y = 0;

/* 求解微分方程通解 */
sol: ode2(ode, y, x);
print("通解: ", sol);

/* 求满足初始条件 y(0)=1, y'(0)=0 的特解 */
sol_specific: ic2(sol, x=0, y=1, 'diff(y,x)=0);
print("满足 y(0)=1, y'(0)=0 的特解: ", sol_specific);

/* 绘制特解曲线 */
wxplot2d(2*exp(x) - exp(2*x), [x, -1, 2],
         [title, "微分方程 y'' - 3y' + 2y = 0 的特解"],
         [xlabel, "x"], [ylabel, "y"]);
```

</div>
</div>
</div>

### 2.2 常系数线性非齐次方程

二阶常系数线性非齐次方程：$y'' + py' + qy = f(x)$

**求解方法**：通解 = 齐次方程通解 + 非齐次方程特解

**待定系数法**：根据 $f(x)$ 的形式设特解形式

**示例**：求解 $y'' - 3y' + 2y = e^{3x}$

齐次方程通解：$y_h = C_1 e^x + C_2 e^{2x}$

设特解形式：$y_p = Ae^{3x}$

代入方程：$9A e^{3x} - 9A e^{3x} + 2A e^{3x} = e^{3x}$，解得 $A = \frac{1}{2}$

通解：$y = C_1 e^x + C_2 e^{2x} + \frac{1}{2}e^{3x}$

## 3. 偏微分方程基础

### 3.1 偏微分方程的分类

二阶线性偏微分方程的一般形式：
$A\frac{\partial^2 u}{\partial x^2} + 2B\frac{\partial^2 u}{\partial x \partial y} + C\frac{\partial^2 u}{\partial y^2} + D\frac{\partial u}{\partial x} + E\frac{\partial u}{\partial y} + Fu = G$

根据判别式 $\Delta = B^2 - AC$：
- $\Delta > 0$：双曲型（波动方程）
- $\Delta = 0$：抛物型（热传导方程）
- $\Delta < 0$：椭圆型（拉普拉斯方程）

### 3.2 经典偏微分方程

#### 波动方程
$\frac{\partial^2 u}{\partial t^2} = c^2 \frac{\partial^2 u}{\partial x^2}$

描述振动、波动现象。

#### 热传导方程
$\frac{\partial u}{\partial t} = k \frac{\partial^2 u}{\partial x^2}$

描述热量扩散、粒子扩散现象。

#### 拉普拉斯方程
$\nabla^2 u = \frac{\partial^2 u}{\partial x^2} + \frac{\partial^2 u}{\partial y^2} = 0$

描述稳态温度分布、静电场等。

### 3.3 分离变量法简介

分离变量法是求解偏微分方程的基本方法之一。

**基本思想**：假设解可以写成各个自变量函数的乘积。

**示例**：求解一维波动方程的初边值问题
$$
\begin{cases}
\frac{\partial^2 u}{\partial t^2} = c^2 \frac{\partial^2 u}{\partial x^2}, & 0 < x < L, t > 0 \\
u(0,t) = u(L,t) = 0, & t > 0 \\
u(x,0) = f(x), \frac{\partial u}{\partial t}(x,0) = 0, & 0 < x < L
\end{cases}
$$

设 $u(x,t) = X(x)T(t)$，代入方程分离变量得：
$$
\frac{T''}{c^2 T} = \frac{X''}{X} = -\lambda
$$

求解两个常微分方程，利用边界条件得到特征值和特征函数。

## 4. 边值问题

### 4.1 边值问题的概念

边值问题是在微分方程基础上，给定边界条件（而非初始条件）的问题。

**典型形式**：
$$
\begin{cases}
y'' = f(x, y, y'), & a < x < b \\
y(a) = \alpha, y(b) = \beta
\end{cases}
$$

### 4.2 打靶法（Shooting Method）

**基本思想**：将边值问题转化为初值问题，通过调整初始斜率使解满足另一端的边界条件。

**算法步骤**：
1. 猜测初始斜率 $y'(a) = s_0$
2. 求解初值问题得到 $y(b; s_0)$
3. 根据 $y(b; s_k) - \beta$ 调整 $s_{k+1}$
4. 重复直到满足精度要求

### 4.3 有限差分法（Finite Difference Method）

**基本思想**：用差商近似导数，将微分方程转化为代数方程组。

**二阶中心差分**：
$$
y''(x_i) \approx \frac{y_{i-1} - 2y_i + y_{i+1}}{h^2}
$$

**示例**：求解边值问题
$$
\begin{cases}
y'' = -4y + 4x, & 0 < x < 1 \\
y(0) = 0, y(1) = 2
\end{cases}
$$

将区间 $[0,1]$ 分成 $n$ 等份，步长 $h = 1/n$，得到线性方程组：
$$
\frac{y_{i-1} - 2y_i + y_{i+1}}{h^2} = -4y_i + 4x_i
$$

整理为矩阵形式求解。

## 5. 数值解与符号解

### 5.1 符号解的优势

- 给出精确的解析表达式
- 便于理论分析和推导
- 可以研究参数对解的影响

### 5.2 数值解的优势

- 适用于复杂方程（无解析解的情况）
- 计算速度快
- 可以处理实际工程问题

### 5.3 CAS中的微分方程求解

**Octave**：
- 符号解：使用 `dsolve` 函数
- 数值解：使用 `ode45`、`ode23` 等函数

**Maxima**：
- 符号解：使用 `ode2`、`desolve` 函数
- 数值解：使用 `rk` 函数（龙格-库塔法）

## 6. 应用实例

### 6.1 物理学中的应用

**简谐振动**：$m\frac{d^2x}{dt^2} + kx = 0$

**阻尼振动**：$m\frac{d^2x}{dt^2} + c\frac{dx}{dt} + kx = 0$

**受迫振动**：$m\frac{d^2x}{dt^2} + c\frac{dx}{dt} + kx = F_0\cos\omega t$

### 6.2 工程学中的应用

**RLC电路**：$L\frac{d^2q}{dt^2} + R\frac{dq}{dt} + \frac{1}{C}q = E(t)$

**梁的弯曲**：$EI\frac{d^4y}{dx^4} = w(x)$

**热传导**：$\rho c_p \frac{\partial T}{\partial t} = k\nabla^2 T + Q$

## 7. 常见问题与技巧

### 7.1 方程类型判断

1. 检查是否可分离变量
2. 检查是否为线性方程
3. 检查是否为恰当方程
4. 对于高阶方程，检查系数是否为常数

### 7.2 求解策略

1. 尝试符号求解
2. 若无解析解，考虑数值方法
3. 利用对称性简化问题
4. 对于复杂PDE，考虑数值方法（有限差分、有限元等）

### 7.3 验证解的正确性

1. 将解代入原方程验证
2. 检查边界/初始条件
3. 使用不同方法求解比较结果
4. 绘制解曲线观察合理性

## 本章小结

本章介绍了微分方程的基本概念和求解方法：

1. **一阶ODE**：可分离变量、线性、恰当方程
2. **高阶ODE**：常系数线性齐次/非齐次方程
3. **PDE基础**：分类、经典方程、分离变量法简介
4. **边值问题**：打靶法、有限差分法概念

通过CAS工具，我们可以高效地求解各类微分方程，验证解析结果，并进行数值模拟。

## 练习题

### 基础练习

1. 求解微分方程：$\frac{dy}{dx} = \frac{y}{x}$
2. 求解微分方程：$y'' + 4y = 0$
3. 验证方程 $(3x^2 + 2xy)dx + (x^2 - 2y)dy = 0$ 是否为恰当方程

### 进阶练习

4. 求解边值问题：$y'' = y, y(0)=0, y(1)=1$
5. 使用分离变量法求解一维热传导方程的初边值问题
6. 比较符号解与数值解的精度差异

## 参考资料

1. 《常微分方程》（王高雄等）
2. 《偏微分方程》（周蜀林）
3. 《数值分析》（李庆扬等）
4. Octave符号包文档
5. Maxima官方文档

## 下一章

[第5章：函数分析 →](/guide/05-functional-analysis/)