%% 第3章：线性代数 - 矩阵分解
% 本文件演示如何在Octave中进行矩阵分解
% 包括：LU分解、QR分解、SVD、Cholesky分解等

%% 初始化符号计算包
pkg load statistics;

fprintf('=== 矩阵分解示例 ===\n\n');

%% 1. LU 分解
fprintf('--- 1. LU 分解 ---\n');

% 定义矩阵
A = [2, 1, 1; 4, 3, 3; 8, 7, 9];
fprintf('矩阵 A:\n');
disp(A);

% LU 分解（带置换）
[L, U, P] = lu(A);

fprintf('下三角矩阵 L:\n');
disp(L);
fprintf('上三角矩阵 U:\n');
disp(U);
fprintf('置换矩阵 P:\n');
disp(P);

% 验证 A = P' * L * U
check_lu = P' * L * U;
fprintf('验证 P''*L*U = A:\n');
disp(check_lu);

% 使用 LU 分解求解线性方程组
b = [1; 2; 3];
fprintf('\n使用 LU 分解求解 Ax = b:\n');
fprintf('b = [%d; %d; %d]\n', b(1), b(2), b(3));

% 步骤1: 解 Ly = Pb
y = L \ (P * b);
fprintf('中间解 y (Ly = Pb):\n');
disp(y);

% 步骤2: 解 Ux = y
x_lu = U \ y;
fprintf('最终解 x (Ux = y):\n');
disp(x_lu);

% 验证
fprintf('验证 Ax = b:\n');
disp(A * x_lu);

%% 2. QR 分解
fprintf('\n--- 2. QR 分解 ---\n');

% 定义矩阵
B = [1, 1, 0; 1, 0, 1; 0, 1, 1];
fprintf('矩阵 B:\n');
disp(B);

% QR 分解
[Q, R] = qr(B);

fprintf('正交矩阵 Q:\n');
disp(Q);
fprintf('上三角矩阵 R:\n');
disp(R);

% 验证 B = Q * R
check_qr = Q * R;
fprintf('验证 Q*R = B:\n');
disp(check_qr);

