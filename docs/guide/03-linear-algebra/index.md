# 第3章：线性代数

<div class="difficulty-indicator">
  <span class="star">★</span>
  <span class="star">★</span>
  <span class="star">★</span>
  <span class="star empty">★</span>
  <span class="star empty">★</span>
  <span style="margin-left: 0.5rem; color: var(--vp-c-text-2);">中等难度</span>
</div>

## 学习目标

完成本章学习后，您将能够：

1. 使用符号计算创建和操作矩阵
2. 求解线性方程组的精确符号解
3. 计算矩阵的特征值和特征向量
4. 理解并应用矩阵分解方法（LU、QR、SVD）

**预计学习时间**：3-4小时

**前置知识**：
- 符号计算基础（第1章）
- 基本的线性代数概念

---

## 1. 矩阵定义与基本运算

### 1.1 什么是符号矩阵？

<span class="concept-tooltip">
  符号矩阵
  <span class="tooltip-content">
    符号矩阵是元素为符号表达式（而非数值）的矩阵。这使得我们可以进行精确的代数运算，避免浮点误差。
  </span>
</span>

在线性代数中，矩阵是一个按照长方阵列排列的数表。在CAS中，我们可以创建**符号矩阵**，其元素可以是符号变量、表达式或精确数值。

一个 $m \times n$ 矩阵 $\mathbf{A}$ 可以表示为：

$$
\mathbf{A} = \begin{pmatrix}
a_{11} & a_{12} & \cdots & a_{1n} \\
a_{21} & a_{22} & \cdots & a_{2n} \\
\vdots & \vdots & \ddots & \vdots \\
a_{m1} & a_{m2} & \cdots & a_{mn}
\end{pmatrix}
$$

### 1.2 矩阵的创建

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
% 创建数值矩阵
A = [1, 2, 3; 4, 5, 6; 7, 8, 9];

% 创建符号矩阵
pkg load symbolic
syms a b c d
S = [a, b; c, d];

% 创建特殊矩阵
Z = zeros(3, 3);      % 零矩阵
I = eye(3);           % 单位矩阵
D = diag([1, 2, 3]);  % 对角矩阵
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 创建数值矩阵 */
A: matrix([1, 2, 3], [4, 5, 6], [7, 8, 9]);

/* 创建符号矩阵 */
S: matrix([a, b], [c, d]);

/* 创建特殊矩阵 */
Z: zeromatrix(3, 3);           /* 零矩阵 */
I: ident(3);                   /* 单位矩阵 */
D: diagmatrix([1, 2, 3]);      /* 对角矩阵 */
```

  </div>
  </div>
</div>

### 1.3 矩阵的基本运算

矩阵的基本运算包括加法、数乘、矩阵乘法、转置等。

#### 矩阵加法与数乘

对于两个同型矩阵 $\mathbf{A}$ 和 $\mathbf{B}$，矩阵加法定义为：

$$
(\mathbf{A} + \mathbf{B})_{ij} = a_{ij} + b_{ij}
$$

数乘运算定义为：

$$
(k\mathbf{A})_{ij} = k \cdot a_{ij}
$$

#### 矩阵乘法

对于矩阵 $\mathbf{A}_{m \times n}$ 和 $\mathbf{B}_{n \times p}$，矩阵乘法 $\mathbf{C} = \mathbf{A}\mathbf{B}$ 定义为：

$$
c_{ij} = \sum_{k=1}^{n} a_{ik} b_{kj}
$$

::: warning 注意
矩阵乘法不满足交换律，即 $\mathbf{A}\mathbf{B} \neq \mathbf{B}\mathbf{A}$（一般情况下）
:::

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic
syms a b c d e f

% 定义矩阵
A = [a, b; c, d];
B = [e, f; 1, 2];

% 矩阵加法
C_add = A + B;

% 数乘
C_scalar = 3 * A;

% 矩阵乘法
C_mult = A * B;

% 转置
A_trans = A';

disp('矩阵乘法结果:');
disp(C_mult);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 定义矩阵 */
A: matrix([a, b], [c, d]);
B: matrix([e, f], [1, 2]);

/* 矩阵加法 */
C_add: A + B;

/* 数乘 */
C_scalar: 3 * A;

/* 矩阵乘法 */
C_mult: A . B;

/* 转置 */
A_trans: transpose(A);

display(C_mult);
```

  </div>
  </div>
