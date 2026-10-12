clear all; clc;

params.alpha = 1.0;
params.beta = 0.02;
params.gamma = 0.4;
params.delta = 0.02;

y_start = [10; 15];
tspan = [0 50];

[t1, y1] = LV(y_start, tspan, params, 1e-3, 1e-2);
[t2, y2] = LV(y_start, tspan, params, 1e-12, 1e-12);

dt1 = diff(t1); t_steps1 = t1(1:end-1);
dt2 = diff(t2); t_steps2 = t2(1:end-1);

figure;
semilogy(t_steps1, dt1, '-b'); hold on;
semilogy(t_steps2, dt2, '-r');
xlabel('Time (t)');
ylabel('Step size (dt)');
title('Step size compare');
legend('Low Tol (1e-2)', 'High Tol (1e-12)');
grid on;

fprintf('Tolerance = 1e-2 | Steps: %d\n', length(t1));
fprintf('Tolerance = 1e-2 | Mean step: %e\n\n', mean(dt1));

fprintf('Tolerance = 1e-12 | Steps: %d\n', length(t2));
fprintf('Tolerance = 1e-12 | Mean step:  %e\n\n', mean(dt2));

tol_vector = logspace(-3, -12, 10);
node_counts = zeros(size(tol_vector));

for i = 1 : length(tol_vector)
  [t_loop, ~] = LV(y_start, tspan, params, tol_vector(i), tol_vector(i));
  node_counts(i) = length(t_loop);
endfor

figure();
loglog(tol_vector, node_counts);
grid on;
xlabel('RelTol');
ylabel('Nodes (N)');
title('N(RelTol)');

