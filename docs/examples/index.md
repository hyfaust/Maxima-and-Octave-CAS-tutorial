# 示例代码索引

本页面汇集了所有教程章节的示例代码，您可以直接下载运行。

## 环境准备

### Octave
```bash
# 安装symbolic包
octave --eval "pkg install -forge symbolic"
```

### Maxima
```bash
# 从 https://maxima.sourceforge.io/ 下载安装
# 或使用包管理器
# Ubuntu/Debian: sudo apt install maxima
# macOS: brew install maxima
```

## 第1章：符号计算基础

| 示例 | 说明 | Octave | Maxima |
|------|------|--------|--------|
| 变量定义 | 符号变量与表达式定义 | <a href="/examples/01-symbolic-basics/octave/variables.m" download>variables.m</a> | <a href="/examples/01-symbolic-basics/maxima/variables.mac" download>variables.mac</a> |
| 基本运算 | 化简、展开、因式分解 | <a href="/examples/01-symbolic-basics/octave/operations.m" download>operations.m</a> | <a href="/examples/01-symbolic-basics/maxima/operations.mac" download>operations.mac</a> |
| 方程求解 | 一元及多元方程 | <a href="/examples/01-symbolic-basics/octave/equations.m" download>equations.m</a> | <a href="/examples/01-symbolic-basics/maxima/equations.mac" download>equations.mac</a> |
| 函数绘图 | 符号函数可视化 | <a href="/examples/01-symbolic-basics/octave/plotting.m" download>plotting.m</a> | <a href="/examples/01-symbolic-basics/maxima/plotting.mac" download>plotting.mac</a> |

## 第2章：微积分基础

| 示例 | 说明 | Octave | Maxima |
|------|------|--------|--------|
| 极限计算 | 各类极限计算 | <a href="/examples/02-calculus/octave/limits.m" download>limits.m</a> | <a href="/examples/02-calculus/maxima/limits.mac" download>limits.mac</a> |
| 导数与微分 | 符号导数运算 | <a href="/examples/02-calculus/octave/derivatives.m" download>derivatives.m</a> | <a href="/examples/02-calculus/maxima/derivatives.mac" download>derivatives.mac</a> |
| 积分计算 | 不定积分与定积分 | <a href="/examples/02-calculus/octave/integrals.m" download>integrals.m</a> | <a href="/examples/02-calculus/maxima/integrals.mac" download>integrals.mac</a> |
| 级数展开 | 泰勒级数展开 | <a href="/examples/02-calculus/octave/series.m" download>series.m</a> | <a href="/examples/02-calculus/maxima/series.mac" download>series.mac</a> |

## 第3章：线性代数

| 示例 | 说明 | Octave | Maxima |
|------|------|--------|--------|
| 矩阵运算 | 矩阵创建与基本运算 | <a href="/examples/03-linear-algebra/octave/matrices.m" download>matrices.m</a> | <a href="/examples/03-linear-algebra/maxima/matrices.mac" download>matrices.mac</a> |
| 线性方程组 | 符号求解线性系统 | <a href="/examples/03-linear-algebra/octave/linear_systems.m" download>linear_systems.m</a> | <a href="/examples/03-linear-algebra/maxima/linear_systems.mac" download>linear_systems.mac</a> |
| 特征值问题 | 特征值与特征向量 | <a href="/examples/03-linear-algebra/octave/eigenvalues.m" download>eigenvalues.m</a> | <a href="/examples/03-linear-algebra/maxima/eigenvalues.mac" download>eigenvalues.mac</a> |
| 矩阵分解 | LU、QR分解 | <a href="/examples/03-linear-algebra/octave/decompositions.m" download>decompositions.m</a> | <a href="/examples/03-linear-algebra/maxima/decompositions.mac" download>decompositions.mac</a> |

## 第4章：微分方程