</div>

### 1.4 行列式

<span class="concept-tooltip">
  行列式
  <span class="tooltip-content">
    行列式是一个标量值，可以从方阵中计算得到。它提供了矩阵的重要信息，如矩阵是否可逆（行列式不为零）。几何上，行列式表示线性变换对面积或体积的缩放因子。
  </span>
</span>

对于 $n \times n$ 方阵 $\mathbf{A}$，其行列式 $\det(\mathbf{A})$ 是一个标量。对于 $2 \times 2$ 矩阵：

$$
\det(\mathbf{A}) = \begin{vmatrix} a & b \\ c & d \end{vmatrix} = ad - bc
$$

对于 $3 \times 3$ 矩阵，使用**展开定理**（拉普拉斯展开）：

$$
\det(\mathbf{A}) = a_{11}M_{11} - a_{12}M_{12} + a_{13}M_{13}
$$

其中 $M_{ij}$ 是元素 $a_{ij}$ 的**余子式**。

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic
syms a b c d e f g h i

% 2x2 矩阵的行列式
A2 = [a, b; c, d];
det_A2 = det(A2);
disp('2x2 行列式:');
disp(det_A2);

% 3x3 矩阵的行列式
A3 = [a, b, c; d, e, f; g, h, i];
det_A3 = det(A3);
disp('3x3 行列式:');
disp(det_A3);

% 数值示例
M = [1, 2, 3; 0, 1, 4; 5, 6, 0];
det_M = det(M);
fprintf('数值行列式: %d\n', det_M);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 2x2 矩阵的行列式 */
A2: matrix([a, b], [c, d]);
det_A2: determinant(A2);
display(det_A2);

/* 3x3 矩阵的行列式 */
A3: matrix([a, b, c], [d, e, f], [g, h, i]);
det_A3: determinant(A3);
display(det_A3);

/* 数值示例 */
M: matrix([1, 2, 3], [0, 1, 4], [5, 6, 0]);
det_M: determinant(M);
display(det_M);
```

  </div>
  </div>
</div>

### 1.5 逆矩阵

如果方阵 $\mathbf{A}$ 的行列式不为零，则 $\mathbf{A}$ 是**可逆的**，其逆矩阵 $\mathbf{A}^{-1}$ 满足：

$$
\mathbf{A}\mathbf{A}^{-1} = \mathbf{A}^{-1}\mathbf{A} = \mathbf{I}
$$

逆矩阵的计算公式（对于 $2 \times 2$ 矩阵）：

$$
\mathbf{A}^{-1} = \frac{1}{ad - bc} \begin{pmatrix} d & -b \\ -c & a \end{pmatrix}
$$

::: tip 应用
逆矩阵在求解线性方程组 $\mathbf{A}\mathbf{x} = \mathbf{b}$ 时非常有用：$\mathbf{x} = \mathbf{A}^{-1}\mathbf{b}$
:::

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic
syms a b c d

% 符号矩阵求逆
A = [a, b; c, d];
A_inv = inv(A);
disp('符号逆矩阵:');
disp(A_inv);

% 验证 A * A^{-1} = I
check = simplify(A * A_inv);
disp('验证 A * A^{-1}:');
disp(check);

% 数值示例
M = [1, 2; 3, 4];
M_inv = inv(M);
fprintf('行列式: %f\n', det(M));
disp('数值逆矩阵:');
disp(M_inv);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 符号矩阵求逆 */
A: matrix([a, b], [c, d]);
A_inv: invert(A);
display(A_inv);

/* 验证 A * A^{-1} = I */
check: ratsimp(A . A_inv);
display(check);

/* 数值示例 */
M: matrix([1, 2], [3, 4]);
M_inv: invert(M);
display(determinant(M));
display(M_inv);
```

  </div>
  </div>
</div>

### 1.6 物理应用：惯性张量

在刚体力学中，**惯性张量**是一个 $3 \times 3$ 的对称矩阵，描述物体绕不同轴旋转的惯性：

$$
\mathbf{I} = \begin{pmatrix}
I_{xx} & -I_{xy} & -I_{xz} \\
-I_{xy} & I_{yy} & -I_{yz} \\
-I_{xz} & -I_{yz} & I_{zz}
\end{pmatrix}
$$

