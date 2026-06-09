# 第5章：泛函分析应用

<div class="difficulty-indicator">
★★★★☆
<span class="difficulty-text">高级难度</span>
</div>

## 概述

泛函分析是数学分析的一个重要分支，它研究的是函数的函数（泛函）的极值问题。本章将介绍变分法的基础知识、欧拉-拉格朗日方程、泛函极值问题及其在力学中的应用。

::: tip 先决条件
学习本章前，建议先掌握以下内容：
- 微积分基础（特别是积分和微分）
- 常微分方程基础
- 基本的线性代数知识
- 对物理学（特别是力学）有基本了解
:::

## 1. 变分法基础

### 1.1 什么是变分法？

<div class="concept-tooltip">
<span class="tooltip-trigger">ℹ️ 变分法</span>
<span class="tooltip-content">变分法是研究泛函极值问题的数学方法。与普通函数求极值不同，变分法处理的是依赖于整个函数（而不仅仅是点）的量。</span>
</div>

变分法的核心思想是：寻找一个函数 $y(x)$，使得某个依赖于 $y(x)$ 及其导数的泛函 $J[y]$ 达到极值。

**泛函**是从函数空间到实数的一个映射。例如：

$$J[y] = \int_a^b F(x, y, y') \, dx$$

其中 $F$ 是已知函数，$y = y(x)$ 是未知函数，$y' = \frac{dy}{dx}$。

### 1.2 变分的基本概念

给定一个函数 $y(x)$，考虑其小扰动 $y(x) + \epsilon \eta(x)$，其中 $\epsilon$ 是一个小参数，$\eta(x)$ 是满足边界条件 $\eta(a) = \eta(b) = 0$ 的任意函数。

泛函 $J[y]$ 的变分定义为：

$$\delta J = \frac{d}{d\epsilon} J[y + \epsilon \eta] \Big|_{\epsilon=0}$$

如果 $\delta J = 0$，则称 $y(x)$ 使得泛函 $J$ 取得极值。

### 1.3 泛函极值的必要条件

设 $y(x)$ 在 $[a, b]$ 上连续可微，且 $y(a) = y_a$，$y(b) = y_b$ 固定。考虑泛函：

$$J[y] = \int_a^b F(x, y, y') \, dx$$

则 $y(x)$ 使 $J$ 取得极值的必要条件是 $y(x)$ 满足**欧拉-拉格朗日方程**：

$$\frac{\partial F}{\partial y} - \frac{d}{dx} \left( \frac{\partial F}{\partial y'} \right) = 0$$

---

## 2. 欧拉-拉格朗日方程

### 2.1 方程的推导

考虑泛函 $J[y] = \int_a^b F(x, y, y') \, dx$，其中 $y(a) = y_a$，$y(b) = y_b$ 固定。

对 $y(x)$ 进行变分 $y(x) \to y(x) + \epsilon \eta(x)$，其中 $\eta(a) = \eta(b) = 0$。

计算变分：

$$\begin{align*}
\delta J &= \frac{d}{d\epsilon} \int_a^b F(x, y + \epsilon \eta, y' + \epsilon \eta') \, dx \Big|_{\epsilon=0} \\
&= \int_a^b \left( \frac{\partial F}{\partial y} \eta + \frac{\partial F}{\partial y'} \eta' \right) dx
\end{align*}$$

对第二项进行分部积分：

$$\int_a^b \frac{\partial F}{\partial y'} \eta' \, dx = \left[ \frac{\partial F}{\partial y'} \eta \right]_a^b - \int_a^b \frac{d}{dx} \left( \frac{\partial F}{\partial y'} \right) \eta \, dx$$

由于 $\eta(a) = \eta(b) = 0$，边界项消失，得到：

$$\delta J = \int_a^b \left( \frac{\partial F}{\partial y} - \frac{d}{dx} \left( \frac{\partial F}{\partial y'} \right) \right) \eta \, dx$$

要使 $\delta J = 0$ 对所有 $\eta(x)$ 成立，括号内的表达式必须为零：

$$\frac{\partial F}{\partial y} - \frac{d}{dx} \left( \frac{\partial F}{\partial y'} \right) = 0$$

### 2.2 特殊形式的欧拉-拉格朗日方程

**情况1：$F$ 不显含 $x$**

如果 $F = F(y, y')$，则欧拉-拉格朗日方程可以简化为：

$$F - y' \frac{\partial F}{\partial y'} = C$$

其中 $C$ 是常数。这称为**贝尔特拉米恒等式**。

**情况2：$F$ 不显含 $y$**

如果 $F = F(x, y')$，则欧拉-拉格朗日方程简化为：

$$\frac{\partial F}{\partial y'} = C$$

**情况3：$F$ 不显含 $y'$**

如果 $F = F(x, y)$，则欧拉-拉格朗日方程简化为：

$$\frac{\partial F}{\partial y} = 0$$

### 2.3 自然边界条件

当边界值 $y(a)$ 或 $y(b)$ 未指定时，需要添加**自然边界条件**：

$$\frac{\partial F}{\partial y'} \Big|_{x=a} = 0 \quad \text{或} \quad \frac{\partial F}{\partial y'} \Big|_{x=b} = 0$$

---

## 3. 泛函极值问题

### 3.1 含参数的泛函极值

考虑含参数 $\lambda$ 的泛函：

$$J[y] = \int_a^b F(x, y, y', \lambda) \, dx$$

极值条件为：

$$\frac{\partial F}{\partial y} - \frac{d}{dx} \left( \frac{\partial F}{\partial y'} \right) = 0 \quad \text{且} \quad \frac{\partial J}{\partial \lambda} = 0$$

### 3.2 条件极值问题（等周问题）

**等周问题**：在满足约束条件

$$\int_a^b G(x, y, y') \, dx = L$$

的函数中，寻找使泛函

$$J[y] = \int_a^b F(x, y, y') \, dx$$

取极值的函数 $y(x)$。

**解法**：引入拉格朗日乘子 $\lambda$，构造新泛函：

$$\tilde{J}[y] = \int_a^b \left( F + \lambda G \right) dx$$

然后求解欧拉-拉格朗日方程：

$$\frac{\partial (F + \lambda G)}{\partial y} - \frac{d}{dx} \left( \frac{\partial (F + \lambda G)}{\partial y'} \right) = 0$$

### 3.3 泛函极值的充分条件

**二阶变分**：

$$\delta^2 J = \frac{d^2}{d\epsilon^2} J[y + \epsilon \eta] \Big|_{\epsilon=0}$$

对于泛函极值：
- 如果 $\delta^2 J > 0$，则 $J$ 取得局部极小值
- 如果 $\delta^2 J < 0$，则 $J$ 取得局部极大值

**勒让德条件**：

设 $F_{y'y''} = \frac{\partial^2 F}{\partial y'^2}$，则：
- $F_{y'y''} \geq 0$ 是极小值的必要条件
- $F_{y'y''} \leq 0$ 是极大值的必要条件

---

## 4. 力学中的应用

### 4.1 拉格朗日力学

在经典力学中，系统的运动由**拉格朗日函数** $L$ 描述：

$$L = T - V$$

其中 $T$ 是动能，$V$ 是势能。

**哈密顿原理**（最小作用量原理）：系统的实际运动路径使作用量泛函

$$S[q] = \int_{t_1}^{t_2} L(q, \dot{q}, t) \, dt$$

取极值，其中 $q$ 是广义坐标，$\dot{q} = \frac{dq}{dt}$ 是广义速度。

应用欧拉-拉格朗日方程得到运动方程：

$$\frac{\partial L}{\partial q} - \frac{d}{dt} \left( \frac{\partial L}{\partial \dot{q}} \right) = 0$$

### 4.2 哈密顿力学

定义广义动量：

$$p = \frac{\partial L}{\partial \dot{q}}$$

哈密顿量定义为：

$$H(q, p, t) = p \dot{q} - L$$

哈密顿正则方程：

$$\dot{q} = \frac{\partial H}{\partial p}, \quad \dot{p} = -\frac{\partial H}{\partial q}$$

### 4.3 应用实例

**例1：最速降线问题**

在重力场中，寻找从点 $A$ 到点 $B$ 的曲线，使得质点沿该曲线滑下的时间最短。

设曲线为 $y(x)$，从 $(0,0)$ 到 $(1,h)$。质点的速度由能量守恒给出：

$$v = \sqrt{2gy}$$

滑下时间泛函为：

$$T[y] = \int_0^1 \frac{\sqrt{1 + y'^2}}{\sqrt{2gy}} \, dx$$

应用欧拉-拉格朗日方程可解得摆线方程。

**例2：悬链线问题**

在重力场中，寻找两端固定、长度固定的柔软链条在平衡状态下的形状。

设链条密度为 $\rho$，长度为 $L$，两端点为 $(x_1, y_1)$ 和 $(x_2, y_2)$。

势能泛函为：

$$V[y] = \rho g \int_{x_1}^{x_2} y \sqrt{1 + y'^2} \, dx$$

约束条件为长度固定：

$$\int_{x_1}^{x_2} \sqrt{1 + y'^2} \, dx = L$$

这是一个条件极值问题，应用拉格朗日乘子法可解得悬链线方程。

---

## 代码示例

### Octave 示例

```octave
% 变分法基础示例
% 计算泛函 J[y] = ∫(y^2 + y'^2)dx 的极值函数

% 定义符号变量
syms x y(x) C1 C2;

% 定义被积函数 F(x,y,y')
F = y(x)^2 + diff(y(x))^2;

% 计算欧拉-拉格朗日方程
F_y = diff(F, y(x));
F_yp = diff(F, diff(y(x)));
EL_eq = F_y - diff(F_yp, x) == 0;

% 求解微分方程
y_sol = dsolve(EL_eq, y(0) == 0, y(1) == 1);

% 显示结果
disp('极值函数为：');
disp(y_sol);
```

### Maxima 示例

```maxima
/* 变分法基础示例 */
/* 计算泛函 J[y] = ∫(y^2 + y'^2)dx 的极值函数 */

/* 定义被积函数 F(x,y,y') */
F: y(x)^2 + diff(y(x), x)^2;

/* 计算欧拉-拉格朗日方程 */
F_y: diff(F, y(x));
F_yp: diff(F, diff(y(x), x));
EL_eq: F_y - diff(F_yp, x) = 0;

/* 求解微分方程 */
ode2(EL_eq, y(x), x);
```

---

## 总结

本章介绍了泛函分析的基本概念和方法：

1. **变分法基础**：泛函、变分、极值条件
2. **欧拉-拉格朗日方程**：推导、特殊形式、自然边界条件
3. **泛函极值问题**：含参数问题、等周问题、充分条件
4. **力学应用**：拉格朗日力学、哈密顿力学、实际应用

这些工具在物理学、工程学和优化问题中有着广泛的应用。

---

## 进一步学习

::: tip 下一步
- [第6章：流体力学应用](../06-fluid-mechanics/)
- [高级主题：有限元方法](https://en.wikipedia.org/wiki/Finite_element_method)
- [变分法在机器学习中的应用](https://en.wikipedia.org/wiki/Variational_Bayesian_methods)
:::