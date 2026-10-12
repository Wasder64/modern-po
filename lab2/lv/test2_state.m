clear all; clc;

params.alpha = 1.0;
params.beta = 0.02;
params.gamma = 0.4;
params.delta = 0.02;

y_state1 = [0; 0];
y_state2 = [params.gamma / params.delta; params.alpha / params.beta]
tspan = [0 50];

[t1, y1] = LV(y_state1, tspan, params, 1e-3, 1e-6);
[t2, y2] = LV(y_state2, tspan, params, 1e-3, 1e-6);

figure;
subplot(1, 2, 1);
plot(t1, y1(:, 1), '-b'); hold on;
plot(t1, y1(:, 2), '-r');
xlabel('Time (t)');
ylabel('Population');
legend('Prey (x)', 'Predator (y)');
title('Population in time (state point #1)');
grid on;

subplot(1, 2, 2);
plot(t2, y2(:, 1), '-b'); hold on;
plot(t2, y2(:, 2), '-r');
xlabel('Time (t)');
ylabel('Population');
legend('Prey (x)', 'Predator (y)');
title('Population in time (state point #2)');
grid on;