% 验证 Q 的正交性
fprintf('验证 Q^T*Q = I:\n');
disp(Q' * Q);

% 使用 QR 分解求解最小二乘问题
fprintf('\n使用 QR 分解求解最小二乘问题:\n');

% 超定系统
A_over = [1, 1; 2, 1; 3, 1; 4, 1];
b_over = [2; 3; 5; 6];

[Q_o, R_o] = qr(A_over);

% 最小二乘解: x = R^(-1) * Q^T * b
x_qr = R_o(1:2, 1:2) \ (Q_o(:, 1:2)' * b_over);
fprintf('QR 分解最小二乘解:\n');
disp(x_qr);

% 与直接法比较
x_direct = A_over \ b_over;
fprintf('直接法最小二乘解:\n');
disp(x_direct);

%% 3. 奇异值分解 (SVD)
fprintf('\n--- 3. 奇异值分解 (SVD) ---\n');

% 定义矩阵
C = [1, 2; 3, 4; 5, 6];
fprintf('矩阵 C:\n');
disp(C);

% SVD 分解
[U, S, V] = svd(C);

fprintf('左奇异向量 U:\n');
disp(U);
fprintf('奇异值矩阵 S:\n');
disp(S);
fprintf('右奇异向量 V:\n');
disp(V);

% 提取奇异值
singular_values = diag(S);
fprintf('奇异值:\n');
disp(singular_values);

% 验证 C = U * S * V'
check_svd = U * S * V';
fprintf('验证 U*S*V'' = C:\n');
disp(check_svd);

% 计算矩阵的秩（非零奇异值的个数）
rank_C = sum(singular_values > 1e-10);
fprintf('矩阵的秩: %d\n', rank_C);

%% 4. 伪逆（使用 SVD）
fprintf('\n--- 4. 伪逆（使用 SVD）---\n');

% 计算伪逆
C_pinv = pinv(C);
fprintf('C 的伪逆:\n');
disp(C_pinv);

% 验证伪逆性质
fprintf('验证 C*C^+*C ≈ C:\n');
disp(C * C_pinv * C);

fprintf('验证 C^+*C*C^+ ≈ C^+:\n');
disp(C_pinv * C * C_pinv);

%% 5. Cholesky 分解
fprintf('\n--- 5. Cholesky 分解 ---\n');

% Cholesky 分解要求矩阵是对称正定的
D = [4, 2, 1; 2, 5, 3; 1, 3, 6];
fprintf('对称正定矩阵 D:\n');
disp(D);

% 检查是否正定
eigenvalues_D = eig(D);
fprintf('特征值: ');
fprintf('%.4f ', eigenvalues_D);
fprintf('\n');
fprintf('是否正定: %s\n', mat2str(all(eigenvalues_D > 0)));

% Cholesky 分解: D = L * L'
L_chol = chol(D, 'lower');
fprintf('Cholesky 因子 L (下三角):\n');
disp(L_chol);

% 验证 D = L * L'
check_chol = L_chol * L_chol';
fprintf('验证 L*L'' = D:\n');
disp(check_chol);

% 使用 Cholesky 分解求解线性方程组
b_chol = [1; 2; 3];

% 步骤1: 解 Ly = b
y_chol = L_chol \ b_chol;

% 步骤2: 解 L'x = y
x_chol = L_chol' \ y_chol;
fprintf('Cholesky 分解法求解结果:\n');
disp(x_chol);

%% 6. 特征分解（谱分解）
fprintf('\n--- 6. 特征分解（谱分解）---\n');

% 对称矩阵可以进行特征分解
E = [4, 2; 2, 3];
fprintf('对称矩阵 E:\n');
disp(E);

% 特征分解
[V_E, D_E] = eig(E);

fprintf('特征向量 V:\n');
disp(V_E);
fprintf('特征值对角矩阵 Λ:\n');
disp(D_E);

% 谱分解: E = V * Λ * V^T
E_spectral = V_E * D_E * V_E';
fprintf('验证 V*Λ*V^T = E:\n');
disp(E_spectral);

% 计算矩阵函数（如矩阵指数）
% f(A) = V * f(Λ) * V^T
fprintf('\n计算 E^(0.5) (矩阵平方根):\n');
D_sqrt = diag(sqrt(diag(D_E)));
E_sqrt = V_E * D_sqrt * V_E';
disp(E_sqrt);

% 验证 (E^0.5)^2 = E
fprintf('验证 (E^0.5)^2 = E:\n');
disp(E_sqrt * E_sqrt);

%% 7. Jordan 分解
fprintf('\n--- 7. Jordan 分解（概念演示）---\n');

% 不可对角化矩阵
F = [2, 1; 0, 2];
fprintf('不可对角化矩阵 F:\n');
disp(F);

% 特征值
eig_F = eig(F);
fprintf('特征值: %f (重根)\n', eig_F(1));

% 特征向量
[V_F, D_F] = eig(F);
fprintf('特征向量:\n');
disp(V_F);
fprintf('只有一个线性无关的特征向量，不可对角化\n');

%% 8. 物理应用：主成分分析 (PCA)
fprintf('\n--- 8. 物理应用：主成分分析 (PCA) ---\n');

% 生成示例数据
rng(42);  % 固定随机种子
n_samples = 100;

% 创建相关的二维数据
x = randn(n_samples, 1);
y = 0.5 * x + 0.3 * randn(n_samples, 1);
data = [x, y];

% 中心化数据
data_centered = data - mean(data);

% 计算协方差矩阵
cov_matrix = cov(data_centered);
fprintf('协方差矩阵:\n');
disp(cov_matrix);

% 特征分解
[coeff, score, latent] = pca(data_centered);

fprintf('主成分方向（特征向量）:\n');
disp(coeff);
fprintf('特征值（方差解释量）:\n');
disp(latent);
fprintf('方差解释比例:\n');
disp(latent / sum(latent));

%% 9. 矩阵分解的应用比较
fprintf('\n--- 9. 矩阵分解的应用比较 ---\n');

% 创建测试矩阵
G = [1, 2, 3; 4, 5, 6; 7, 8, 10];
b_test = [1; 2; 3];

fprintf('测试矩阵 G:\n');
disp(G);
fprintf('右端向量 b:\n');
disp(b_test);

% 方法1: LU 分解
[L_g, U_g, P_g] = lu(G);
x_lu = U_g \ (L_g \ (P_g * b_test));
fprintf('LU 分解解:\n');
disp(x_lu);

% 方法2: QR 分解
[Q_g, R_g] = qr(G);
x_qr = R_g \ (Q_g' * b_test);
fprintf('QR 分解解:\n');
disp(x_qr);

% 方法3: SVD
[U_g, S_g, V_g] = svd(G);
x_svd = V_g * (S_g \ (U_g' * b_test));
fprintf('SVD 解:\n');
disp(x_svd);

% 方法4: 直接法
x_direct = G \ b_test;
fprintf('直接法解:\n');
disp(x_direct);

% 比较结果
fprintf('\n各方法解的差异:\n');
fprintf('LU vs 直接: %e\n', norm(x_lu - x_direct));
fprintf('QR vs 直接: %e\n', norm(x_qr - x_direct));
fprintf('SVD vs 直接: %e\n', norm(x_svd - x_direct));

