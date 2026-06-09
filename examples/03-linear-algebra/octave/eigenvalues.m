%% 第3章：线性代数 - 特征值与特征向量
% 本文件演示如何在Octave中计算特征值和特征向量
% 包括：特征多项式、对角化、物理应用等

%% 初始化符号计算包

fprintf('=== 特征值与特征向量示例 ===\n\n');

%% 1. 基本特征值计算
fprintf('--- 1. 基本特征值计算 ---\n');

% 定义矩阵
A = [4, -2; 1, 1];
fprintf('矩阵 A:\n');
disp(A);

% 计算特征值和特征向量
[V, D] = eig(A);

fprintf('特征向量矩阵 V:\n');
disp(V);
fprintf('特征值对角矩阵 D:\n');
disp(D);

% 提取特征值
eigenvalues = diag(D);
fprintf('特征值: %f, %f\n', eigenvalues(1), eigenvalues(2));

% 验证 A*v = lambda*v
fprintf('\n验证 A*v = lambda*v:\n');
for i = 1:length(eigenvalues)
    Av = A * V(:, i);
    lambda_v = eigenvalues(i) * V(:, i);
    fprintf('特征值 %d: ||A*v - lambda*v|| = %e\n', i, norm(Av - lambda_v));
end

%% 2. 特征多项式
fprintf('\n--- 2. 特征多项式 ---\n');

% 符号特征多项式
syms lambda
char_poly = det(A - lambda * eye(2));
fprintf('特征多项式 det(A - λI):\n');
disp(char_poly);

% 展开特征多项式
char_poly_expanded = expand(char_poly);
fprintf('展开后:\n');
disp(char_poly_expanded);

% 求解特征值
eigenvals = solve(char_poly == 0, lambda);
fprintf('特征多项式的根:\n');
disp(eigenvals);

%% 3. 矩阵的迹和行列式与特征值的关系
fprintf('\n--- 3. 迹和行列式与特征值的关系 ---\n');

trace_A = trace(A);
det_A = det(A);
sum_eigenvals = sum(eigenvalues);
prod_eigenvals = prod(eigenvalues);

fprintf('矩阵的迹: %f\n', trace_A);
fprintf('特征值之和: %f\n', sum_eigenvals);
fprintf('矩阵的行列式: %f\n', det_A);
fprintf('特征值之积: %f\n', prod_eigenvals);

%% 4. 对角化
fprintf('\n--- 4. 对角化 ---\n');

% 检查是否可对角化
if length(eigenvalues) == rank(V)
    fprintf('矩阵 A 可对角化\n');
    
    % 对角化: A = P * D * P^(-1)
    D_diag = diag(eigenvalues);
    P = V;
    A_reconstructed = P * D_diag * inv(P);
    
    fprintf('重构的矩阵 P*D*P^(-1):\n');
    disp(A_reconstructed);
    
    % 计算矩阵的幂
    n = 5;
    A_n = P * D_diag^n * inv(P);
    fprintf('A^%d (使用对角化):\n', n);
    disp(A_n);
    
    % 直接计算验证
    A_n_direct = A^n;
    fprintf('A^%d (直接计算):\n', n);
    disp(A_n_direct);
else
    fprintf('矩阵 A 不可对角化\n');
end

%% 5. 3x3 矩阵的特征值
fprintf('\n--- 5. 3x3 矩阵的特征值 ---\n');

B = [2, 1, 0; 0, 2, 0; 0, 0, 3];
fprintf('矩阵 B:\n');
disp(B);

[V_B, D_B] = eig(B);
fprintf('特征值:\n');
disp(diag(D_B));
fprintf('特征向量:\n');
disp(V_B);

%% 6. 对称矩阵的特征值
fprintf('\n--- 6. 对称矩阵的特征值 ---\n');

% 对称矩阵（如惯性张量、协方差矩阵）
S = [4, 2, 1; 2, 5, 3; 1, 3, 6];
fprintf('对称矩阵 S:\n');
disp(S);

