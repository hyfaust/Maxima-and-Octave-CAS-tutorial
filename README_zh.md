# CAS 学习教程

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![VitePress](https://img.shields.io/badge/VitePress-1.0-brightgreen.svg)](https://vitepress.dev/)
[![Octave](https://img.shields.io/badge/Octave-symbolic-orange.svg)](https://www.gnu.org/software/octave/)
[![Maxima](https://img.shields.io/badge/Maxima-5.48-purple.svg)](https://maxima.sourceforge.io/)

[English](README.md) | [简体中文](README_zh.md)

---

> 使用 Octave 和 Maxima 学习计算机代数系统（CAS）的交互式教程，涵盖从符号计算基础到高级流体力学应用的完整内容。

## 目录

- [简介](#简介)
- [特色功能](#特色功能)
- [环境要求](#环境要求)
- [安装](#安装)
- [使用方法](#使用方法)
- [教程大纲](#教程大纲)
- [项目结构](#项目结构)
- [技术栈](#技术栈)
- [贡献](#贡献)
- [许可证](#许可证)

## 简介

**CAS 学习教程**是一套系统化的计算机代数系统自学教程。每个主题都同时提供 **Octave**（配合 symbolic 包）和 **Maxima** 两种实现，方便学习者对比两种主流 CAS 工具的异同。

教程从入门级符号计算开始，逐步深入到高级物理和工程应用，包括变分法和流体力学。

## 特色功能

- **双 CAS 对比** — 每个示例同时提供 Octave 和 Maxima 两种实现
- **循序渐进** — 四个难度等级：入门 → 基础 → 进阶 → 高级
- **面向物理** — 涵盖泛函分析和流体力学中的实际问题
- **交互式文档** — 基于 VitePress 构建，支持 KaTeX 数学公式渲染和代码高亮
- **50 个已测试的示例文件** — 25 个 Octave `.m` 文件 + 25 个 Maxima `.mac` 文件，全部验证可正确运行
- **代码对比视图** — 文档中支持 Octave/Maxima 代码并排显示

## 环境要求

| 依赖 | 版本 | 是否必需 | 说明 |
|------|------|----------|------|
| [Node.js](https://nodejs.org/) | >= 18 | 是（构建文档） | 构建文档网站所需 |
| [Octave](https://octave.org/download) | >= 8.0 | 是（运行示例） | GNU Octave，需安装 symbolic 包 |
| [Maxima](https://maxima.sourceforge.io/download.html) | >= 5.40 | 是（运行示例） | Maxima 计算机代数系统 |

### 安装 Octave 符号包

```octave
octave --eval "pkg install -forge symbolic"
```

## 安装

```bash
# 克隆仓库
git clone https://github.com/your-repo/CAS_learn.git
cd CAS_learn

# 安装 Node.js 依赖（用于文档构建）
npm install
```

### Octave 安装

```bash
# Windows — 从 https://octave.org/download 下载安装包
# macOS
brew install octave
# Linux (Ubuntu/Debian)
sudo apt install octave
```

### Maxima 安装

```bash
# Windows — 从 https://maxima.sourceforge.io/download.html 下载安装包
# macOS
brew install maxima
# Linux (Ubuntu/Debian)
sudo apt install maxima
```

## 使用方法

### 运行示例代码

**Octave:**
```octave
% 运行示例文件
cd examples/01-symbolic-basics/octave
octave --no-gui --no-window-system variables.m
```

**Maxima:**
```bash
# 运行示例文件
maxima -b examples/01-symbolic-basics/maxima/variables.mac
```

### 构建文档

```bash
# 开发模式（支持热更新）
npm run dev

# 构建静态网站
npm run build

# 预览构建结果
npm run preview
```

## 教程大纲

### 入门级
1. **符号计算基础** — 变量与表达式定义、基本代数运算、方程求解、函数绘图

### 基础级
2. **微积分基础** — 极限计算、导数与微分、积分计算、级数展开

### 进阶级
3. **线性代数** — 矩阵运算、线性方程组求解、特征值与特征向量、矩阵分解
4. **微分方程** — 一阶/高阶常微分方程、偏微分方程基础、边值问题

### 高级
5. **泛函分析应用** — 变分法基础、欧拉-拉格朗日方程、泛函极值、力学应用
6. **流体力学应用** — Navier-Stokes 方程、流函数、量纲分析、瑞利空化泡问题

## 项目结构

```
CAS_learn/
├── docs/                          # VitePress 文档源码
│   ├── .vitepress/
│   │   ├── config.js              # VitePress 配置
│   │   ├── theme/                 # 自定义主题和组件
│   │   └── plugins/               # KaTeX 插件
│   ├── guide/                     # 教程章节（6 章）
│   ├── examples/                  # 示例代码索引页
│   └── public/                    # 静态资源（示例文件）
├── examples/                      # 独立示例代码
│   ├── 01-symbolic-basics/
│   │   ├── octave/                # Octave .m 文件
│   │   └── maxima/                # Maxima .mac 文件
│   ├── 02-calculus/
│   ├── 03-linear-algebra/
│   ├── 04-differential-equations/
│   ├── 05-functional-analysis/
│   └── 06-fluid-mechanics/
├── package.json
├── LICENSE
├── README.md
└── README_zh.md
```

## 技术栈

| 组件 | 技术 |
|------|------|
| 文档框架 | [VitePress](https://vitepress.dev/) |
| 数学渲染 | [KaTeX](https://katex.org/) |
| 代码高亮 | [Shiki](https://shiki.matsu.io/) |
| 前端框架 | [Vue 3](https://vuejs.org/) |
| CAS（符号计算） | [Octave](https://www.gnu.org/software/octave/) + symbolic 包 |
| CAS（独立系统） | [Maxima](https://maxima.sourceforge.io/) |

## 贡献

欢迎贡献！以下是参与方式：

1. **报告问题** — 提交 Issue 描述问题
2. **建议改进** — 提出新示例或教程内容
3. **提交代码** — Fork 仓库，创建分支，提交 Pull Request

## 许可证

本项目基于 **GNU 通用公共许可证 v3.0** 发布 — 详见 [LICENSE](LICENSE) 文件。
