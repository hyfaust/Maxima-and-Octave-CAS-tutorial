# 第2章：微积分基础

> 难度：★★☆☆☆ 基础

## 简介

微积分是数学分析的核心分支，也是科学和工程领域中不可或缺的工具。本章将介绍如何使用计算机代数系统（CAS）进行微积分计算，包括极限、导数、积分和级数展开。我们将同时使用 **Octave**（带符号计算包）和 **Maxima** 来演示这些概念，帮助你理解两种系统在符号计算方面的异同。

:::tip 学习目标
完成本章后，你将能够：
- 使用 CAS 计算各种类型的极限
- 掌握导数的计算方法，包括链式法则、乘积法则和隐函数求导
- 进行不定积分和定积分的计算
- 使用泰勒级数展开函数并分析收敛性
:::

:::warning 先决条件
在学习本章之前，你应该已经：
- 了解基本的代数运算
- 熟悉函数的概念
- 完成了第1章《符号计算基础》的学习
:::

## 1. 极限与连续性

**极限**：极限描述了当自变量趋近于某个值时，函数值的变化趋势。形式化定义：对于函数 $f(x)$，如果对于任意 $\epsilon > 0$，存在 $\delta > 0$，使得当 $0 < |x - a| < \delta$ 时，有 $|f(x) - L| < \epsilon$，则称 $L$ 为 $f(x)$ 在 $x \to a$ 时的极限，记作 $\lim_{x \to a} f(x) = L$。

### 1.1 基本极限计算

在 CAS 中，我们使用 `limit()` 函数来计算极限。让我们从几个基本例子开始。

**Octave 实现：**

```octave
% 加载符号计算包
pkg load symbolic

% 定义符号变量
syms x

% 计算基本极限
f1 = sin(x)/x;
lim1 = limit(f1, x, 0);
disp('lim(sin(x)/x, x->0) = ')
disp(lim1)

% 计算无穷远处的极限
f2 = (1 + 1/x)^x;
lim2 = limit(f2, x, inf);
disp('lim((1+1/x)^x, x->inf) = ')
disp(lim2)

% 计算单侧极限（右极限）
f3 = 1/x;
lim3_right = limit(f3, x, 0, 'right');
lim3_left = limit(f3, x, 0, 'left');
disp('lim(1/x, x->0+) = ')
disp(lim3_right)
disp('lim(1/x, x->0-) = ')
disp(lim3_left)
```

**Maxima 实现：**

```maxima
/* 计算基本极限 */
f1: sin(x)/x;
lim1: limit(f1, x, 0);
print("lim(sin(x)/x, x->0) = ", lim1);

/* 计算无穷远处的极限 */
f2: (1 + 1/x)^x;
lim2: limit(f2, x, inf);
print("lim((1+1/x)^x, x->inf) = ", lim2);

/* 计算单侧极限 */
f3: 1/x;
lim3_right: limit(f3, x, 0, plus);
lim3_left: limit(f3, x, 0, minus);
print("lim(1/x, x->0+) = ", lim3_right);
print("lim(1/x, x->0-) = ", lim3_left);
```

### 1.2 物理应用示例：瞬时速度

考虑一个物体沿直线运动，其位置函数为 $s(t) = t^2 + 2t$（单位：米）。求 $t = 3$ 秒时的瞬时速度。

瞬时速度定义为位置函数的导数，即：
$$v(t) = \lim_{\Delta t \to 0} \frac{s(t + \Delta t) - s(t)}{\Delta t}$$

**Octave 实现：**

```octave
pkg load symbolic
syms t dt

% 定义位置函数
s = t^2 + 2*t;

% 计算瞬时速度（导数定义）
v = limit((subs(s, t, t+dt) - s)/dt, dt, 0);
disp('瞬时速度 v(t) = ')
disp(v)

% 在 t=3 时的速度
v_at_3 = subs(v, t, 3);
disp('v(3) = ')
disp(v_at_3)
```

**Maxima 实现：**

```maxima
/* 定义位置函数 */
s: t^2 + 2*t;

/* 计算瞬时速度（导数定义） */
v: limit((subst(t+dt, t, s) - s)/dt, dt, 0);
print("瞬时速度 v(t) = ", v);

/* 在 t=3 时的速度 */
v_at_3: subst(t=3, v);
print("v(3) = ", v_at_3);
```

## 2. 导数与微分

