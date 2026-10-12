clear all; clc;

params.sigma = 10.0;
params.r = 28.0;
params.b = 8.0/3.0;

y_start = [1.0; 1.0; 1.0];
tspan = [0 30];

[t1, y1] = Lorenz(y_start, tspan, params, 1e-3, 1e-6);
[t2, y2] = Lorenz(y_start, tspan, params, 1e-12, 1e-12);

figure;
subplot(1, 2, 1);
plot(t1, y1(:, 1), '-b'); hold on;
plot(t1, y1(:, 2), '-r'); hold on;
plot(t1, y1(:, 3), '-g');
xlabel('Time (t)');
ylabel('State (x, y, z)');
legend('x', 'y', 'z');
title('State in time (Low tol)');
grid on;

subplot(1, 2, 2);
plot3(y1(:, 1), y1(:, 2), y1(:, 3));
xlabel('x');
ylabel('y');
zlabel('z');
title('Phase port. (Low tol)');
grid on;



figure;
subplot(1, 2, 1);
plot(t2, y2(:, 1), '-b'); hold on;
plot(t2, y2(:, 2), '-r'); hold on;
plot(t2, y2(:, 3), '-g');
xlabel('Time (t)');
ylabel('State (x, y, z)');
legend('x', 'y', 'z');
title('State in time (High tol)');
grid on;

subplot(1, 2, 2);
plot3(y2(:, 1), y2(:, 2), y2(:, 3));
xlabel('x');
ylabel('y');
zlabel('z');
title('Phase port. (High tol)');
grid on;

