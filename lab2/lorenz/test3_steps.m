clear all; clc;

params.sigma = 10.0;
params.r = 28.0;
params.b = 8/3;

y_start = [1.0; 1.0; 1.0];
tspan = [0 30];

[t1, y1] = Lorenz(y_start, tspan, params, 1e-3, 1e-6);
[t2, y2] = Lorenz(y_start, tspan, params, 1e-12, 1e-12);

dt1 = diff(t1); t_steps1 = t1(1:end-1);
dt2 = diff(t2); t_steps2 = t2(1:end-1);

figure;
semilogy(t_steps1, dt1, '-b'); hold on;
semilogy(t_steps2, dt2, '-r');
xlabel('Time (t)');
ylabel('Step size (dt)');
title('Step size compar.');
legend('Low Tol (1e-3)', 'High Tol (1e-12)');
grid on;

fprintf('Tolerance = 1e-3  | Steps: %d\n', length(t1));
fprintf('Tolerance = 1e-3  | Mean step: %e\n\n', mean(dt1));

fprintf('Tolerance = 1e-12 | Steps: %d\n', length(t2));
fprintf('Tolerance = 1e-12 | Mean step:  %e\n\n', mean(dt2));

tol_vector = logspace(-3, -12, 10);
node_counts = zeros(size(tol_vector));

for i = 1 : length(tol_vector)
  [t_loop, ~] = Lorenz(y_start, tspan, params, tol_vector(i), tol_vector(i));
  node_counts(i) = length(t_loop);
endfor

figure;
loglog(tol_vector, node_counts);
grid on;
xlabel('RelTol');
ylabel('Nodes (N)');
title('N(RelTol)');

