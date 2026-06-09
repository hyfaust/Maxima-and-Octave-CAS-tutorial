% Basic Algebraic Operations for Octave
% 基本代数运算示例 - 适用于Octave（需要symbolic包）
%
% 本文件演示符号计算中的基本代数运算
% 作者: CAS Learn Tutorial
% 日期: 2026-06-05

% 确保加载symbolic包

%% 定义符号变量
syms x y z a b c;

%% 1. 表达式展开 (Expand)
% 展开多项式
expr1 = (x + 1)^3;
expanded1 = expand(expr1);
fprintf('原始表达式: %s\n', char(expr1));
fprintf('展开后: %s\n', char(expanded1));

% 展开三角函数表达式
expr2 = sin(x + y);
expanded2 = expand(expr2);
fprintf('\n三角函数展开:\n');
fprintf('sin(x+y) = %s\n', char(expanded2));

% 展开指数表达式
expr3 = exp(x + y);
expanded3 = expand(expr3);
fprintf('\n指数函数展开:\n');
fprintf('e^(x+y) = %s\n', char(expanded3));

%% 2. 表达式因式分解 (Factor)
% 因式分解多项式
poly1 = x^3 - 8;
factored1 = factor(poly1);
fprintf('\n多项式因式分解:\n');
fprintf('x³ - 8 = %s\n', char(factored1));

% 因式分解二次多项式
poly2 = x^2 - 5*x + 6;
factored2 = factor(poly2);
fprintf('x² - 5x + 6 = %s\n', char(factored2));

% 因式分解高次多项式
poly3 = x^4 - 16;
factored3 = factor(poly3);
fprintf('x⁴ - 16 = %s\n', char(factored3));

%% 3. 表达式化简 (Simplify)
% 化简三角函数表达式
trig_expr = sin(x)^2 + cos(x)^2;
simplified1 = simplify(trig_expr);
fprintf('\n三角函数化简:\n');
fprintf('sin²(x) + cos²(x) = %s\n', char(simplified1));

% 化简有理函数
rational_expr = (x^2 - 1)/(x - 1);
simplified2 = simplify(rational_expr);
fprintf('(x² - 1)/(x - 1) = %s\n', char(simplified2));

% 化简指数表达式
exp_expr = exp(x) * exp(y);
simplified3 = simplify(exp_expr);
fprintf('e^x * e^y = %s\n', char(simplified3));

%% 4. 表达式合并同类项 (Collect)
% 按指定变量合并同类项
poly_expr = a*x^2 + b*x + c + 2*x^2 + 3*x;
collected = collect(poly_expr, x);
fprintf('\n合并同类项:\n');
fprintf('原式: %s\n', char(poly_expr));
fprintf('按x合并: %s\n', char(collected));

%% 5. 表达式重写 (Rewrite)
% 将三角函数重写为指数形式
sin_exp = rewrite(sin(x), 'exp');
cos_exp = rewrite(cos(x), 'exp');
fprintf('\n三角函数重写为指数形式:\n');
fprintf('sin(x) = %s\n', char(sin_exp));
fprintf('cos(x) = %s\n', char(cos_exp));

%% 6. 代入运算 (Substitute)
% 简单代入
expr = x^2 + 2*x + 1;
result1 = subs(expr, x, 3);
fprintf('\n代入运算:\n');
fprintf('当x=3时，x² + 2x + 1 = %s\n', char(result1));

% 多变量代入
expr2 = x*y + x^2;
result2 = subs(expr2, {x, y}, {2, 3});
fprintf('当x=2, y=3时，xy + x² = %s\n', char(result2));

% 符号代入
result3 = subs(expr, x, y+1);
fprintf('将x替换为y+1: %s\n', char(result3));

%% 7. 展开与因式分解的对比
fprintf('\n=== 展开与因式分解对比 ===\n');
test_expr = (x - 1)*(x + 1)*(x^2 + 1);
fprintf('原始表达式: %s\n', char(test_expr));
fprintf('展开后: %s\n', char(expand(test_expr)));
fprintf('因式分解: %s\n', char(factor(expand(test_expr))));

%% 8. 复杂表达式处理
% 物理学中的实际例子：相对论质量公式
% m = m0 / sqrt(1 - v²/c²)
syms m0 v c;
relativistic_mass = m0 / sqrt(1 - v^2/c^2);
fprintf('\n=== 物理学例子：相对论质量 ===\n');
fprintf('相对论质量公式: %s\n', char(relativistic_mass));

% 当v远小于c时的近似展开（泰勒展开）
approx_mass = taylor(relativistic_mass, v, 0, 'Order', 3);
fprintf('低速近似 (v << c): %s\n', char(approx_mass));

%% 9. 工程应用：电路阻抗计算
syms R L C omega;
% RLC串联电路的阻抗
Z_R = R;
Z_L = 1i*omega*L;
Z_C = 1/(1i*omega*C);
Z_total = Z_R + Z_L + Z_C;
Z_simplified = simplify(Z_total);

fprintf('\n=== 工程例子：RLC电路阻抗 ===\n');
fprintf('总阻抗 Z = %s\n', char(Z_simplified));
fprintf('阻抗模 |Z| = %s\n', char(simplify(abs(Z_simplified))));

fprintf('\n基本代数运算示例完成！\n');