**导数**：导数表示函数在某一点处的瞬时变化率。几何上，导数是函数图像在该点处切线的斜率。如果 $f(x)$ 在 $x=a$ 处可导，则 $f'(a) = \lim_{h \to 0} \frac{f(a+h) - f(a)}{h}$。

### 2.1 基本导数计算

CAS 提供了 `diff()` 函数来计算导数。我们可以计算一阶、二阶甚至高阶导数。

**Octave 实现：**

```octave
pkg load symbolic
syms x

% 基本导数计算
f = x^3 - 2*x^2 + 5*x - 7;
df = diff(f, x);
d2f = diff(f, x, 2);
disp('f(x) = ')
disp(f)
disp('f''(x) = ')
disp(df)
disp('f''''(x) = ')
disp(d2f)

% 三角函数导数
g = sin(x)*cos(x);
dg = diff(g, x);
disp('sin(x)cos(x) 的导数: ')
disp(dg)
disp('化简后: ')
disp(simplify(dg))
```

**Maxima 实现：**

```maxima
/* 基本导数计算 */
f: x^3 - 2*x^2 + 5*x - 7;
df: diff(f, x);
d2f: diff(f, x, 2);
print("f(x) = ", f);
print("f'(x) = ", df);
print("f''(x) = ", d2f);

/* 三角函数导数 */
g: sin(x)*cos(x);
dg: diff(g, x);
print("sin(x)cos(x) 的导数: ", dg);
print("化简后: ", trigsimp(dg));
```

### 2.2 链式法则

链式法则用于计算复合函数的导数。如果 $y = f(g(x))$，则：
$$\frac{dy}{dx} = f'(g(x)) \cdot g'(x)$$

**Octave 实现：**

```octave
pkg load symbolic
syms x

% 链式法则示例
% 计算 sin(x^2) 的导数
f = sin(x^2);
df = diff(f, x);
disp('sin(x^2) 的导数: ')
disp(df)

% 计算 e^(3*x^2 + 1) 的导数
g = exp(3*x^2 + 1);
dg = diff(g, x);
disp('e^(3x^2+1) 的导数: ')
disp(dg)

% 更复杂的例子：ln(sqrt(1+x^2))
h = log(sqrt(1 + x^2));
dh = diff(h, x);
dh_simplified = simplify(dh);
disp('ln(sqrt(1+x^2)) 的导数: ')
disp(dh_simplified)
```

**Maxima 实现：**

```maxima
/* 链式法则示例 */
/* 计算 sin(x^2) 的导数 */
f: sin(x^2);
df: diff(f, x);
print("sin(x^2) 的导数: ", df);

/* 计算 e^(3*x^2 + 1) 的导数 */
g: exp(3*x^2 + 1);
dg: diff(g, x);
print("e^(3x^2+1) 的导数: ", dg);

/* 更复杂的例子：ln(sqrt(1+x^2)) */
h: log(sqrt(1 + x^2));
dh: diff(h, x);
dh_simplified: ratsimp(dh);
print("ln(sqrt(1+x^2)) 的导数: ", dh_simplified);
```

### 2.3 乘积法则与商法则

乘积法则：$(uv)' = u'v + uv'$

商法则：$\left(\frac{u}{v}\right)' = \frac{u'v - uv'}{v^2}$

**Octave 实现：**

```octave
pkg load symbolic
syms x

% 乘积法则示例
u = x^2;
v = sin(x);
f = u * v;
df = diff(f, x);
disp('(x^2 * sin(x))'' = ')
disp(df)

% 验证乘积法则
du = diff(u, x);
dv = diff(v, x);
product_rule = du*v + u*dv;
disp('使用乘积法则: ')
disp(simplify(product_rule))

% 商法则示例
g = cos(x) / (1 + x^2);
dg = diff(g, x);
disp('(cos(x)/(1+x^2))'' = ')
disp(simplify(dg))
```

**Maxima 实现：**

```maxima
/* 乘积法则示例 */
u: x^2;
v: sin(x);
f: u * v;
df: diff(f, x);
print("(x^2 * sin(x))' = ", df);

/* 验证乘积法则 */
du: diff(u, x);
dv: diff(v, x);
product_rule: du*v + u*dv;
print("使用乘积法则: ", ratsimp(product_rule));

/* 商法则示例 */
g: cos(x) / (1 + x^2);
dg: diff(g, x);
print("(cos(x)/(1+x^2))' = ", ratsimp(dg));
```

### 2.4 隐函数求导

对于由方程 $F(x, y) = 0$ 定义的隐函数，我们可以使用隐函数求导法则。

**Octave 实现：**

