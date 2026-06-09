# 第1章：符号计算基础

<div class="difficulty-indicator">
<span class="star filled">★</span>
<span class="star empty">☆</span>
<span class="star empty">☆</span>
<span class="star empty">☆</span>
<span class="star empty">☆</span>
<span class="difficulty-text">入门级</span>
</div>

## 学习目标

通过本章学习，你将能够：

1. 理解符号变量与数值变量的区别
2. 掌握表达式的基本操作（展开、因式分解、化简）
3. 学会求解各类方程（线性、多项式、方程组）
4. 使用符号函数进行计算和绘图
5. 了解符号计算在物理和工程中的应用

## 前置知识

- 基本代数知识
- 初等函数概念（多项式、三角函数、指数函数）
- 基本的编程概念（变量、函数）

## 预计学习时间

- 理论学习：30-45分钟
- 实践练习：60-90分钟
- **总计：90-135分钟**

---

## 1.1 符号变量 vs 数值变量

<div class="concept-tooltip">
<div class="tooltip-title">核心概念</div>
<div class="tooltip-content">
符号变量是数学符号的计算机表示，可以参与代数运算而不被赋值为具体数值。数值变量则存储具体的数值，参与数值计算。
</div>
</div>

### 1.1.1 数值变量

在传统编程中，变量存储具体数值：

```python
# Python示例（对比）
x = 5
y = 3
result = x + y  # 结果为 8
```

数值变量的特点：
- 存储具体数值
- 计算结果是确定的数值
- 无法进行代数操作

### 1.1.2 符号变量

符号变量代表数学符号，可以参与代数运算：

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 定义符号变量
x = sym('x');
y = sym('y');

% 符号表达式
expr = x^2 + 2*x + 1;

% 代入具体值
result = subs(expr, x, 3);
% 结果为 16
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 定义符号变量 */
x: x;
y: y;

/* 符号表达式 */
expr: x^2 + 2*x + 1;

/* 代入具体值 */
result: subst(x=3, expr);
/* 结果为 16 */
```

</div>
</div>
</div>

### 1.1.3 符号变量的优势

符号变量允许我们：

1. **保持代数形式**：$x^2 + 2x + 1$ 保持不变，不会被计算为数值
2. **进行符号运算**：如因式分解、展开、化简
3. **求解方程**：获得解析解而非数值近似
4. **进行微积分**：求导、积分等操作

**示例**：比较符号计算与数值计算

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
pkg load symbolic;

% 符号计算
x = sym('x');
expr = (x + 1)^2;
expanded = expand(expr);
% 结果: x^2 + 2*x + 1

% 数值计算
x_val = 3;
numerical = (x_val + 1)^2;
% 结果: 16
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 符号计算 */
expr: (x + 1)^2;
expanded: expand(expr);
/* 结果: x^2 + 2*x + 1 */

/* 数值计算 */
x_val: 3;
numerical: (x_val + 1)^2;
/* 结果: 16 */
```

</div>
</div>
</div>

---

## 1.2 表达式树与数据结构

<div class="concept-tooltip">
<div class="tooltip-title">表达式树</div>
<div class="tooltip-content">
表达式树是符号表达式的树形表示，其中内部节点是运算符，叶子节点是操作数（变量或常量）。这种结构使得代数操作变得直观和高效。
</div>
</div>

### 1.2.1 表达式的树形表示

数学表达式 $x^2 + 2x + 1$ 可以表示为：

```
        +
       / \
      *   1
     / \
    ^   2
   / \
  x   2
```

### 1.2.2 表达式的组成部分

1. **操作数**：变量（如 $x, y$）和常量（如 $1, 2, \pi$）
2. **运算符**：算术运算（$+, -, \times, \div$）、函数（$\sin, \cos, \exp$）
3. **结构**：表达式的层次关系

### 1.2.3 符号表达式的内部表示

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 创建复杂表达式
x = sym('x');
expr = sin(x)^2 + cos(x)^2;

% 查看表达式结构
disp(expr);

% 获取表达式中的变量
symvar(expr)
% 结果: [x]
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 创建复杂表达式 */
expr: sin(x)^2 + cos(x)^2;

