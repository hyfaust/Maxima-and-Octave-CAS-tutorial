% =========================================================================
% 泛函极值问题 - Octave 实现
% =========================================================================
% 本文件演示泛函极值问题的各种类型和求解方法
% 需要安装 Octave 的符号包（symbolic）
% =========================================================================

% 加载符号包

% 清除工作空间
clear;
clc;

fprintf('========================================\n');
fprintf('        泛函极值问题示例\n');
fprintf('========================================\n\n');

% -------------------------------------------------------------------------
% 1. 含参数的泛函极值
% -------------------------------------------------------------------------
% 考虑含参数 λ 的泛函：
% J[y] = ∫_a^b F(x, y, y', λ) dx
% 极值条件：∂F/∂y - d/dx(∂F/∂y') = 0 且 ∂J/∂λ = 0

% 定义符号变量
syms x y(x) lambda C1 C2;

fprintf('1. 含参数的泛函极值\n');
fprintf('   考虑含参数 λ 的泛函：\n');
fprintf("   J[y] = ∫_a^b F(x, y, y', λ) dx\n");
fprintf('   极值条件：\n');
fprintf("   1. ∂F/∂y - d/dx(∂F/∂y') = 0\n");
fprintf('   2. ∂J/∂λ = 0\n\n');

% 示例：J[y] = ∫_0^1 (y'^2 - λ*y^2) dx，y(0)=0，y(1)=1
F = diff(y(x), x)^2 - lambda * y(x)^2;
F_y = diff(F, y(x));
F_yp = diff(F, diff(y(x), x));
EL = F_y - diff(F_yp, x);

fprintf('   示例：J[y] = ∫_0^1 (y''^2 - λ*y^2) dx\n');
fprintf('   y(0)=0，y(1)=1\n\n');
fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n\n', char(EL));

% 化简
EL_simplified = simplify(EL);
fprintf('   化简后：\n');
fprintf('   %s = 0\n\n', char(EL_simplified));

% 求解微分方程
y_sol = dsolve(EL_simplified, y(0) == 0, y(1) == 1);
y_sol = simplify(y_sol);

fprintf('   满足边界条件的解：\n');
fprintf('   y(x) = %s\n\n', char(y_sol));

% -------------------------------------------------------------------------
% 2. 等周问题（条件极值）
% -------------------------------------------------------------------------
% 等周问题：在满足约束条件 ∫G(x,y,y')dx = L 的函数中，
% 寻找使泛函 J[y] = ∫F(x,y,y')dx 取极值的函数

fprintf('2. 等周问题（条件极值）\n');
fprintf('   等周问题：在约束条件下求泛函极值\n');
fprintf("   约束条件：∫_a^b G(x, y, y') dx = L\n");
fprintf("   目标泛函：J[y] = ∫_a^b F(x, y, y') dx\n\n");

% 示例：在长度固定的曲线中，寻找面积最大的曲线
% 设曲线 y(x) 从 (0,0) 到 (1,0)，长度 L
% 约束条件：∫_0^1 √(1 + y'^2) dx = L
% 目标泛函（面积）：J[y] = ∫_0^1 y dx

F_iso = y(x);  % 目标泛函的被积函数
G_iso = sqrt(1 + diff(y(x), x)^2);  % 约束条件的被积函数

% 构造拉格朗日函数
L_iso = F_iso + lambda * G_iso;
L_iso_y = diff(L_iso, y(x));
L_iso_yp = diff(L_iso, diff(y(x), x));
EL_iso = L_iso_y - diff(L_iso_yp, x);

fprintf('   示例：在长度固定的曲线中，寻找面积最大的曲线\n');
fprintf('   目标泛函：J[y] = ∫_0^1 y dx\n');
fprintf('   约束条件：∫_0^1 √(1 + y''^2) dx = L\n\n');

fprintf('   拉格朗日函数：L = y + λ√(1 + y''^2)\n');
fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n\n', char(EL_iso));

% 化简
EL_iso_simplified = simplify(EL_iso);
fprintf('   化简后：\n');
fprintf('   %s = 0\n\n', char(EL_iso_simplified));

% 求解微分方程
% 由于方程复杂，这里给出解析解的形式
% 解是圆弧：(x - x0)^2 + (y - y0)^2 = R^2
fprintf('   解析解：圆弧\n');
fprintf('   (x - x0)^2 + (y - y0)^2 = R^2\n\n');

% -------------------------------------------------------------------------
% 3. 泛函极值的充分条件
% -------------------------------------------------------------------------
% 二阶变分和勒让德条件

fprintf('3. 泛函极值的充分条件\n');
fprintf('   二阶变分和勒让德条件\n\n');

% 对于泛函 J[y] = ∫_a^b F(x, y, y') dx
% 二阶变分：δ^2J = ∫_a^b [F_{yy}η^2 + 2F_{yy'}ηη' + F_{y'y'}η'^2] dx
% 勒让德条件：F_{y'y''} ≥ 0 是极小值的必要条件

% 示例：分析 F = y'^2 + y^2
F3 = diff(y(x), x)^2 + y(x)^2;

% 计算二阶偏导数
F3_yy = diff(F3, y(x), 2);
F3_yyp = diff(diff(F3, y(x)), diff(y(x), x));
F3_ypyp = diff(F3, diff(y(x), x), 2);

fprintf('   示例：F = y''^2 + y^2\n');
fprintf('   计算二阶偏导数：\n');
fprintf('   F_{yy} = %s\n', char(F3_yy));
fprintf('   F_{yy''} = %s\n', char(F3_yyp));
fprintf('   F_{y''y''} = %s\n\n', char(F3_ypyp));

% 勒让德条件
fprintf('   勒让德条件：\n');
fprintf('   F_{y''y''} = %s\n', char(F3_ypyp));
fprintf('   由于 F_{y''y''} = 2 > 0，满足极小值的必要条件\n\n');

% 判断极值类型
if isequal(F3_ypyp, sym(2))
    fprintf('   结论：该泛函存在极小值\n\n');
else
    fprintf('   结论：需要进一步分析\n\n');
end

% -------------------------------------------------------------------------
% 4. 自然边界条件
% -------------------------------------------------------------------------
% 当边界值未指定时，需要添加自然边界条件

fprintf('4. 自然边界条件\n');
fprintf('   当边界值 y(a) 或 y(b) 未指定时，需要添加自然边界条件：\n');
fprintf('   ∂F/∂y''|_{x=a} = 0 或 ∂F/∂y''|_{x=b} = 0\n\n');

% 示例：J[y] = ∫_0^1 (y'^2 - 2*y) dx，y(0)=0，y(1) 自由
F4 = diff(y(x), x)^2 - 2*y(x);
F4_yp = diff(F4, diff(y(x), x));

fprintf('   示例：J[y] = ∫_0^1 (y''^2 - 2*y) dx，y(0)=0，y(1) 自由\n');
fprintf('   ∂F/∂y'' = %s\n', char(F4_yp));

% 欧拉-拉格朗日方程
F4_y = diff(F4, y(x));
EL4 = F4_y - diff(F4_yp, x);

fprintf('   欧拉-拉格朗日方程：\n');
fprintf('   %s = 0\n', char(EL4));
fprintf('   即：y'' = -1\n\n');

% 求解微分方程
y4_sol = dsolve(diff(y(x), 2) == -1, y(0) == 0);
y4_sol = simplify(y4_sol);
fprintf('   通解：y(x) = %s\n\n', char(y4_sol));

% 应用自然边界条件 ∂F/∂y''|_{x=1} = 0
% ∂F/∂y'' = 2*y'，所以 y'(1) = 0
% 从通解 y = -x^2/2 + C1*x + C2，有 y' = -x + C1
% y'(1) = -1 + C1 = 0 => C1 = 1
% y(0) = 0 => C2 = 0

y4_particular = -x^2/2 + x;
fprintf('   应用自然边界条件 y''(1) = 0：\n');
fprintf('   y(x) = %s\n\n', char(y4_particular));

% -------------------------------------------------------------------------
% 5. 数值方法：Ritz 方法
% -------------------------------------------------------------------------
% Ritz 方法：将未知函数展开为基函数的线性组合
% y(x) ≈ ∑ c_i φ_i(x)
% 其中 φ_i(x) 是满足边界条件的基函数

fprintf('5. 数值方法：Ritz 方法\n');
fprintf('   Ritz 方法：将未知函数展开为基函数的线性组合\n');
fprintf('   y(x) ≈ ∑ c_i φ_i(x)\n');
fprintf('   其中 φ_i(x) 是满足边界条件的基函数\n\n');

% 示例：使用 Ritz 方法求解 J[y] = ∫_0^1 (y'^2 - 2*y) dx
% 边界条件：y(0)=0，y(1)=0
% 解析解：y = x(1-x)/2

% 选择基函数 φ_i(x) = x^i(1-x)，满足边界条件
% y(x) ≈ c1*x(1-x) + c2*x^2(1-x) + c3*x^3(1-x)

fprintf('   示例：使用 Ritz 方法求解\n');
fprintf('   J[y] = ∫_0^1 (y''^2 - 2*y) dx\n');
fprintf('   边界条件：y(0)=0，y(1)=0\n\n');

% 解析解
y_exact = x*(1-x)/2;
fprintf('   解析解：y(x) = %s\n\n', char(y_exact));

% Ritz 方法：使用多项式基函数
% y(x) = c1*x(1-x) + c2*x^2(1-x) + c3*x^3(1-x)

% 定义基函数
phi1 = x*(1-x);
phi2 = x^2*(1-x);
phi3 = x^3*(1-x);

% 计算刚度矩阵 K 和载荷向量 f
% K_ij = ∫_0^1 φ_i' φ_j' dx
% f_i = ∫_0^1 2*φ_i dx

% 计算基函数的导数
dphi1 = diff(phi1, x);
dphi2 = diff(phi2, x);
dphi3 = diff(phi3, x);

% 刚度矩阵元素
K11 = int(dphi1 * dphi1, x, 0, 1);
K12 = int(dphi1 * dphi2, x, 0, 1);
K13 = int(dphi1 * dphi3, x, 0, 1);
K22 = int(dphi2 * dphi2, x, 0, 1);
K23 = int(dphi2 * dphi3, x, 0, 1);
K33 = int(dphi3 * dphi3, x, 0, 1);

K = [K11, K12, K13; K12, K22, K23; K13, K23, K33];

% 载荷向量元素
f1 = int(2*phi1, x, 0, 1);
f2 = int(2*phi2, x, 0, 1);
f3 = int(2*phi3, x, 0, 1);

f = [f1; f2; f3];

fprintf('   刚度矩阵 K：\n');
disp(K);

fprintf('   载荷向量 f：\n');
disp(f);

% 求解线性方程组 K*c = f
c = double(K) \ double(f);

fprintf('   系数向量 c：\n');
disp(c);

% Ritz 近似解
y_ritz = c(1)*phi1 + c(2)*phi2 + c(3)*phi3;
y_ritz = simplify(y_ritz);

fprintf('   Ritz 近似解：\n');
fprintf('   y(x) = %s\n\n', char(y_ritz));

% 计算误差
x_vals = linspace(0, 1, 100);
y_exact_vals = double(subs(y_exact, x, x_vals));
y_ritz_vals = double(subs(y_ritz, x, x_vals));

error = max(abs(y_exact_vals - y_ritz_vals));
fprintf('   最大误差：%.2e\n\n', error);

% -------------------------------------------------------------------------
% 6. 伽辽金方法
% -------------------------------------------------------------------------
% 伽辽金方法：选择满足边界条件的基函数
% 要求残差 R(x) = -y'' - 1 与所有基函数正交
% ∫_0^1 R(x) φ_i(x) dx = 0

fprintf('6. 伽辽金方法\n');
fprintf('   伽辽金方法：要求残差与所有基函数正交\n');
fprintf('   ∫_0^1 R(x) φ_i(x) dx = 0\n\n');

% 示例：使用伽辽金方法求解 y'' = -1，y(0)=0，y(1)=0
% 残差 R(x) = -y'' - 1

% 使用与 Ritz 方法相同的基函数
% y(x) = c1*x(1-x) + c2*x^2(1-x) + c3*x^3(1-x)

fprintf('   示例：使用伽辽金方法求解 y'''' = -1，y(0)=0，y(1)=0\n\n');

% 计算残差
y_approx = c(1)*phi1 + c(2)*phi2 + c(3)*phi3;
R = -diff(y_approx, x, 2) - 1;

fprintf('   残差 R(x) = -y'''' - 1\n');
fprintf('   R(x) = %s\n\n', char(simplify(R)));

% 检查正交性
orth1 = int(R * phi1, x, 0, 1);
orth2 = int(R * phi2, x, 0, 1);
orth3 = int(R * phi3, x, 0, 1);

fprintf('   检查正交性：\n');
fprintf('   ∫ R*φ1 dx = %s\n', char(simplify(orth1)));
fprintf('   ∫ R*φ2 dx = %s\n', char(simplify(orth2)));
fprintf('   ∫ R*φ3 dx = %s\n\n', char(simplify(orth3)));

% 由于我们已经使用 Ritz 方法求解，这里的结果应该接近于零
fprintf('   注：使用 Ritz 方法得到的解自然满足伽辽金条件\n\n');

% -------------------------------------------------------------------------
% 7. Ritz方法收敛性分析
% -------------------------------------------------------------------------

n_basis = 1:5;
errors_ritz = zeros(size(n_basis));

for n = 1:length(n_basis)
    % 构建基函数
    phi_funcs = cell(1, n);
    dphi_funcs = cell(1, n);
    
    for i = 1:n
        phi_funcs{i} = x^i * (1-x);
        dphi_funcs{i} = diff(phi_funcs{i}, x);
    end
    
    % 计算刚度矩阵
    K = zeros(n, n);
    for i = 1:n
        for j = 1:n
            K(i, j) = double(int(dphi_funcs{i} * dphi_funcs{j}, x, 0, 1));
        end
    end

    % 计算载荷向量
    f = zeros(n, 1);
    for i = 1:n
        f(i) = double(int(2*phi_funcs{i}, x, 0, 1));
    end
    
    % 求解
    c = double(K) \ double(f);
    
    % 构造近似解
    y_approx = sym(0);
    for i = 1:n
        y_approx = y_approx + c(i) * phi_funcs{i};
    end
    
    % 计算误差
    y_approx_vals = double(subs(y_approx, x, x_vals));
    errors_ritz(n) = max(abs(y_exact_vals - y_approx_vals));
end

fprintf('   Ritz 方法收敛性：\n');
for n = 1:length(n_basis)
    fprintf('   n = %d, 误差 = %.2e\n', n, errors_ritz(n));
end

% -------------------------------------------------------------------------
% 8. 总结
% -------------------------------------------------------------------------
fprintf('\n========================================\n');
fprintf('            总结\n');
fprintf('========================================\n');
fprintf('1. 含参数的泛函极值需要同时满足欧拉-拉格朗日方程和参数条件\n');
fprintf('2. 等周问题使用拉格朗日乘子法\n');
fprintf('3. 充分条件包括二阶变分和勒让德条件\n');
fprintf('4. 自然边界条件处理自由边界\n');
fprintf('5. 数值方法：Ritz 方法和伽辽金方法\n');
fprintf('6. 收敛性分析验证数值方法的有效性\n\n');

fprintf('示例完成。\n');