clear all; clc;

params.mu = 5;

y_state = [0; 0];
tspan = [0 50];

[t1, y1] = VdP(y_state, tspan, params, 1e-3, 1e-6);

figure;
subplot(1, 2, 1);
plot(t1, y1(:, 1), '-b');
xlabel('Time (t)');
ylabel('Position (x)');
grid on;

subplot(1, 2, 2);
plot(t1, y1(:, 2), '-r');
xlabel('Time (t)');
ylabel('Velocity (y)');
grid on;