/* 查看表达式结构 */
disp(expr);

/* 获取表达式中的变量 */
listofvars(expr);
/* 结果: [x] */
```

</div>
</div>
</div>

---

## 1.3 基本代数运算

<div class="concept-tooltip">
<div class="tooltip-title">代数运算</div>
<div class="tooltip-content">
符号计算系统提供了一系列代数操作，包括展开（expand）、因式分解（factor）、化简（simplify）等，这些操作基于表达式的树形结构进行。
</div>
</div>

### 1.3.1 表达式展开 (Expand)

展开将乘积形式转换为和的形式：

$$
(a + b)^2 = a^2 + 2ab + b^2
$$

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 展开多项式
x = sym('x');
expr = (x + 1)^3;
expanded = expand(expr);
% 结果: x^3 + 3*x^2 + 3*x + 1

% 展开三角函数
trig_expr = sin(x + y);
trig_expanded = expand(trig_expr);
% 结果: cos(x)*sin(y) + cos(y)*sin(x)
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 展开多项式 */
expr: (x + 1)^3;
expanded: expand(expr);
/* 结果: x^3 + 3*x^2 + 3*x + 1 */

/* 展开三角函数 */
trig_expr: sin(x + y);
trig_expanded: expand(trig_expr);
/* 结果: cos(y)*sin(x) + cos(x)*sin(y) */
```

</div>
</div>
</div>

### 1.3.2 因式分解 (Factor)

因式分解是展开的逆操作：

$$
x^2 - 5x + 6 = (x - 2)(x - 3)
$$

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 因式分解多项式
poly = x^3 - 8;
factored = factor(poly);
% 结果: (x - 2)*(x^2 + 2*x + 4)

% 因式分解二次多项式
quad = x^2 - 5*x + 6;
quad_factored = factor(quad);
% 结果: (x - 3)*(x - 2)
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 因式分解多项式 */
poly: x^3 - 8;
factored: factor(poly);
/* 结果: (x - 2)*(x^2 + 2*x + 4) */

/* 因式分解二次多项式 */
quad: x^2 - 5*x + 6;
quad_factored: factor(quad);
/* 结果: (x - 3)*(x - 2) */
```

</div>
</div>
</div>

### 1.3.3 表达式化简 (Simplify)

化简将表达式转换为更简单的形式：

$$
\sin^2(x) + \cos^2(x) = 1
$$

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 化简三角恒等式
trig_id = sin(x)^2 + cos(x)^2;
simplified = simplify(trig_id);
% 结果: 1

% 化简有理函数
rational = (x^2 - 1)/(x - 1);
rational_simplified = simplify(rational);
% 结果: x + 1
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 化简三角恒等式 */
trig_id: sin(x)^2 + cos(x)^2;
simplified: trigsimp(trig_id);
/* 结果: 1 */

/* 化简有理函数 */
rational: (x^2 - 1)/(x - 1);
rational_simplified: ratsimp(rational);
/* 结果: x + 1 */
```

</div>
</div>
</div>

### 1.3.4 代入运算 (Substitute)

代入运算将变量替换为具体值或其他表达式：

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 简单代入
expr = x^2 + 2*x + 1;
result = subs(expr, x, 3);
% 结果: 16

% 多变量代入
expr2 = x*y + x^2;
result2 = subs(expr2, {x, y}, {2, 3});
% 结果: 10

% 符号代入
result3 = subs(expr, x, y + 1);
% 结果: (y + 1)^2 + 2*(y + 1) + 1
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 简单代入 */
expr: x^2 + 2*x + 1;
result: subst(x=3, expr);
/* 结果: 16 */

/* 多变量代入 */
expr2: x*y + x^2;
result2: subst([x=2, y=3], expr2);
/* 结果: 10 */

