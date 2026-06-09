% Symbolic Variable Definition Examples for Octave
% 符号变量定义示例 - 适用于Octave（需要symbolic包）
%
% 本文件演示如何在Octave中定义和操作符号变量
% 作者: CAS Learn Tutorial
% 日期: 2026-06-05

% 确保加载symbolic包

%% 1. 基本符号变量定义
% 定义单个符号变量
x = sym('x');
y = sym('y');
z = sym('z');

% 显示变量类型
fprintf('变量 x 的类型: %s\n', class(x));
fprintf('变量 y 的类型: %s\n', class(y));

%% 2. 同时定义多个符号变量
% 使用 syms 函数定义多个变量
syms a b c d;
syms m n k;
fprintf('定义的符号变量: a=%s, b=%s, c=%s\n', char(a), char(b), char(c));
fprintf('定义的符号变量: m=%s, n=%s, k=%s\n', char(m), char(n), char(k));

%% 3. 符号常量
% 定义符号常量
pi_sym = sym(pi);
e_sym = sym(exp(1));

% 显示符号常量
fprintf('符号化的π: %s\n', char(pi_sym));
fprintf('符号化的e: %s\n', char(e_sym));

% 获取精确值
fprintf('π的精确值: %s\n', char(vpa(pi_sym, 20)));
fprintf('e的精确值: %s\n', char(vpa(e_sym, 20)));

%% 4. 带假设条件的符号变量
% 定义正实数符号变量
syms t positive;
% 定义整数符号变量
syms p integer;
% 定义实数符号变量
syms q real;

% 显示假设条件
fprintf('变量 t 的假设: %s\n', char(assumptions(t)));
fprintf('变量 p 的假设: %s\n', char(assumptions(p)));

%% 5. 符号表达式
% 创建符号表达式
expr1 = x^2 + 2*x + 1;
expr2 = sin(x) + cos(y);
expr3 = exp(z) * log(z);

% 显示表达式
fprintf('表达式1: %s\n', char(expr1));
fprintf('表达式2: %s\n', char(expr2));
fprintf('表达式3: %s\n', char(expr3));

%% 6. 符号矩阵
% 创建符号矩阵
A = [a, b; c, d];
B = sym([1, 2; 3, 4]);

% 显示矩阵
fprintf('符号矩阵 A:\n');
disp(A);
fprintf('数值矩阵 B:\n');
disp(B);

%% 7. 符号函数
% 定义符号函数
f(x) = x^3 - 2*x + 1;
g(x, y) = x^2 + y^2;

% 显示函数
fprintf('函数 f(x) = %s\n', char(f));
fprintf('函数 g(x,y) = %s\n', char(g));

% 计算函数值
fprintf('f(2) = %s\n', char(f(2)));
fprintf('g(3,4) = %s\n', char(g(3, 4)));

%% 8. 符号与数值的转换
% 符号转数值
sym_val = sym(355/113);
num_val = double(sym_val);
fprintf('符号值: %s\n', char(sym_val));
fprintf('数值: %f\n', num_val);

% 数值转符号
num = 2.718281828;
sym_num = sym(num);
fprintf('数值 %f 转符号: %s\n', num, char(sym_num));

%% 9. 清理工作区
% 注意：在实际使用中，根据需要决定是否清理
% clear x y z a b c m n k t p q;
fprintf('\n符号变量定义示例完成！\n');