其中对角元素是**转动惯量**，非对角元素是**惯性积**。

---

## 2. 线性方程组求解

### 2.1 线性方程组的表示

一个 $m$ 个方程、$n$ 个未知数的线性方程组可以表示为：

$$
\begin{cases}
a_{11}x_1 + a_{12}x_2 + \cdots + a_{1n}x_n = b_1 \\
a_{21}x_1 + a_{22}x_2 + \cdots + a_{2n}x_n = b_2 \\
\vdots \\
a_{m1}x_1 + a_{m2}x_2 + \cdots + a_{mn}x_n = b_m
\end{cases}
$$

用矩阵形式表示为 $\mathbf{A}\mathbf{x} = \mathbf{b}$，其中：
- $\mathbf{A}$ 是 $m \times n$ 系数矩阵
- $\mathbf{x}$ 是 $n \times 1$ 未知数向量
- $\mathbf{b}$ 是 $m \times 1$ 常数向量

### 2.2 高斯消元法

<span class="concept-tooltip">
  高斯消元法
  <span class="tooltip-content">
    高斯消元法是一种通过初等行变换将矩阵化为行阶梯形矩阵的算法。它是求解线性方程组最基本的方法之一，时间复杂度为 O(n³)。
  </span>
</span>

高斯消元法的基本步骤：

1. **前向消元**：将增广矩阵 $[\mathbf{A}|\mathbf{b}]$ 化为上三角矩阵
2. **回代**：从最后一个方程开始，逐个求解未知数

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic

% 定义线性方程组
% 2x + 3y = 8
% 4x + 5y = 14
A = [2, 3; 4, 5];
b = [8; 14];

% 方法1: 直接求解
x = A \ b;
disp('直接求解结果:');
disp(x);

% 方法2: 符号求解
syms x1 x2
eqns = [2*x1 + 3*x2 == 8, 4*x1 + 5*x2 == 14];
sol = solve(eqns, [x1, x2]);
fprintf('符号解: x1 = %s, x2 = %s\n', char(sol.x1), char(sol.x2));

% 方法3: 使用逆矩阵
x_inv = inv(A) * b;
disp('逆矩阵法结果:');
disp(x_inv);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 定义线性方程组 */
A: matrix([2, 3], [4, 5]);
b: matrix([8], [14]);

/* 方法1: 使用逆矩阵 */
x_inv: invert(A) . b;
display(x_inv);

/* 方法2: 符号求解 */
solve([2*x + 3*y = 8, 4*x + 5*y = 14], [x, y]);

/* 方法3: 增广矩阵和行化简 */
aug: addcol(A, b);
echelon(aug);
```

  </div>
  </div>
</div>

### 2.3 克拉默法则

<span class="concept-tooltip">
  克拉默法则
  <span class="tooltip-content">
    克拉默法则使用行列式来求解线性方程组。对于 n 个方程 n 个未知数的系统，每个未知数可以通过两个行列式的比值来计算。虽然理论上很优雅，但对于大系统效率较低。
  </span>
</span>

对于 $n$ 个方程 $n$ 个未知数的系统 $\mathbf{A}\mathbf{x} = \mathbf{b}$，如果 $\det(\mathbf{A}) \neq 0$，则：

$$
x_i = \frac{\det(\mathbf{A}_i)}{\det(\mathbf{A})}
$$

其中 $\mathbf{A}_i$ 是将 $\mathbf{A}$ 的第 $i$ 列替换为 $\mathbf{b}$ 后得到的矩阵。

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic

% 系数矩阵和常数向量
A = [2, 3; 4, 5];
b = [8; 14];

% 计算主行列式
det_A = det(A);

% 克拉默法则求解 x1
A1 = A;
A1(:, 1) = b;
x1 = det(A1) / det_A;

% 克拉默法则求解 x2
A2 = A;
A2(:, 2) = b;
x2 = det(A2) / det_A;

fprintf('克拉默法则结果: x1 = %f, x2 = %f\n', x1, x2);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 系数矩阵和常数向量 */
A: matrix([2, 3], [4, 5]);
b: matrix([8], [14]);

/* 计算主行列式 */
det_A: determinant(A);

/* 克拉默法则求解 x1 */
A1: A;
A1[1][1]: b[1][1];
A1[2][1]: b[2][1];
x1: determinant(A1) / det_A;

/* 克拉默法则求解 x2 */
A2: A;
A2[1][2]: b[1][1];
A2[2][2]: b[2][1];
x2: determinant(A2) / det_A;

display(x1, x2);
```

  </div>
  </div>