/* 符号代入 */
result3: subst(x=y+1, expr);
/* 结果: (y+1)^2 + 2*(y+1) + 1 */
```

</div>
</div>
</div>

---

## 1.4 方程求解

<div class="concept-tooltip">
<div class="tooltip-title">方程求解</div>
<div class="tooltip-content">
符号计算系统可以求解各类方程，包括线性方程、多项式方程、非线性方程和方程组。求解结果是解析解（精确解），而非数值近似。
</div>
</div>

### 1.4.1 线性方程求解

一元一次方程 $ax + b = 0$ 的解为：

$$
x = -\frac{b}{a}
$$

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 一元一次方程
eq1 = 2*x + 3 == 7;
sol1 = solve(eq1, x);
% 结果: x = 2

% 含参数的线性方程
syms a b;
eq2 = a*x + b == 0;
sol2 = solve(eq2, x);
% 结果: x = -b/a
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 一元一次方程 */
eq1: 2*x + 3 = 7;
sol1: solve(eq1, x);
/* 结果: x = 2 */

/* 含参数的线性方程 */
eq2: a*x + b = 0;
sol2: solve(eq2, x);
/* 结果: x = -b/a */
```

</div>
</div>
</div>

### 1.4.2 二次方程求解

一元二次方程 $ax^2 + bx + c = 0$ 的求根公式：

$$
x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$

其中 $\Delta = b^2 - 4ac$ 称为判别式：
- $\Delta > 0$：两个不相等的实根
- $\Delta = 0$：两个相等的实根
- $\Delta < 0$：一对共轭复根

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 二次方程
eq = x^2 - 5*x + 6 == 0;
sol = solve(eq, x);
% 结果: x = 3, x = 2

% 有复数解的例子
eq_complex = x^2 + 1 == 0;
sol_complex = solve(eq_complex, x);
% 结果: x = i, x = -i
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 二次方程 */
eq: x^2 - 5*x + 6 = 0;
sol: solve(eq, x);
/* 结果: x = 3, x = 2 */

/* 有复数解的例子 */
eq_complex: x^2 + 1 = 0;
sol_complex: solve(eq_complex, x);
/* 结果: x = i, x = -i */
```

</div>
</div>
</div>

### 1.4.3 高次多项式方程

对于三次及以上多项式方程，符号计算系统可以给出精确的解析解：

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 三次方程
eq_cubic = x^3 - 6*x^2 + 11*x - 6 == 0;
sol_cubic = solve(eq_cubic, x);
% 结果: x = 1, x = 2, x = 3

% 四次方程
eq_quartic = x^4 - 16 == 0;
sol_quartic = solve(eq_quartic, x);
% 结果: x = 2, x = -2, x = 2i, x = -2i
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 三次方程 */
eq_cubic: x^3 - 6*x^2 + 11*x - 6 = 0;
sol_cubic: solve(eq_cubic, x);
/* 结果: x = 1, x = 2, x = 3 */

/* 四次方程 */
eq_quartic: x^4 - 16 = 0;
sol_quartic: solve(eq_quartic, x);
/* 结果: x = 2, x = -2, x = 2i, x = -2i */
```

</div>
</div>
</div>

### 1.4.4 方程组求解

符号计算系统可以求解线性和非线性方程组：

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 二元一次方程组
eq1 = 2*x + y == 5;
eq2 = x - y == 1;
[sol_x, sol_y] = solve([eq1, eq2], [x, y]);
% 结果: x = 2, y = 1

% 非线性方程组（圆与直线交点）
circle_eq = x^2 + y^2 == 25;
line_eq = x + y == 7;
[sol_x, sol_y] = solve([circle_eq, line_eq], [x, y]);
% 结果: (4, 3) 和 (3, 4)
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 二元一次方程组 */
eq1: 2*x + y = 5;
eq2: x - y = 1;
sol: solve([eq1, eq2], [x, y]);
/* 结果: x = 2, y = 1 */

