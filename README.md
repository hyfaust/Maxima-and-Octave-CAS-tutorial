# CAS Learn

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![VitePress](https://img.shields.io/badge/VitePress-1.0-brightgreen.svg)](https://vitepress.dev/)
[![Octave](https://img.shields.io/badge/Octave-symbolic-orange.svg)](https://www.gnu.org/software/octave/)
[![Maxima](https://img.shields.io/badge/Maxima-5.48-purple.svg)](https://maxima.sourceforge.io/)

[English](README.md) | [简体中文](README_zh.md)

---

> An interactive tutorial for learning Computer Algebra Systems (CAS) using Octave and Maxima, covering topics from symbolic computation basics to advanced fluid mechanics applications.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Tutorial Outline](#tutorial-outline)
- [Project Structure](#project-structure)
- [Tech Stack](#tech-stack)
- [Contributing](#contributing)
- [License](#license)

## Introduction

**CAS Learn** is a comprehensive, self-paced tutorial that teaches computer algebra systems through practical examples. Each topic is implemented in both **Octave** (with the symbolic package) and **Maxima**, allowing learners to compare two mainstream CAS tools side by side.

The tutorial progresses from beginner-level symbolic computation to advanced physics and engineering applications, including variational calculus and fluid mechanics.

## Features

- **Dual CAS comparison** — Every example is provided in both Octave and Maxima
- **Progressive difficulty** — Four difficulty levels: beginner → basic → intermediate → advanced
- **Physics-oriented** — Covers real-world problems in functional analysis and fluid mechanics
- **Interactive web documentation** — Built with VitePress, featuring KaTeX math rendering and syntax highlighting
- **50 tested example files** — 25 Octave `.m` files + 25 Maxima `.mac` files, all verified to run correctly
- **Code comparison view** — Side-by-side Octave/Maxima code display in the documentation

## Prerequisites

| Dependency | Version | Required | Description |
|------------|---------|----------|-------------|
| [Node.js](https://nodejs.org/) | >= 18 | Yes (for docs) | Required to build the documentation site |
| [Octave](https://octave.org/download) | >= 8.0 | Yes (for examples) | GNU Octave with symbolic package |
| [Maxima](https://maxima.sourceforge.io/download.html) | >= 5.40 | Yes (for examples) | Maxima computer algebra system |

### Installing the Octave Symbolic Package

```octave
octave --eval "pkg install -forge symbolic"
```

## Installation

```bash
# Clone the repository
git clone https://github.com/your-repo/CAS_learn.git
cd CAS_learn

# Install Node.js dependencies (for documentation)
npm install
```

### Octave Setup

```bash
# Windows — download installer from https://octave.org/download
# macOS
brew install octave
# Linux (Ubuntu/Debian)
sudo apt install octave
```

### Maxima Setup

```bash
# Windows — download installer from https://maxima.sourceforge.io/download.html
# macOS
brew install maxima
# Linux (Ubuntu/Debian)
sudo apt install maxima
```

## Usage

### Running Example Code

**Octave:**
```octave
% Run an example file
cd examples/01-symbolic-basics/octave
octave --no-gui --no-window-system variables.m
```

**Maxima:**
```bash
# Run an example file
maxima -b examples/01-symbolic-basics/maxima/variables.mac
```

### Building the Documentation

```bash
# Development mode (hot-reload)
npm run dev

# Build static site
npm run build

# Preview built site
npm run preview
```

## Tutorial Outline

### Beginner
1. **Symbolic Computation Basics** — Variables, expressions, equation solving, function plotting

### Basic
2. **Calculus Fundamentals** — Limits, derivatives, integrals, series expansion

### Intermediate
3. **Linear Algebra** — Matrix operations, linear systems, eigenvalues, matrix decomposition
4. **Differential Equations** — First/higher-order ODEs, PDE basics, boundary value problems

### Advanced
5. **Functional Analysis Applications** — Calculus of variations, Euler-Lagrange equations, functional extrema, mechanics applications
6. **Fluid Mechanics Applications** — Navier-Stokes equations, stream functions, dimensional analysis, Rayleigh bubble collapse

## Project Structure

```
CAS_learn/
├── docs/                          # VitePress documentation source
│   ├── .vitepress/
│   │   ├── config.js              # VitePress configuration
│   │   ├── theme/                 # Custom theme and components
│   │   └── plugins/               # KaTeX plugin
│   ├── guide/                     # Tutorial chapters (6 chapters)
│   ├── examples/                  # Example code index page
│   └── public/                    # Static assets (example files)
├── examples/                      # Standalone example code
│   ├── 01-symbolic-basics/
│   │   ├── octave/                # Octave .m files
│   │   └── maxima/                # Maxima .mac files
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

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Documentation Framework | [VitePress](https://vitepress.dev/) |
| Math Rendering | [KaTeX](https://katex.org/) |
| Code Highlighting | [Shiki](https://shiki.matsu.io/) |
| Frontend Framework | [Vue 3](https://vuejs.org/) |
| CAS (Symbolic) | [Octave](https://www.gnu.org/software/octave/) + symbolic package |
| CAS (Standalone) | [Maxima](https://maxima.sourceforge.io/) |

## Contributing

Contributions are welcome! Here's how you can help:

1. **Report bugs** — Open an issue describing the problem
2. **Suggest improvements** — Propose new examples or tutorial sections
3. **Submit code** — Fork the repo, create a branch, and submit a pull request

## License

This project is licensed under the **GNU General Public License v3.0** — see the [LICENSE](LICENSE) file for details.
