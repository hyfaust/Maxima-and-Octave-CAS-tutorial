% derivatives.m - 导数计算示例
% 本文件演示如何使用 Octave 符号计算包计算各种类型的导数
% 确保已安装并加载符号计算包

% 加载符号计算包

% 定义符号变量
syms x a

disp('=== 导数计算示例 ===')
disp(' ')

%% 1. 基本导数
disp('1. 基本导数计算')

% 示例1：多项式导数
f1 = x^3 - 2*x^2 + 5*x - 7;
df1 = diff(f1, x);
d2f1 = diff(f1, x, 2);
disp(['f(x) = ', char(f1)])
disp(['f''(x) = ', char(df1)])
disp(['f''''(x) = ', char(d2f1)])

disp(' ')

% 示例2：三角函数导数
f2 = sin(x);
df2 = diff(f2, x);
disp(['sin(x) 的导数: ', char(df2)])

f3 = cos(x);
df3 = diff(f3, x);
disp(['cos(x) 的导数: ', char(df3)])

f4 = tan(x);
df4 = diff(f4, x);
df4_simplified = simplify(df4);
disp(['tan(x) 的导数: ', char(df4_simplified)])

disp(' ')

% 示例3：指数和对数函数导数
f5 = exp(x);
df5 = diff(f5, x);
disp(['e^x 的导数: ', char(df5)])

f6 = log(x);
df6 = diff(f6, x);
disp(['ln(x) 的导数: ', char(df6)])

f7 = a^x;  % 注意：a 是常数
df7 = diff(f7, x);
disp(['a^x 的导数: ', char(df7)])

disp(' ')

%% 2. 链式法则
disp('2. 链式法则')

% 示例4：复合函数导数 sin(x^2)
f8 = sin(x^2);
df8 = diff(f8, x);
disp(['sin(x^2) 的导数: ', char(df8)])

% 示例5：e^(3x^2 + 1)
f9 = exp(3*x^2 + 1);
df9 = diff(f9, x);
disp(['e^(3x^2+1) 的导数: ', char(df9)])

% 示例6：ln(sqrt(1+x^2))
f10 = log(sqrt(1 + x^2));
df10 = diff(f10, x);
df10_simplified = simplify(df10);
disp(['ln(sqrt(1+x^2)) 的导数: ', char(df10_simplified)])

disp(' ')

%% 3. 乘积法则和商法则
disp('3. 乘积法则和商法则')

% 示例7：乘积法则 (x^2 * sin(x))
u = x^2;
v = sin(x);
f11 = u * v;
df11 = diff(f11, x);
disp(['(x^2 * sin(x)) 的导数: ', char(df11)])

% 验证乘积法则
du = diff(u, x);
dv = diff(v, x);
product_rule = du*v + u*dv;
disp(['使用乘积法则验证: ', char(simplify(product_rule))])

disp(' ')

% 示例8：商法则 (cos(x)/(1+x^2))
f12 = cos(x) / (1 + x^2);
df12 = diff(f12, x);
df12_simplified = simplify(df12);
disp(['(cos(x)/(1+x^2)) 的导数: ', char(df12_simplified)])

disp(' ')

%% 4. 隐函数求导
disp('4. 隐函数求导')

% 示例9：圆方程 x^2 + y^2 = 25
syms y
F = x^2 + y^2 - 25;

% 对 x 求导，将 y 视为 x 的函数
dF_dx = diff(F, x) + diff(F, y) * diff(y, x);
disp(['圆方程: ', char(F), ' = 0'])
disp(['对 x 求导: ', char(dF_dx)])

% 解出 dy/dx
dy_dx = solve(dF_dx, diff(y, x));
disp(['dy/dx = ', char(dy_dx)])

% 在点 (3, 4) 处的导数值
slope = subs(dy_dx, [x, y], [3, 4]);
disp(['在点 (3,4) 处的斜率: ', char(slope)])

disp(' ')

%% 5. 参数方程求导
disp('5. 参数方程求导')

% 示例10：参数方程 x(t) = 3t^2, y(t) = 2t^3
syms t
x_param = 3*t^2;
y_param = 2*t^3;

% 计算 dy/dx = (dy/dt)/(dx/dt)
dx_dt = diff(x_param, t);
dy_dt = diff(y_param, t);
dy_dx_param = dy_dt / dx_dt;
dy_dx_param_simplified = simplify(dy_dx_param);

disp(['参数方程: x(t) = ', char(x_param), ', y(t) = ', char(y_param)])
disp(['dx/dt = ', char(dx_dt)])
disp(['dy/dt = ', char(dy_dt)])
disp(['dy/dx = ', char(dy_dx_param_simplified)])

% 在 t=1 时的导数值
slope_at_1 = subs(dy_dx_param, t, 1);
disp(['t=1 时的斜率: ', char(slope_at_1)])

disp(' ')

%% 6. 物理应用：运动学
disp('6. 物理应用：运动学')

% 示例11：物体沿曲线运动
x_pos = 3*t^2;
y_pos = 2*t^3;

% 速度分量
vx = diff(x_pos, t);
vy = diff(y_pos, t);
disp(['速度分量: vx = ', char(vx), ', vy = ', char(vy)])

% 速度大小
v_magnitude = sqrt(vx^2 + vy^2);
v_at_1 = subs(v_magnitude, t, 1);
disp(['t=1 时速度大小: ', char(v_at_1), ' = ', num2str(double(v_at_1))])

% 加速度分量
ax = diff(vx, t);
ay = diff(vy, t);
disp(['加速度分量: ax = ', char(ax), ', ay = ', char(ay)])

% 加速度大小
a_magnitude = sqrt(ax^2 + ay^2);
a_at_1 = subs(a_magnitude, t, 1);
disp(['t=1 时加速度大小: ', char(a_at_1), ' = ', num2str(double(a_at_1))])

disp(' ')

%% 7. 高阶导数
disp('7. 高阶导数')

% 示例12：高阶导数
f13 = sin(x);
disp(['f(x) = sin(x)'])
for n = 1:6
    dn_f13 = diff(f13, x, n);
    disp(['f^(', num2str(n), ')(x) = ', char(dn_f13)])
end

disp(' ')

% 示例13：莱布尼茨公式 (乘积的高阶导数)
u = x^2;
v = exp(x);
disp(['u = ', char(u), ', v = ', char(v)])
disp('乘积的高阶导数 (莱布尼茨公式):')
for n = 1:4
    dn_uv = diff(u*v, x, n);
    dn_uv_simplified = simplify(dn_uv);
    disp(['(uv)^(', num2str(n), ') = ', char(dn_uv_simplified)])
end

disp(' ')

%% 8. 数值验证
disp('8. 数值验证')

% 验证 sin(x) 在 x=0 处的导数
disp('验证 sin(x) 在 x=0 处的导数:')
x_val = 0;
h_values = [0.1, 0.01, 0.001, 0.0001];
disp('h值         | 差商 (f(x+h)-f(x))/h | 误差')
for h = h_values
    numerical_derivative = (sin(x_val + h) - sin(x_val)) / h;
    exact_derivative = cos(x_val);  % cos(0) = 1
    error = abs(numerical_derivative - exact_derivative);
    fprintf('%.4f      | %.10f           | %.2e\n', h, numerical_derivative, error);
end

disp(' ')


%% 10. 练习
disp('10. 练习')
disp('尝试计算以下导数：')
disp('1. f(x) = x^4 * e^x 的导数')
disp('2. g(x) = ln(x + sqrt(x^2 + 1)) 的导数')
disp('3. h(x) = sin(x) * cos(2x) 的二阶导数')
disp('4. 隐函数 x^2 + xy + y^2 = 1 的 dy/dx')
disp(' ')

disp('=== 导数计算示例结束 ===')