/* 非线性方程组（圆与直线交点） */
circle_eq: x^2 + y^2 = 25;
line_eq: x + y = 7;
sol_inter: solve([circle_eq, line_eq], [x, y]);
/* 结果: (4, 3) 和 (3, 4) */
```

</div>
</div>
</div>

---

## 1.5 函数定义与绘图

<div class="concept-tooltip">
<div class="tooltip-title">符号函数</div>
<div class="tooltip-content">
符号函数是以符号变量为参数的函数定义，可以进行符号运算（如求导、积分）和绘图。符号函数保持函数的代数形式，便于分析和操作。
</div>
</div>

### 1.5.1 符号函数定义

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 定义符号函数
f(x) = x^3 - 2*x + 1;
g(x, y) = x^2 + y^2;

% 计算函数值
f_val = f(2);  % 结果: 5
g_val = g(3, 4);  % 结果: 25

% 显示函数
disp(f);
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 定义符号函数 */
f(x) := x^3 - 2*x + 1;
g(x, y) := x^2 + y^2;

/* 计算函数值 */
f_val: f(2);  /* 结果: 5 */
g_val: g(3, 4);  /* 结果: 25 */

/* 显示函数 */
disp(f(x));
```

</div>
</div>
</div>

### 1.5.2 函数绘图

符号计算系统可以绘制各类函数图像：

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 基本函数绘图
f(x) = x^2;
figure;
fplot(f, [-3, 3]);
title('二次函数 f(x) = x²');
xlabel('x');
ylabel('f(x)');
grid on;

% 参数方程绘图
t = linspace(0, 2*pi, 100);
x = cos(t);
y = sin(t);
figure;
plot(x, y);
title('单位圆');
axis equal;
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 基本函数绘图 */
plot2d(x^2, [x, -3, 3], 
    [title, "二次函数 f(x) = x²"],
    [xlabel, "x"], [ylabel, "f(x)"],
    [grid, true])$

/* 参数方程绘图 */
plot2d([parametric, cos(t), sin(t), [t, 0, 2*%pi]],
    [title, "单位圆"],
    [xlabel, "x"], [ylabel, "y"],
    [grid, true], [equal, true])$
```

</div>
</div>
</div>

### 1.5.3 三维曲面绘图

绘制三维曲面：

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 创建网格
[x, y] = meshgrid(linspace(-2, 2, 50));

% 马鞍面
z = x.^2 - y.^2;

% 绘制三维曲面
figure;
surf(x, y, z);
title('马鞍面: z = x² - y²');
xlabel('x');
ylabel('y');
zlabel('z');
shading interp;
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 马鞍面 */
plot3d(x^2 - y^2, [x, -2, 2], [y, -2, 2],
    [title, "马鞍面: z = x² - y²"],
    [xlabel, "x"], [ylabel, "y"], 
    [zlabel, "z"])$
```

</div>
</div>
</div>

---

## 1.6 实际应用示例

### 1.6.1 物理学应用：自由落体运动

自由落体运动方程：

$$
h(t) = h_0 + v_0 t - \frac{1}{2}gt^2
$$

其中：
- $h_0$：初始高度
- $v_0$：初速度
- $g$：重力加速度（约 $9.8 \, \text{m/s}^2$）
- $t$：时间

**问题**：一个物体从 100 米高处自由落下，求落地时间。

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 定义符号变量
syms t g h0 v0;

% 定义运动方程
h = h0 + v0*t - (1/2)*g*t^2;

% 代入具体数值
h_specific = subs(h, {h0, v0, g}, {100, 0, 9.8});

% 求解落地时间 (h = 0)
t_land = solve(h_specific == 0, t);

% 取正根
t_land_positive = t_land(t_land > 0);
fprintf('落地时间: %.2f 秒\n', double(t_land_positive));
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* 定义运动方程 */
h: h0 + v0*t - (1/2)*g*t^2;

/* 代入具体数值 */
h_specific: subst([h0=100, v0=0, g=9.8], h);

/* 求解落地时间 (h = 0) */
t_land: solve(h_specific = 0, t);

/* 取正根 */
t_land_positive: rhs(t_land[2]);
printf(true, "落地时间: ~a 秒~%", float(t_land_positive));
```

</div>
</div>
</div>

### 1.6.2 工程应用：RLC电路分析

RLC串联电路的阻抗：

$$
Z = R + j\omega L + \frac{1}{j\omega C}
$$

其中：
- $R$：电阻
- $L$：电感
- $C$：电容
- $\omega$：角频率
- $j$：虚数单位

<div class="code-comparison">
<div class="code-block">
<div class="code-block-header">Octave</div>
<div class="code-block-content">

```matlab
% 定义符号变量
syms R L C omega;

