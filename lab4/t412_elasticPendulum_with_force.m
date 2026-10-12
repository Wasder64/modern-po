function t412_elasticPendulum_with_force
  clear all; clc; close all;

  m = 1.0;
  k = 10.0;
  mu = 0.01;
  g = 9.81;
  w0 = sqrt(k / m);
  F0 = 5.0;
  w_force = 3.0;

  pendulum_with_force = @(t, x, c) [
    x(2);
    (-c / m) * x(2) - (k / m) * x(1) - mu * g * tanh(100 * x(2)) + (F0 / m) * cos(w_force * t);
  ];

  tspan = [0 25];
  x0 = [0.0; 0.0];
  c_value = 1.0;

  [t, x] = ode45(@(t, x) pendulum_with_force(t, x, c_value), tspan, x0);

  figure;

  subplot(1, 2, 1); hold on; grid on;
  plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 2);
  title('Limit cycle'); xlabel('x'); ylabel('dx / dt');

  w_range = linspace(0, 6, 501);
  c_low = 0.5;
  c_high = 2.5;

  A_high_Q = (F0/m) ./ sqrt((w0^2 - w_range.^2).^2 + (c_low/m .* w_range).^2);
  A_low_Q  = (F0/m) ./ sqrt((w0^2 - w_range.^2).^2 + (c_high/m .* w_range).^2);

  subplot(1, 2, 2); hold on; grid on;
  plot(w_range, A_high_Q, 'r', 'LineWidth', 1.5);
  plot(w_range, A_low_Q, 'g', 'LineWidth', 1.5);
  plot([w0, w0], [0.0, max(A_high_Q)], 'k--');
  title('Resonance'); xlabel('w range'); ylabel('Amplitude A');
  legend('High Q', 'Low Q', 'w0');
endfunction
