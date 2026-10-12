function t411_elasticPendulum
  clear all; clc; close all;

  m = 1.0;
  k = 10.0;
  mu = 0.01;
  g = 9.81;
  w0 = sqrt(k / m);

  c_crit = 1.98 * sqrt(k * m);
  c_weak = c_crit * 0.02;
  c_strong = c_crit * 2.5;

  beta_weak = c_weak / (2 * m);
  Q_weak = w0 / (2 * beta_weak);
  fprintf('Q-factor with weak damping = %.2f\n', Q_weak);

  tspan = [0 25];
  x0 = [2.0; 0.0];

  pendulum = @(t, x, c) [
    x(2);
    (-c / m) * x(2) - (k / m) * x(1) - mu * g * tanh(100 * x(2));
  ];

  [t_weak, y_weak] = ode45(@(t, x) pendulum(t, x, c_weak), tspan, x0);
  [t_crit, y_crit] = ode45(@(t, x) pendulum(t, x, c_crit), tspan, x0);
  [t_strong, y_strong] = ode45(@(t, x) pendulum(t, x, c_strong), tspan, x0);
  disp(min(y_crit(:, 1)));
  figure;

  subplot(1, 2, 1); hold on; grid on;
  plot(t_weak, y_weak(:, 1), 'r', 'LineWidth', 1.5);
  plot(t_crit, y_crit(:, 1), 'g', 'LineWidth', 1.5);
  plot(t_strong, y_strong(:, 1), 'b', 'LineWidth', 1.5);
  title('x(t) plot'); xlabel('t'); ylabel('x'); axis tight;
  legend('Weak', 'Critical', 'Strong');

  subplot(1, 2, 2); hold on; grid on;
  plot(y_weak(:, 1), y_weak(:, 2), 'r', 'LineWidth', 1.5);
  plot(y_crit(:, 1), y_crit(:, 2), 'g', 'LineWidth', 1.5);
  plot(y_strong(:, 1), y_strong(:, 2), 'b', 'LineWidth', 1.5);
  title('Phase portrait'); xlabel('x'); ylabel('dx / dt'); axis tight;
  legend('Weak', 'Critical', 'Strong');
endfunction