% RLC串联电路阻抗
Z_R = R;
Z_L = 1i*omega*L;
Z_C = 1/(1i*omega*C);
Z_total = Z_R + Z_L + Z_C;

% 化简阻抗表达式
Z_simplified = simplify(Z_total);
fprintf('总阻抗: %s\n', char(Z_simplified));

% 计算阻抗模
Z_abs = simplify(abs(Z_simplified));
fprintf('阻抗模: %s\n', char(Z_abs));
```

</div>
</div>
<div class="code-block">
<div class="code-block-header">Maxima</div>
<div class="code-block-content">

```maxima
/* RLC串联电路阻抗 */
Z_R: R;
Z_L: %i*omega*L;
Z_C: 1/(%i*omega*C);
Z_total: Z_R + Z_L + Z_C;

/* 化简阻抗表达式 */
Z_simplified: ratsimp(Z_total);
printf(true, "总阻抗: ~a~%", Z_simplified);

/* 计算阻抗模 */
Z_abs: ratsimp(abs(Z_simplified));
printf(true, "阻抗模: ~a~%", Z_abs);
```

</div>
</div>
</div>

---

## 1.7 练习与思考

### 练习 1：符号变量操作

1. 定义符号变量 $a, b, c$
2. 创建表达式 $E = a^2 + 2ab + b^2$
3. 对 $E$ 进行因式分解
4. 代入 $a = 2, b = 3$ 计算结果

### 练习 2：方程求解

1. 求解方程 $x^3 - 6x^2 + 11x - 6 = 0$
2. 求解方程组：
   $$
   \begin{cases}
   2x + 3y = 7 \\
   x - y = 1
   \end{cases}
   $$

### 练习 3：函数绘图

1. 绘制函数 $f(x) = \sin(x) \cdot e^{-x/5}$ 在 $[0, 4\pi]$ 的图像
2. 绘制参数方程：
   $$
   \begin{cases}
   x = \cos(t) + \cos(2t) \\
   y = \sin(t) + \sin(2t)
   \end{cases}
   $$

### 思考题

1. 符号变量与数值变量的主要区别是什么？
2. 为什么符号计算在科学和工程中很重要？
3. 表达式树如何帮助理解代数操作？

---

## 1.8 常见问题与解答

### Q1：符号计算与数值计算的区别？

**A**：符号计算处理数学表达式的代数形式，给出精确的解析解；数值计算处理具体数值，给出近似数值解。

### Q2：什么时候应该使用符号计算？

**A**：当需要精确解、进行代数操作、求导积分、或分析表达式结构时，应使用符号计算。

### Q3：符号计算有什么局限性？

**A**：符号计算可能较慢，某些复杂方程可能没有解析解，且结果可能过于复杂难以理解。

---

## 1.9 下一步学习

完成本章后，建议继续学习：

- [第2章：微积分基础](../02-calculus/) - 学习极限、导数和积分
- [第3章：线性代数](../03-linear-algebra/) - 学习矩阵运算和线性方程组
- [第4章：微分方程](../04-differential-equations/) - 学习常微分方程求解

---

## 附录：代码示例文件

本章的完整代码示例可以在以下位置找到：

- **Octave 示例**：`examples/01-symbolic-basics/octave/`
  - `variables.m` - 符号变量定义
  - `operations.m` - 基本代数运算
  - `equations.m` - 方程求解
  - `plotting.m` - 函数绘图

- **Maxima 示例**：`examples/01-symbolic-basics/maxima/`
  - `variables.mac` - 符号变量定义
  - `operations.mac` - 基本代数运算
  - `equations.mac` - 方程求解
  - `plotting.mac` - 函数绘图

---

<div class="concept-tooltip">
<div class="tooltip-title">学习建议</div>
<div class="tooltip-content">
1. 动手实践：运行所有代码示例
2. 修改参数：尝试改变示例中的参数值
3. 解决问题：完成所有练习题
4. 探索应用：尝试将符号计算应用到自己的研究或学习中
</div>
</div>