```octave
pkg load symbolic
syms x y

% 隐函数求导示例
% 考虑圆方程 x^2 + y^2 = 25
F = x^2 + y^2 - 25;

% 对 x 求导，将 y 视为 x 的函数
dF_dx = diff(F, x) + diff(F, y) * diff(y, x);
disp('dF/dx = ')
disp(dF_dx)

% 解出 dy/dx
dy_dx = solve(dF_dx, diff(y, x));
disp('dy/dx = ')
disp(dy_dx)

% 在点 (3, 4) 处的导数值
slope = subs(dy_dx, [x, y], [3, 4]);
disp('在 (3,4) 处的斜率: ')
disp(slope)
```

**Maxima 实现：**

```maxima
/* 隐函数求导示例 */
/* 考虑圆方程 x^2 + y^2 = 25 */
depends(y, x);
F: x^2 + y^2 - 25;

/* 对 x 求导 */
dF_dx: diff(F, x);
print("dF/dx = ", dF_dx);

/* 解出 dy/dx */
dy_dx: solve(dF_dx, 'diff(y, x));
print("dy/dx = ", dy_dx);

/* 在点 (3, 4) 处的导数值 */
slope: subst([x=3, y=4], dy_dx);
print("在 (3,4) 处的斜率: ", slope);
```

### 2.5 物理应用：运动学

一个物体沿曲线运动，其轨迹由参数方程给出：
$$x(t) = 3t^2, \quad y(t) = 2t^3$$

求 $t = 1$ 时的速度大小和方向。

**Octave 实现：**

```octave
pkg load symbolic
syms t

% 参数方程
x = 3*t^2;
y = 2*t^3;

% 速度分量
vx = diff(x, t);
vy = diff(y, t);
disp('速度分量: ')
disp(['vx = ', char(vx)])
disp(['vy = ', char(vy)])

% 速度大小
v_magnitude = sqrt(vx^2 + vy^2);
v_at_1 = subs(v_magnitude, t, 1);
disp('t=1 时速度大小: ')
disp(double(v_at_1))

% 速度方向（角度）
theta = atan(vy/vx);
theta_at_1 = subs(theta, t, 1);
disp('t=1 时速度方向（弧度）: ')
disp(double(theta_at_1))
disp('角度: ')
disp(double(theta_at_1) * 180/pi)
```

**Maxima 实现：**

```maxima
/* 参数方程 */
x: 3*t^2;
y: 2*t^3;

/* 速度分量 */
vx: diff(x, t);
vy: diff(y, t);
print("速度分量: vx = ", vx, ", vy = ", vy);

/* 速度大小 */
v_magnitude: sqrt(vx^2 + vy^2);
v_at_1: subst(t=1, v_magnitude);
print("t=1 时速度大小: ", float(v_at_1));

/* 速度方向（角度） */
theta: atan(vy/vx);
theta_at_1: subst(t=1, theta);
print("t=1 时速度方向（弧度）: ", float(theta_at_1));
print("角度: ", float(theta_at_1 * 180/%pi));
```

## 3. 积分

**积分**：积分是导数的逆运算。不定积分 $\int f(x) dx$ 是求原函数的过程，而定积分 $\int_a^b f(x) dx$ 表示函数在区间 $[a, b]$ 上的累积效应，几何上表示曲线下的面积。

### 3.1 不定积分

不定积分是求原函数的过程。CAS 使用 `integrate()` 函数来计算不定积分。

**Octave 实现：**

```octave
pkg load symbolic
syms x

% 基本不定积分
f1 = x^2;
F1 = int(f1, x);
disp('∫x^2 dx = ')
disp(F1)

% 三角函数积分
f2 = sin(x);
F2 = int(f2, x);
disp('∫sin(x) dx = ')
disp(F2)

% 指数函数积分
f3 = exp(2*x);
F3 = int(f3, x);
disp('∫e^(2x) dx = ')
disp(F3)

% 有理函数积分
f4 = 1/(1 + x^2);
F4 = int(f4, x);
disp('∫1/(1+x^2) dx = ')
disp(F4)

% 验证积分结果
disp('验证: d/dx(∫x^2 dx) = ')
disp(diff(F1, x))
```

**Maxima 实现：**