</div>

### 2.4 齐次线性方程组

齐次线性方程组 $\mathbf{A}\mathbf{x} = \mathbf{0}$ 总是有**平凡解** $\mathbf{x} = \mathbf{0}$。

非平凡解存在的条件是 $\det(\mathbf{A}) = 0$，此时解空间的维数为 $n - \text{rank}(\mathbf{A})$。

::: tip 物理意义
在振动分析中，齐次方程组的非平凡解对应于系统的**固有模态**（normal modes）。
:::

### 2.5 工程应用：电路分析

在电路分析中，基尔霍夫定律可以导出线性方程组。例如，对于一个包含多个回路的电路：

$$
\begin{pmatrix}
R_1 + R_2 & -R_2 & 0 \\
-R_2 & R_2 + R_3 & -R_3 \\
0 & -R_3 & R_3 + R_4
\end{pmatrix}
\begin{pmatrix}
I_1 \\ I_2 \\ I_3
\end{pmatrix}
=
\begin{pmatrix}
V_1 \\ 0 \\ -V_2
\end{pmatrix}
$$

---

## 3. 特征值与特征向量

### 3.1 基本概念

<span class="concept-tooltip">
  特征值与特征向量
  <span class="tooltip-content">
    对于方阵 A，如果存在标量 λ 和非零向量 v，使得 Av = λv，则 λ 称为 A 的特征值，v 称为对应的特征向量。特征值问题在振动分析、稳定性分析等领域有重要应用。
  </span>
</span>

对于 $n \times n$ 方阵 $\mathbf{A}$，如果存在标量 $\lambda$ 和非零向量 $\mathbf{v}$，使得：

$$
\mathbf{A}\mathbf{v} = \lambda\mathbf{v}
$$

则 $\lambda$ 称为 $\mathbf{A}$ 的**特征值**，$\mathbf{v}$ 称为对应的**特征向量**。

### 3.2 特征多项式

特征值是**特征多项式**的根：

$$
p(\lambda) = \det(\mathbf{A} - \lambda\mathbf{I}) = 0
$$

对于 $2 \times 2$ 矩阵：

$$
\lambda^2 - \text{tr}(\mathbf{A})\lambda + \det(\mathbf{A}) = 0
$$

其中 $\text{tr}(\mathbf{A}) = a_{11} + a_{22}$ 是矩阵的**迹**。

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic
syms lambda

% 定义矩阵
A = [4, -2; 1, 1];

% 计算特征多项式
char_poly = det(A - lambda * eye(2));
disp('特征多项式:');
disp(char_poly);

% 求解特征值
eigenvals = solve(char_poly == 0, lambda);
disp('特征值:');
disp(eigenvals);

% 使用内置函数
[V, D] = eig(A);
disp('特征向量矩阵:');
disp(V);
disp('特征值对角矩阵:');
disp(D);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 定义矩阵 */
A: matrix([4, -2], [1, 1]);

/* 计算特征多项式 */
char_poly: charpoly(A, lambda);
display(char_poly);

/* 求解特征值 */
eigenvals: solve(char_poly = 0, lambda);
display(eigenvals);

