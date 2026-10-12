% NOT OPEN PLEASE

clear all; clc;

params.mu = 5.0;

y_start = [5.0; 2.0];
tspan = [0 50];

[t1, y1] = VdP(y_start, tspan, params, 1e-3, 1e-2);
[t2, y2] = VdP(y_start, tspan, params, 1e-12, 1e-12);

dt1 = diff(t1); t_steps1 = t1(1:end-1);
dt2 = diff(t2); t_steps2 = t2(1:end-1);

figure;
semilogy(t_steps1, dt1, '-b'); hold on;
semilogy(t_steps2, dt2, '-r');
xlabel('Time (t)');
ylabel('Step size (dt)');
title('Step size compare');
legend('Low tol (1e-3)', 'High tol (1e-12)');
grid on;

fprintf('Tolerance = 1e-3  | Steps: %d\n', length(t1));
fprintf('Tolerance = 1e-3  | Mean step: %e\n\n', mean(dt1));

fprintf('Tolerance = 1e-12 | Steps: %d\n', length(t2));
fprintf('Tolerance = 1e-12 | Mean step:  %e\n\n', mean(dt2));

tol_vector = logspace(-3, -6, 4);
node_counts = zeros(size(tol_vector));

for i = 1 : length(tol_vector)
  [t_loop, ~] = VdP(y_start, tspan, params, tol_vector(i), tol_vector(i));
  node_counts(i) = length(t_loop);
endfor

figure();
loglog(tol_vector, node_counts);
grid on;
xlabel('RelTol (and AbsTol)');
ylabel('Nodes (N)');
title('N(RelTol) for Van der Pol');