```maxima
/* 基本不定积分 */
f1: x^2;
F1: integrate(f1, x);
print("∫x^2 dx = ", F1);

/* 三角函数积分 */
f2: sin(x);
F2: integrate(f2, x);
print("∫sin(x) dx = ", F2);

/* 指数函数积分 */
f3: exp(2*x);
F3: integrate(f3, x);
print("∫e^(2x) dx = ", F3);

/* 有理函数积分 */
f4: 1/(1 + x^2);
F4: integrate(f4, x);
print("∫1/(1+x^2) dx = ", F4);

/* 验证积分结果 */
print("验证: d/dx(∫x^2 dx) = ", diff(F1, x));
```

### 3.2 定积分

定积分 $\int_a^b f(x) dx$ 可以通过牛顿-莱布尼茨公式计算：
$$\int_a^b f(x) dx = F(b) - F(a)$$
其中 $F(x)$ 是 $f(x)$ 的原函数。

**Octave 实现：**

```octave
pkg load symbolic
syms x

% 定积分计算
f = x^3 - 2*x;
% 计算从 0 到 2 的定积分
definite_integral = int(f, x, 0, 2);
disp('∫_0^2 (x^3 - 2x) dx = ')
disp(definite_integral)

% 计算面积
% 曲线 y = x^2 与 x 轴从 0 到 1 围成的面积
area = int(x^2, x, 0, 1);
disp('曲线 y=x^2 与 x 轴从 0 到 1 围成的面积: ')
disp(area)

% 三角函数定积分
tri_integral = int(sin(x), x, 0, %pi);
disp('∫_0^π sin(x) dx = ')
disp(tri_integral)
```

**Maxima 实现：**

```maxima
/* 定积分计算 */
f: x^3 - 2*x;
/* 计算从 0 到 2 的定积分 */
definite_integral: integrate(f, x, 0, 2);
print("∫_0^2 (x^3 - 2x) dx = ", definite_integral);

/* 计算面积 */
/* 曲线 y = x^2 与 x 轴从 0 到 1 围成的面积 */
area: integrate(x^2, x, 0, 1);
print("曲线 y=x^2 与 x 轴从 0 到 1 围成的面积: ", area);

/* 三角函数定积分 */
tri_integral: integrate(sin(x), x, 0, %pi);
print("∫_0^π sin(x) dx = ", tri_integral);
```

### 3.3 换元积分法

换元积分法是积分计算中的重要技巧。对于积分 $\int f(g(x))g'(x) dx$，令 $u = g(x)$，则积分变为 $\int f(u) du$。

**Octave 实现：**

```octave
pkg load symbolic
syms x u

% 换元积分示例
% 计算 ∫ 2x * cos(x^2) dx
f = 2*x * cos(x^2);
F = int(f, x);
disp('∫ 2x*cos(x^2) dx = ')
disp(F)

% 手动换元验证
% 令 u = x^2, du = 2x dx
u = x^2;
du = diff(u, x);
f_sub = cos(u) * du;
F_sub = int(f_sub, u);
disp('使用换元法: ∫ cos(u) du = ')
disp(subs(F_sub, u, x^2))

% 更复杂的例子：∫ x * sqrt(1 + x^2) dx
g = x * sqrt(1 + x^2);
G = int(g, x);
disp('∫ x*sqrt(1+x^2) dx = ')
disp(G)
```

**Maxima 实现：**

```maxima
/* 换元积分示例 */
/* 计算 ∫ 2x * cos(x^2) dx */
f: 2*x * cos(x^2);
F: integrate(f, x);
print("∫ 2x*cos(x^2) dx = ", F);

/* 手动换元验证 */
/* 令 u = x^2, du = 2x dx */
u: x^2;
du: diff(u, x);
f_sub: cos(u) * du;
F_sub: integrate(f_sub, u);
print("使用换元法: ∫ cos(u) du = ", subst(u=x^2, F_sub));

/* 更复杂的例子：∫ x * sqrt(1 + x^2) dx */
g: x * sqrt(1 + x^2);
G: integrate(g, x);
print("∫ x*sqrt(1+x^2) dx = ", G);
```

### 3.4 物理应用：变力做功

一个弹簧的力与位移关系为 $F(x) = 5x$（单位：牛顿），求将弹簧从平衡位置拉伸 0.2 米所做的功。

功的计算公式为：
$$W = \int_0^{0.2} F(x) dx$$

**Octave 实现：**

```octave
pkg load symbolic
syms x

% 弹簧力函数
F = 5*x;  % 牛顿

% 计算功
W = int(F, x, 0, 0.2);
disp('弹簧从 0 拉伸到 0.2 米所做的功: ')
disp(W)
disp('数值结果（焦耳）: ')
disp(double(W))

% 势能函数（弹性势能）
U = int(F, x);
disp('弹性势能函数: ')
disp(U)
disp('在 x=0.2 米处的势能: ')
disp(double(subs(U, x, 0.2)))
```

