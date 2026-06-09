% limits.m - 极限计算示例
% 本文件演示如何使用 Octave 符号计算包计算各种类型的极限
% 确保已安装并加载符号计算包

% 加载符号计算包

% 定义符号变量
syms x

disp('=== 极限计算示例 ===')
disp(' ')

%% 1. 基本极限
disp('1. 基本极限计算')

% 示例1：sin(x)/x 在 x->0 时的极限
f1 = sin(x)/x;
lim1 = limit(f1, x, 0);
disp(['lim(sin(x)/x, x->0) = ', char(lim1)])

% 示例2：(1+1/x)^x 在 x->inf 时的极限（自然对数的底 e）
f2 = (1 + 1/x)^x;
lim2 = limit(f2, x, inf);
disp(['lim((1+1/x)^x, x->inf) = ', char(lim2)])

% 示例3：多项式极限
f3 = (x^2 - 1)/(x - 1);
lim3 = limit(f3, x, 1);
disp(['lim((x^2-1)/(x-1), x->1) = ', char(lim3)])

disp(' ')

%% 2. 单侧极限
disp('2. 单侧极限计算')

% 示例4：右极限
f4 = 1/x;
lim4_right = limit(f4, x, 0, 'right');
lim4_left = limit(f4, x, 0, 'left');
disp(['lim(1/x, x->0+) = ', char(lim4_right)])
disp(['lim(1/x, x->0-) = ', char(lim4_left)])

% 示例5：绝对值函数在 x=0 处的极限
f5 = abs(x)/x;
lim5_right = limit(f5, x, 0, 'right');
lim5_left = limit(f5, x, 0, 'left');
disp(['lim(|x|/x, x->0+) = ', char(lim5_right)])
disp(['lim(|x|/x, x->0-) = ', char(lim5_left)])

disp(' ')

%% 3. 无穷极限
disp('3. 无穷极限')

% 示例6：无穷远处的极限
f6 = (3*x^2 + 2*x - 1)/(x^2 + 5);
lim6 = limit(f6, x, inf);
disp(['lim((3x^2+2x-1)/(x^2+5), x->inf) = ', char(lim6)])

% 示例7：指数函数在无穷远处的极限
f7 = exp(-x);
lim7 = limit(f7, x, inf);
disp(['lim(e^(-x), x->inf) = ', char(lim7)])

% 示例8：对数函数在无穷远处的极限
f8 = log(x)/x;
lim8 = limit(f8, x, inf);
disp(['lim(log(x)/x, x->inf) = ', char(lim8)])

disp(' ')

%% 4. 物理应用示例：瞬时速度
disp('4. 物理应用示例：瞬时速度')

syms t dt

% 位置函数 s(t) = t^2 + 2*t（米）
s = t^2 + 2*t;

% 使用导数定义计算瞬时速度
v = limit((subs(s, t, t+dt) - s)/dt, dt, 0);
disp(['位置函数 s(t) = ', char(s)])
disp(['瞬时速度 v(t) = ', char(v)])

% 计算 t=3 秒时的速度
v_at_3 = subs(v, t, 3);
disp(['v(3) = ', char(v_at_3), ' m/s'])

disp(' ')

%% 5. 数值验证
disp('5. 数值验证')

% 验证 sin(x)/x 在 x->0 时的极限
x_values = [0.1, 0.01, 0.001, 0.0001];
disp('验证 lim(sin(x)/x, x->0) = 1')
disp('x值         | sin(x)/x     | 误差')
for x_val = x_values
    approx = sin(x_val)/x_val;
    error = abs(approx - 1);
    fprintf('%.4f      | %.10f | %.2e\n', x_val, approx, error);
end

disp(' ')


%% 7. 练习
disp('7. 练习')
disp('尝试计算以下极限：')
disp('1. lim(x->0) (e^x - 1)/x')
disp('2. lim(x->inf) (1 + 2/x)^x')
disp('3. lim(x->1) (x^3 - 1)/(x - 1)')
disp('4. lim(x->0+) x*ln(x)')
disp(' ')

disp('=== 极限计算示例结束 ===')