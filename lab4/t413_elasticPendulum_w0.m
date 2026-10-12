function t413_elasticPendulum_w0
  clear all; clc; close all;

  m = 1.0;
  k = 20.0;
  mu = 0.01;
  g = 9.81;
  c = 0.25;

  w0 = sqrt(k / m);
  dt_critical = 2 * sqrt(2) / w0;
  fprintf('w0 = %.2f\n', w0);
  fprintf('dt_critical = %.2f\n', dt_critical);

  pendulum = @(t, x, c_val, mu_val) [
    x(2);
    (-c_val / m) * x(2) - (k / m) * x(1) - mu_val * g * tanh(100 * x(2))
  ];

  figure;

  dt_list = [0.05, 0.7];
  colors = {'r', 'g'};

  for i = 1:length(dt_list)
    dt = dt_list(i);
    t = 0 : dt : 10;
    x = zeros(2, length(t));
    x(:, 1) = [2.0; 0.0];

    f = @(t_val, x_val) pendulum(t_val, x_val, c, mu);

    for n = 1 : length(t) - 1
      k1 = f(t(n), x(:, n));
      k2 = f(t(n) + dt/2, x(:, n) + (dt/2) * k1);
      k3 = f(t(n) + dt/2, x(:, n) + (dt/2) * k2);
      k4 = f(t(n) + dt, x(:, n) + dt * k3);
      x(:, n + 1) = x(:, n) + (dt / 6) * (k1 + 2*k2 + 2*k3 + k4);
    end

    subplot(1, 2, 1); hold on; grid on;
    plot(t, x(1, :), colors{i}, 'LineWidth', 1.5, 'DisplayName', sprintf('dt = %.2f', dt));

    subplot(1, 2, 2); hold on; grid on;
    plot(x(1, :), x(2, :), colors{i}, 'LineWidth', 1.5, 'DisplayName', sprintf('dt = %.2f', dt));
  end

  subplot(1, 2, 1);
  title('x(t) trajectory for dt range');
  xlabel('t'); ylabel('x');
  ylim([-4, 4]);
  legend();

  subplot(1, 2, 2);
  title('Phase portrait');
  xlabel('x'); ylabel('dx/dt');
  ylim([-15, 15]); xlim([-5, 5]);
  legend();



  tspan = [0, 30];
  x0 = [2.0; 0.0];
  opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-8);
  [t_sim, y_sim] = ode45(@(t, x) pendulum(t, x, 0.0, 0.0), tspan, x0, opts);

  coord = y_sim(:, 1);

  peak_idx = find(coord(2:end-1) > coord(1:end-2) & coord(2:end-1) > coord(3:end)) + 1;
  t_peaks = t_sim(peak_idx);

  t_clean = t_peaks(3:end);
  num_periods = 10;
  T_num = (t_clean(num_periods + 1) - t_clean(1)) / num_periods;
  w0_num = 2 * pi / T_num;

  fprintf('Analytical w0 = %.10f\n', w0);
  fprintf('Numeric w0 = %.10f\n', w0_num);
end