**Maxima 实现：**

```maxima
/* 弹簧力函数 */
F: 5*x;  /* 牛顿 */

/* 计算功 */
W: integrate(F, x, 0, 0.2);
print("弹簧从 0 拉伸到 0.2 米所做的功: ", W);
print("数值结果（焦耳）: ", float(W));

/* 势能函数（弹性势能） */
U: integrate(F, x);
print("弹性势能函数: ", U);
print("在 x=0.2 米处的势能: ", float(subst(x=0.2, U)));
```

## 4. 泰勒级数展开

**泰勒级数**：泰勒级数是将函数表示为无穷级数的方法。如果函数 $f(x)$ 在 $x=a$ 处无限可微，则其泰勒级数为：$f(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!}(x-a)^n$。当 $a=0$ 时，称为麦克劳林级数。

### 4.1 基本泰勒展开

CAS 提供了 `taylor()` 函数来计算泰勒级数展开。

**Octave 实现：**

```octave
pkg load symbolic
syms x

% 泰勒级数展开
% e^x 在 x=0 处的展开（麦克劳林级数）
f1 = exp(x);
taylor_f1 = taylor(f1, x, 0, 'Order', 6);
disp('e^x 的麦克劳林级数（前5项）: ')
disp(taylor_f1)

% sin(x) 的展开
f2 = sin(x);
taylor_f2 = taylor(f2, x, 0, 'Order', 8);
disp('sin(x) 的麦克劳林级数: ')
disp(taylor_f2)

% cos(x) 的展开
f3 = cos(x);
taylor_f3 = taylor(f3, x, 0, 'Order', 8);
disp('cos(x) 的麦克劳林级数: ')
disp(taylor_f3)

% ln(1+x) 的展开
f4 = log(1 + x);
taylor_f4 = taylor(f4, x, 0, 'Order', 6);
disp('ln(1+x) 的麦克劳林级数: ')
disp(taylor_f4)
```

**Maxima 实现：**

```maxima
/* 泰勒级数展开 */
/* e^x 在 x=0 处的展开（麦克劳林级数） */
f1: exp(x);
taylor_f1: taylor(f1, x, 0, 6);
print("e^x 的麦克劳林级数（前5项）: ", taylor_f1);

/* sin(x) 的展开 */
f2: sin(x);
taylor_f2: taylor(f2, x, 0, 8);
print("sin(x) 的麦克劳林级数: ", taylor_f2);

/* cos(x) 的展开 */
f3: cos(x);
taylor_f3: taylor(f3, x, 0, 8);
print("cos(x) 的麦克劳林级数: ", taylor_f3);

/* ln(1+x) 的展开 */
f4: log(1 + x);
taylor_f4: taylor(f4, x, 0, 6);
print("ln(1+x) 的麦克劳林级数: ", taylor_f4);
```

### 4.2 收敛性分析

泰勒级数的收敛性是一个重要问题。我们可以通过图形来直观地观察级数的收敛情况。

**Octave 实现：**

```octave
pkg load symbolic
syms x

% 泰勒级数的收敛性分析
% e^x 的不同阶数近似
f = exp(x);
x_vals = linspace(-2, 2, 100);
f_vals = double(subs(f, x, x_vals));

figure;
hold on;
plot(x_vals, f_vals, 'k-', 'LineWidth', 2, 'DisplayName', 'e^x');

% 不同阶数的泰勒近似
orders = [2, 4, 6, 8];
colors = ['r', 'g', 'b', 'm'];

for i = 1:length(orders)
    taylor_approx = taylor(f, x, 0, 'Order', orders(i));
    approx_vals = double(subs(taylor_approx, x, x_vals));
    plot(x_vals, approx_vals, [colors(i), '--'], ...
        'DisplayName', sprintf('泰勒展开 (阶数=%d)', orders(i)));
end

xlabel('x');
ylabel('y');
title('e^x 的泰勒级数收敛性');
legend('Location', 'northwest');
grid on;
hold off;
```

**Maxima 实现：**

