clear all; clc;

params.sigma = 10.0;
params.r = 28.0;
params.b = 8/3;

y_state1 = [0.0; 0.0; 0.0];

eye_val = sqrt(params.b * (params.r - 1));
y_state2 = [eye_val; eye_val; params.r - 1];

tspan = [0 100];

[t1, y1] = Lorenz(y_state1, tspan, params, 1e-6, 1e-6);
[t2, y2] = Lorenz(y_state2, tspan, params, 1e-6, 1e-6);

figure;
subplot(1, 2, 1);
plot(t1, y1(:, 1), '-b'); hold on;
plot(t1, y1(:, 2), '-r'); hold on;
plot(t1, y1(:, 3), '-g');
xlabel('Time (t)');
ylabel('State');
legend('x', 'y', 'z');
title('State point (0,0,0)');
grid on;

subplot(1, 2, 2);
plot(t2, y2(:, 1), '-b'); hold on;
plot(t2, y2(:, 2), '-r'); hold on;
plot(t2, y2(:, 3), '-g');
xlabel('Time (t)');
ylabel('State');
legend('x', 'y', 'z');
title('State point in "eye"');
grid on;