/* 计算特征向量 */
eigenvectors(A);
```

  </div>
  </div>
</div>

### 3.3 对角化

如果矩阵 $\mathbf{A}$ 有 $n$ 个线性无关的特征向量，则 $\mathbf{A}$ 可以**对角化**：

$$
\mathbf{A} = \mathbf{P}\mathbf{D}\mathbf{P}^{-1}
$$

其中：
- $\mathbf{D}$ 是特征值组成的对角矩阵
- $\mathbf{P}$ 是特征向量组成的矩阵

对角化的重要应用是计算矩阵的**幂**：

$$
\mathbf{A}^n = \mathbf{P}\mathbf{D}^n\mathbf{P}^{-1}
$$

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic

% 定义可对角化矩阵
A = [4, -2; 1, 1];

% 计算特征分解
[P, D] = eig(A);

% 验证 A = P * D * P^(-1)
A_reconstructed = P * D * inv(P);
A_reconstructed = simplify(A_reconstructed);
disp('重构矩阵:');
disp(A_reconstructed);

% 计算 A^10
A_10 = P * D^10 * inv(P);
A_10 = simplify(A_10);
disp('A^10:');
disp(A_10);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 定义可对角化矩阵 */
A: matrix([4, -2], [1, 1]);

/* 计算特征值和特征向量 */
result: eigenvectors(A);
eigenvalues: result[1][1];
eigenvectors_list: result[2];

/* 构建对角矩阵 D */
D: diagmatrix(eigenvalues);

/* 构建特征向量矩阵 P */
P: transpose(matrix(eigenvectors_list[1], eigenvectors_list[2]));

/* 验证 A = P * D * P^(-1) */
A_reconstructed: ratsimp(P . D . invert(P));
display(A_reconstructed);
```

  </div>
  </div>
</div>

### 3.4 Jordan 标准形

当矩阵不能对角化时，可以化为 **Jordan 标准形**：

$$
\mathbf{A} = \mathbf{P}\mathbf{J}\mathbf{P}^{-1}
$$

其中 $\mathbf{J}$ 是 Jordan 块组成的矩阵。

::: warning 注意
Jordan 标准形的计算在符号情况下可能很复杂，通常在数值计算中更实用。
:::

### 3.5 物理应用：振动系统

在多自由度振动系统中，特征值对应于系统的**固有频率**的平方，特征向量对应于**振型**。

对于弹簧-质量系统：

$$
\mathbf{M}\ddot{\mathbf{x}} + \mathbf{K}\mathbf{x} = \mathbf{0}
$$

假设解为 $\mathbf{x} = \mathbf{v}e^{i\omega t}$，得到广义特征值问题：

$$
\mathbf{K}\mathbf{v} = \omega^2\mathbf{M}\mathbf{v}
$$

---

## 4. 矩阵分解

### 4.1 LU 分解

<span class="concept-tooltip">
  LU 分解
  <span class="tooltip-content">
    LU 分解将矩阵分解为一个下三角矩阵 L 和一个上三角矩阵 U 的乘积：A = LU。这种分解在求解线性方程组和计算行列式时非常高效。
  </span>
</span>

LU 分解将矩阵 $\mathbf{A}$ 分解为：

$$
\mathbf{A} = \mathbf{L}\mathbf{U}
$$

其中：
- $\mathbf{L}$ 是下三角矩阵（对角线元素为1）
- $\mathbf{U}$ 是上三角矩阵

对于需要行交换的情况，使用 **PLU 分解**：

$$
\mathbf{P}\mathbf{A} = \mathbf{L}\mathbf{U}
$$

其中 $\mathbf{P}$ 是置换矩阵。

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic

% 定义矩阵
A = [2, 1, 1; 4, 3, 3; 8, 7, 9];

% LU 分解
[L, U, P] = lu(A);

disp('下三角矩阵 L:');
disp(L);
disp('上三角矩阵 U:');
disp(U);
disp('置换矩阵 P:');
disp(P);

% 验证 A = P' * L * U
check = P' * L * U;
disp('验证 P'' * L * U = A:');
disp(check);

% 使用 LU 分解求解线性方程组
b = [1; 2; 3];
% 前向替代求解 Ly = Pb
y = L \ (P * b);
% 回代求解 Ux = y
x = U \ y;
disp('LU 分解法求解结果:');
disp(x);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 定义矩阵 */
A: matrix([2, 1, 1], [4, 3, 3], [8, 7, 9]);

/* LU 分解 */
result: lu_factor(A);
L: result[1];
U: result[2];

display(L);
display(U);