| 示例 | 说明 | Octave | Maxima |
|------|------|--------|--------|
| 一阶ODE | 可分离、线性方程 | <a href="/examples/04-differential-equations/octave/ode_first_order.m" download>ode_first_order.m</a> | <a href="/examples/04-differential-equations/maxima/ode_first_order.mac" download>ode_first_order.mac</a> |
| 高阶ODE | 常系数、变参数法 | <a href="/examples/04-differential-equations/octave/ode_higher_order.m" download>ode_higher_order.m</a> | <a href="/examples/04-differential-equations/maxima/ode_higher_order.mac" download>ode_higher_order.mac</a> |
| PDE基础 | 偏微分方程简介 | <a href="/examples/04-differential-equations/octave/pde_basics.m" download>pde_basics.m</a> | <a href="/examples/04-differential-equations/maxima/pde_basics.mac" download>pde_basics.mac</a> |
| 边值问题 | 打靶法与有限差分 | <a href="/examples/04-differential-equations/octave/boundary_value.m" download>boundary_value.m</a> | <a href="/examples/04-differential-equations/maxima/boundary_value.mac" download>boundary_value.mac</a> |

## 第5章：泛函分析应用

| 示例 | 说明 | Octave | Maxima |
|------|------|--------|--------|
| 变分法基础 | 泛函与变分 | <a href="/examples/05-functional-analysis/octave/calculus_of_variations.m" download>calculus_of_variations.m</a> | <a href="/examples/05-functional-analysis/maxima/calculus_of_variations.mac" download>calculus_of_variations.mac</a> |
| 欧拉-拉格朗日方程 | 推导与求解 | <a href="/examples/05-functional-analysis/octave/euler_lagrange.m" download>euler_lagrange.m</a> | <a href="/examples/05-functional-analysis/maxima/euler_lagrange.mac" download>euler_lagrange.mac</a> |
| 泛函极值 | 极值条件与求解 | <a href="/examples/05-functional-analysis/octave/functional_extremum.m" download>functional_extremum.m</a> | <a href="/examples/05-functional-analysis/maxima/functional_extremum.mac" download>functional_extremum.mac</a> |
| 力学应用 | 拉格朗日力学 | <a href="/examples/05-functional-analysis/octave/mechanics_applications.m" download>mechanics_applications.m</a> | <a href="/examples/05-functional-analysis/maxima/mechanics_applications.mac" download>mechanics_applications.mac</a> |

## 第6章：流体力学应用

| 示例 | 说明 | Octave | Maxima |
|------|------|--------|--------|
| N-S方程 | Navier-Stokes方程 | <a href="/examples/06-fluid-mechanics/octave/navier_stokes.m" download>navier_stokes.m</a> | <a href="/examples/06-fluid-mechanics/maxima/navier_stokes.mac" download>navier_stokes.mac</a> |
| 流函数 | 流函数与势函数 | <a href="/examples/06-fluid-mechanics/octave/stream_function.m" download>stream_function.m</a> | <a href="/examples/06-fluid-mechanics/maxima/stream_function.mac" download>stream_function.mac</a> |
| 简单流动 | 符号求解流动问题 | <a href="/examples/06-fluid-mechanics/octave/simple_flows.m" download>simple_flows.m</a> | <a href="/examples/06-fluid-mechanics/maxima/simple_flows.mac" download>simple_flows.mac</a> |
| 量纲分析 | Buckingham Pi定理 | <a href="/examples/06-fluid-mechanics/octave/dimensional_analysis.m" download>dimensional_analysis.m</a> | <a href="/examples/06-fluid-mechanics/maxima/dimensional_analysis.mac" download>dimensional_analysis.mac</a> |
| **瑞利空化泡** | 空泡瞬态问题 | <a href="/examples/06-fluid-mechanics/octave/rayleigh_bubble.m" download>rayleigh_bubble.m</a> | <a href="/examples/06-fluid-mechanics/maxima/rayleigh_bubble.mac" download>rayleigh_bubble.mac</a> |

## 使用方法

### Octave中运行
```octave
% 加载symbolic包
pkg load symbolic

% 运行示例
run('path/to/example.m')
```

### Maxima中运行
```maxima
/* 在Maxima中加载并运行 */
batch("path/to/example.mac");
```

## 注意事项

1. Octave需要安装symbolic包才能使用符号计算功能
2. Maxima是独立的CAS系统，语法与Octave不同
3. 部分高级功能可能需要特定版本的支持
4. 建议按照章节顺序学习，循序渐进
