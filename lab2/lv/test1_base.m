clear all; clc;

params.alpha = 1.0;
params.beta = 0.02;
params.gamma = 0.4;
params.delta = 0.02;

y_start = [10; 15];
tspan = [0 50];

[t1, y1] = LV(y_start, tspan, params, 1e-3, 1e-6);
[t2, y2] = LV(y_start, tspan, params, 1e-12, 1e-6);

figure;
subplot(1, 2, 1);
plot(t1, y1(:, 1), '-b'); hold on;
plot(t1, y1(:, 2), '-r');
xlabel('Time (t)');
ylabel('Population');
legend('Prey (x)', 'Predator (y)');
title('Population in time (Low tol)');
grid on;

subplot(1, 2, 2);
plot(y1(:, 1), y1(:, 2));
xlabel('Prey (x)');
ylabel('Predator (y)');
title('Phase portrait (Low tol)');
grid on;



figure;
subplot(1, 2, 1);
plot(t2, y2(:, 1), '-b'); hold on;
plot(t2, y2(:, 2), '-r');
xlabel('Time (t)');
ylabel('Population');
legend('Prey (x)', 'Predator (y)');
title('Population in time (High tol)');
grid on;

subplot(1, 2, 2);
plot(y2(:, 1), y2(:, 2));
xlabel('Prey (x)');
ylabel('Predator (y)');
title('Phase portrait (High tol)');
grid on;