/* 验证 A = L * U */
check: ratsimp(L . U);
display(check);
```

  </div>
  </div>
</div>

### 4.2 QR 分解

<span class="concept-tooltip">
  QR 分解
  <span class="tooltip-content">
    QR 分解将矩阵分解为一个正交矩阵 Q 和一个上三角矩阵 R 的乘积：A = QR。QR 分解在最小二乘问题和特征值计算中有重要应用。
  </span>
</span>

QR 分解将矩阵 $\mathbf{A}$ 分解为：

$$
\mathbf{A} = \mathbf{Q}\mathbf{R}
$$

其中：
- $\mathbf{Q}$ 是正交矩阵（$\mathbf{Q}^T\mathbf{Q} = \mathbf{I}$）
- $\mathbf{R}$ 是上三角矩阵

QR 分解可以通过 **Gram-Schmidt 正交化** 或 **Householder 变换** 实现。

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic

% 定义矩阵
A = [1, 1, 0; 1, 0, 1; 0, 1, 1];

% QR 分解
[Q, R] = qr(A);

disp('正交矩阵 Q:');
disp(Q);
disp('上三角矩阵 R:');
disp(R);

% 验证 A = Q * R
check = Q * R;
disp('验证 Q * R = A:');
disp(check);

% 验证 Q 的正交性
disp('验证 Q^T * Q = I:');
disp(Q' * Q);

% 使用 QR 分解求解最小二乘问题
b = [1; 2; 3];
x = R \ (Q' * b);
disp('最小二乘解:');
disp(x);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* 定义矩阵 */
A: matrix([1, 1, 0], [1, 0, 1], [0, 1, 1]);

/* QR 分解 - 使用 Gram-Schmidt 过程 */
/* 提取列向量 */
a1: col(A, 1);
a2: col(A, 2);
a3: col(A, 3);

/* Gram-Schmidt 正交化 */
u1: a1;
e1: ratsimp(u1 / sqrt(u1 . transpose(u1)));

u2: ratsimp(a2 - (a2 . transpose(e1)) * e1);
e2: ratsimp(u2 / sqrt(u2 . transpose(u2)));

u3: ratsimp(a3 - (a3 . transpose(e1)) * e1 - (a3 . transpose(e2)) * e2);
e3: ratsimp(u3 / sqrt(u3 . transpose(u3)));

/* 构建 Q 和 R */
Q: addcol(e1, e2, e3);
Q: transpose(Q);
R: ratsimp(transpose(Q) . A);

display(Q);
display(R);
```

  </div>
  </div>
</div>

### 4.3 奇异值分解（SVD）

<span class="concept-tooltip">
  奇异值分解
  <span class="tooltip-content">
    SVD 将任意 m×n 矩阵分解为 A = UΣV^T，其中 U 和 V 是正交矩阵，Σ 是对角矩阵（奇异值）。SVD 在数据压缩、降维和伪逆计算中有广泛应用。
  </span>
</span>

对于任意 $m \times n$ 矩阵 $\mathbf{A}$，SVD 分解为：

$$
\mathbf{A} = \mathbf{U}\mathbf{\Sigma}\mathbf{V}^T
$$

其中：
- $\mathbf{U}$ 是 $m \times m$ 正交矩阵（左奇异向量）
- $\mathbf{\Sigma}$ 是 $m \times n$ 对角矩阵（奇异值）
- $\mathbf{V}$ 是 $n \times n$ 正交矩阵（右奇异向量）

<div class="code-comparison">
  <div class="code-block">
    <div class="code-block-header">Octave</div>
    <div class="code-block-content">

```matlab
pkg load symbolic

% 定义矩阵
A = [1, 2; 3, 4; 5, 6];

% SVD 分解
[U, S, V] = svd(A);

disp('左奇异向量 U:');
disp(U);
disp('奇异值矩阵 S:');
disp(S);
disp('右奇异向量 V:');
disp(V);

% 验证 A = U * S * V'
check = U * S * V';
disp('验证 U * S * V'' = A:');
disp(check);

% 计算伪逆
A_pinv = V * inv(S(1:2, 1:2)) * U(:, 1:2)';
disp('伪逆矩阵:');
disp(A_pinv);
```

  </div>
  </div>
  <div class="code-block">
    <div class="code-block-header">Maxima</div>
    <div class="code-block-content">

```maxima
/* SVD 在 Maxima 中需要数值计算 */
/* 使用数值矩阵示例 */
A: matrix([1.0, 2.0], [3.0, 4.0], [5.0, 6.0]);

/* 计算 A^T * A 用于右奇异向量 */
ATA: transpose(A) . A;

/* 计算特征值（奇异值的平方） */
eigenvalues: eigenvalues(ATA);
singular_values: map(sqrt, eigenvalues[1]);

display(singular_values);
```

  </div>
  </div>
