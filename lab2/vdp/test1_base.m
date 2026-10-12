clear all; clc;

params.mu = 5;

y_start = [1.0; 2.0];
tspan = [0 50];

[t1, y1] = VdP(y_start, tspan, params, 1e-3, 1e-6);
[t2, y2] = VdP(y_start, tspan, params, 1e-12, 1e-6);

figure;
subplot(1, 3, 1);
plot(t1, y1(:, 1), '-b');
xlabel('Time (t)');
ylabel('Position (x)');
title('State in time (Low tol)');
grid on;

subplot(1, 3, 2);
plot(t1, y1(:, 2), '-r');
xlabel('Time (t)');
ylabel('Velocity (y)');
title('State in time (Low tol)');
grid on;

subplot(1, 3, 3);
plot(y1(:, 1), y1(:, 2));
xlabel('Position (x)');
ylabel('Velocity (y)');
title('Phase portrait (Low tol)');
grid on;



figure;
subplot(1, 3, 1);
plot(t2, y2(:, 1), '-b');
xlabel('Time (t)');
ylabel('Position (x)');
title('State in time (High tol)');
grid on;

subplot(1, 3, 2);
plot(t2, y2(:, 2), '-r');
xlabel('Time (t)');
ylabel('Velocity (y)');
title('State in time (High tol)');
grid on;

subplot(1, 3, 3);
plot(y2(:, 1), y2(:, 2));
xlabel('Position (x)');
ylabel('Velocity (y)');
title('Phase portrait (High tol)');
grid on;

