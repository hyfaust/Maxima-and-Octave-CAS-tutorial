---
layout: home

hero:
  name: "CAS学习教程"
  text: "使用Octave和Maxima学习计算机代数系统"
  tagline: 从入门到高级，掌握符号计算的核心概念和应用
  actions:
    - theme: brand
      text: 开始学习
      link: /guide/
    - theme: alt
      text: 查看示例
      link: /examples/

features:
  - icon: 🎯
    title: 系统化学习路径
    details: 从符号计算基础到流体力学应用，4个难度级别循序渐进
  - icon: ⚡
    title: 双CAS系统对比
    details: 同时使用Octave和Maxima，对比学习两种主流计算机代数系统
  - icon: 🔬
    title: 经典物理问题
    details: 涵盖泛函分析、流体力学等高级物理问题的实际应用
  - icon: 💻
    title: 交互式学习
    details: 代码对比视图、数学公式渲染、学习进度跟踪等交互功能
---

## 教程特色

### 🎯 系统化学习路径

本教程按照难度梯度设计，从入门级到高级，涵盖：

- **入门级**：符号计算基础（变量、表达式、方程求解）
- **基础级**：微积分（极限、导数、积分、级数）
- **进阶级**：线性代数和微分方程
- **高级**：泛函分析和流体力学应用

### ⚡ 双CAS系统对比

每个主题同时提供 **Octave** 和 **Maxima** 的实现，帮助您：

- 理解不同CAS系统的设计哲学
- 掌握跨平台的符号计算技能
- 根据需求选择合适的工具

### 🔬 经典物理问题

特别包含高级物理问题的应用：

- **泛函分析**：变分法、欧拉-拉格朗日方程
- **流体力学**：Navier-Stokes方程、瑞利空化泡问题

### 💻 交互式学习体验

- **代码对比视图**：同时查看Octave和Maxima代码
- **数学公式渲染**：使用KaTeX渲染高质量数学公式
- **学习进度跟踪**：记录您的学习进度
- **概念解释弹窗**：点击术语查看详细解释

## 快速开始

### 环境准备

#### Octave安装
```bash
# Windows
# 从 https://octave.org/download 下载安装包

# macOS
brew install octave

# Linux (Ubuntu/Debian)
sudo apt install octave
```

#### Maxima安装
```bash
# Windows
# 从 https://maxima.sourceforge.io/download.html 下载安装包

# macOS
brew install maxima

# Linux (Ubuntu/Debian)
sudo apt install maxima
```

### 开始学习

1. **选择章节**：从[符号计算基础](/guide/01-symbolic-basics/)开始
2. **阅读理论**：理解每个主题的核心概念
3. **运行代码**：在Octave和Maxima中运行示例代码
4. **对比学习**：比较两种CAS系统的实现差异
5. **动手实践**：尝试修改代码，探索更多功能

## 适合人群

- **数学学习者**：希望掌握符号计算技能
- **物理/工程学生**：需要使用CAS解决实际问题
- **研究人员**：需要进行复杂的数学推导和计算
- **程序员**：希望了解计算机代数系统的原理和应用

## 技术栈

- **文档框架**：VitePress
- **数学渲染**：KaTeX
- **代码高亮**：Shiki
- **前端框架**：Vue 3
- **CAS系统**：Octave (symbolic包)、Maxima

## 贡献

欢迎提交Issue和Pull Request来改进本教程！

## 许可证

本教程基于GPL v3协议发布。