</div>

### 4.4 矩阵分解的应用

| 分解方法 | 主要应用 |
|---------|---------|
| LU 分解 | 求解线性方程组、计算行列式 |
| QR 分解 | 最小二乘问题、特征值计算 |
| SVD | 数据压缩、降维、伪逆计算 |
| 特征分解 | 振动分析、稳定性分析 |

### 4.5 工程应用：主成分分析（PCA）

在数据分析中，SVD 用于**主成分分析**：

1. 对数据矩阵 $\mathbf{X}$ 进行中心化
2. 计算协方差矩阵 $\mathbf{C} = \frac{1}{n-1}\mathbf{X}^T\mathbf{X}$
3. 对 $\mathbf{C}$ 进行特征分解
4. 选择最大的 $k$ 个特征值对应的特征向量

---

## 5. 综合示例

### 5.1 物理问题：耦合振子

考虑两个耦合的弹簧振子系统：

$$
\begin{cases}
m_1\ddot{x}_1 = -k_1 x_1 + k_2(x_2 - x_1) \\
m_2\ddot{x}_2 = -k_2(x_2 - x_1) - k_3 x_2
\end{cases}
$$

写成矩阵形式 $\mathbf{M}\ddot{\mathbf{x}} + \mathbf{K}\mathbf{x} = \mathbf{0}$：

$$
\mathbf{M} = \begin{pmatrix} m_1 & 0 \\ 0 & m_2 \end{pmatrix}, \quad
\mathbf{K} = \begin{pmatrix} k_1 + k_2 & -k_2 \\ -k_2 & k_2 + k_3 \end{pmatrix}
$$

求解广义特征值问题 $\mathbf{K}\mathbf{v} = \omega^2\mathbf{M}\mathbf{v}$ 得到固有频率。

### 5.2 工程问题：结构分析

在有限元分析中，刚度矩阵 $\mathbf{K}$ 的特征值分析可以确定结构的**屈曲载荷**和**振动模态**。

---

## 6. 练习题

### 练习 1：矩阵运算
给定矩阵 $\mathbf{A} = \begin{pmatrix} 1 & 2 \\ 3 & 4 \end{pmatrix}$ 和 $\mathbf{B} = \begin{pmatrix} 5 & 6 \\ 7 & 8 \end{pmatrix}$，计算：
1. $\mathbf{A} + \mathbf{B}$
2. $\mathbf{A}\mathbf{B}$
3. $\det(\mathbf{A})$
4. $\mathbf{A}^{-1}$

### 练习 2：线性方程组
使用三种方法求解：
$$
\begin{cases}
2x + 3y = 7 \\
4x - y = 1
\end{cases}
$$

### 练习 3：特征值问题
计算矩阵 $\mathbf{A} = \begin{pmatrix} 3 & 1 \\ 0 & 2 \end{pmatrix}$ 的特征值和特征向量，并验证对角化。

### 练习 4：矩阵分解
对矩阵 $\mathbf{A} = \begin{pmatrix} 1 & 2 \\ 3 & 4 \\ 5 & 6 \end{pmatrix}$ 进行 QR 分解。

---

## 7. 总结

本章介绍了符号计算在线性代数中的应用：

| 主题 | 关键概念 | 应用 |
|-----|---------|-----|
| 矩阵运算 | 加法、乘法、行列式、逆矩阵 | 基础工具 |
| 线性方程组 | 高斯消元、克拉默法则 | 工程计算 |
| 特征值问题 | 特征多项式、对角化 | 振动分析 |
| 矩阵分解 | LU、QR、SVD | 数据分析 |

### 下一步学习

- [第4章：微分方程](/guide/04-differential-equations/) - 学习如何使用CAS求解微分方程
- [第5章：泛函分析](/guide/05-functional-analysis/) - 将线性代数扩展到无限维空间

---

## 参考资料

1. Strang, G. (2016). *Introduction to Linear Algebra*. Wellesley-Cambridge Press.
2. Golub, G. H., & Van Loan, C. F. (2013). *Matrix Computations*. Johns Hopkins University Press.
3. Trefethen, L. N., & Bau, D. (1997). *Numerical Linear Algebra*. SIAM.