```maxima
/* 泰勒级数的收敛性分析 */
/* e^x 的不同阶数近似 */
f: exp(x);

/* 计算不同阶数的泰勒展开 */
taylor_2: taylor(f, x, 0, 2);
taylor_4: taylor(f, x, 0, 4);
taylor_6: taylor(f, x, 0, 6);

print("2阶泰勒展开: ", taylor_2);
print("4阶泰勒展开: ", taylor_4);
print("6阶泰勒展开: ", taylor_6);

/* 比较在 x=0.5 处的近似值 */
exact_value: float(subst(x=0.5, f));
approx_2: float(subst(x=0.5, taylor_2));
approx_4: float(subst(x=0.5, taylor_4));
approx_6: float(subst(x=0.5, taylor_6));

print("x=0.5 处的精确值: ", exact_value);
print("2阶近似: ", approx_2, " 误差: ", abs(exact_value - approx_2));
print("4阶近似: ", approx_4, " 误差: ", abs(exact_value - approx_4));
print("6阶近似: ", approx_6, " 误差: ", abs(exact_value - approx_6));
```

### 4.3 物理应用：小角度近似

在物理学中，小角度近似是一个常用技巧。当角度 $\theta$ 很小时，$\sin(\theta) \approx \theta$。让我们看看这个近似的精度。

**Octave 实现：**

```octave
pkg load symbolic
syms x

% 小角度近似分析
sin_exact = sin(x);
sin_approx_1 = taylor(sin_exact, x, 0, 'Order', 2);  % θ
sin_approx_3 = taylor(sin_exact, x, 0, 'Order', 4);  % θ - θ^3/6

disp('sin(x) 的精确表达式: ')
disp(sin_exact)
disp('一阶近似 (θ): ')
disp(sin_approx_1)
disp('三阶近似 (θ - θ³/6): ')
disp(sin_approx_3)

% 计算不同角度下的误差
angles = [0.1, 0.2, 0.3, 0.5, 1.0];  % 弧度
disp('角度(弧度) | 精确值 | 一阶近似 | 相对误差(%)')
for angle = angles
    exact = double(subs(sin_exact, x, angle));
    approx1 = double(subs(sin_approx_1, x, angle));
    error1 = abs((exact - approx1)/exact) * 100;
    fprintf('   %.1f    | %.4f |  %.4f  |  %.2f%%\n', ...
        angle, exact, approx1, error1);
end
```

**Maxima 实现：**

```maxima
/* 小角度近似分析 */
sin_exact: sin(x);
sin_approx_1: taylor(sin_exact, x, 0, 2);  /* θ */
sin_approx_3: taylor(sin_exact, x, 0, 4);  /* θ - θ^3/6 */

print("sin(x) 的精确表达式: ", sin_exact);
print("一阶近似 (θ): ", sin_approx_1);
print("三阶近似 (θ - θ³/6): ", sin_approx_3);

/* 计算不同角度下的误差 */
angles: [0.1, 0.2, 0.3, 0.5, 1.0];  /* 弧度 */
print("角度(弧度) | 精确值 | 一阶近似 | 相对误差(%)");
for angle in angles do (
    exact: float(subst(x=angle, sin_exact)),
    approx1: float(subst(x=angle, sin_approx_1)),
    error1: abs((exact - approx1)/exact) * 100,
    printf(true, "   ~a    | ~a |  ~a  |  ~a%~%",
        angle, exact, approx1, error1)
);
```

## 总结

本章介绍了微积分在计算机代数系统中的基本应用：

1. **极限**：使用 `limit()` 函数计算各种类型的极限，包括单侧极限和无穷极限
2. **导数**：使用 `diff()` 函数计算导数，掌握链式法则、乘积法则和隐函数求导
3. **积分**：使用 `integrate()` 函数计算不定积分和定积分，理解换元积分法
4. **泰勒级数**：使用 `taylor()` 函数进行级数展开，分析收敛性

:::tip 关键要点
- Octave 和 Maxima 在符号计算方面功能相似，但语法略有不同
- 始终验证你的计算结果，可以通过图形或数值方法
- 理解数学概念比记住语法更重要
- 符号计算可以大大简化复杂的数学推导
:::

## 下一步

在下一章中，我们将学习 **线性代数**，包括：
- 矩阵运算和线性方程组求解
- 特征值和特征向量
- 矩阵分解
- 线性代数在物理学和工程中的应用

:::warning 练习建议
1. 尝试计算函数 $f(x) = \frac{\sin(x)}{x}$ 在 $x \to 0$ 时的极限
2. 计算函数 $g(x) = e^{-x^2}$ 的导数和不定积分
3. 将函数 $h(x) = \sqrt{1+x}$ 展开为泰勒级数（前4项）
4. 计算定积分 $\int_0^1 x^2 e^x dx$ 的值
:::