% 验证对称性
fprintf('是否对称: %s\n', mat2str(isequal(S, S')));

% 对称矩阵的特征值都是实数
[V_S, D_S] = eig(S);
eigenvalues_S = diag(D_S);
fprintf('特征值（均为实数）:\n');
disp(eigenvalues_S);

% 对称矩阵的特征向量正交
fprintf('特征向量的正交性验证 (V^T * V):\n');
disp(V_S' * V_S);

%% 7. 物理应用：振动系统
fprintf('\n--- 7. 物理应用：耦合振动系统 ---\n');

% 双摆系统的小振动方程
% M * x'' + K * x = 0
% 假设 m1 = m2 = m, l1 = l2 = l, g 为重力加速度

syms m l g positive

% 质量矩阵
M = m * [2, 1; 1, 1];

% 刚度矩阵
K = m*g/l * [2, 0; 0, 1];

fprintf('质量矩阵 M:\n');
disp(M);
fprintf('刚度矩阵 K:\n');
disp(K);

% 广义特征值问题: K*v = omega^2 * M*v
% 转换为标准特征值问题: M^(-1)*K*v = omega^2*v

M_inv_K = inv(M) * K;
M_inv_K = simplify(M_inv_K);
fprintf('M^(-1)*K:\n');
disp(M_inv_K);

% 求解特征值（固有频率的平方）
[V_vib, D_vib] = eig(M_inv_K);
omega_sq = simplify(diag(D_vib));

fprintf('固有频率的平方 (ω²):\n');
disp(omega_sq);

% 固有频率
omega = sqrt(omega_sq);
fprintf('固有频率 (ω):\n');
disp(simplify(omega));

fprintf('振型矩阵:\n');
disp(simplify(V_vib));

%% 8. 稳定性分析
fprintf('\n--- 8. 稳定性分析 ---\n');

% 线性系统的稳定性：dx/dt = A*x
% 稳定条件：所有特征值的实部为负

A_stable = [-1, 2; -3, -4];
A_unstable = [1, 2; 3, 4];

fprintf('系统1 (应稳定):\n');
disp(A_stable);
eig1 = eig(A_stable);
fprintf('特征值: ');
fprintf('%.2f+%.2fi  ', [real(eig1), imag(eig1)]');
fprintf('\n最大实部: %.2f\n', max(real(eig1)));

fprintf('\n系统2 (应不稳定):\n');
disp(A_unstable);
eig2 = eig(A_unstable);
fprintf('特征值: ');
fprintf('%.2f+%.2fi  ', [real(eig2), imag(eig2)]');
fprintf('\n最大实部: %.2f\n', max(real(eig2)));

%% 9. 符号特征值计算
fprintf('\n--- 9. 符号特征值计算 ---\n');

% 2x2 符号矩阵
syms a b c d
S_sym = [a, b; c, d];
fprintf('符号矩阵:\n');
disp(S_sym);

% 符号特征多项式
char_poly_sym = det(S_sym - lambda * eye(2));
char_poly_sym = expand(char_poly_sym);
fprintf('符号特征多项式:\n');
disp(char_poly_sym);

% 使用迹和行列式表示
trace_S = a + d;
det_S = a*d - b*c;
fprintf('迹: %s\n', char(trace_S));
fprintf('行列式: %s\n', char(det_S));

%% 10. QR 迭代（概念演示）
fprintf('\n--- 10. QR 迭代（概念演示）---\n');

% QR 迭代是计算特征值的常用数值方法
A_qr = [4, 1, -2; 1, 2, 0; -2, 0, 3];
fprintf('矩阵 A:\n');
disp(A_qr);

% 进行几次 QR 迭代
n_iter = 10;
A_iter = A_qr;
fprintf('QR 迭代过程:\n');

for k = 1:n_iter
    [Q, R] = qr(A_iter);
    A_iter = R * Q;
end

fprintf('迭代 %d 次后的矩阵（接近上三角）:\n', n_iter);
disp(A_iter);

fprintf('对角元素（近似特征值）:\n');
disp(diag(A_iter));

fprintf('直接计算的特征值:\n');
disp(eig(A_qr));

fprintf('\n=== 特征值与特征向量示例完成 ===\n');
