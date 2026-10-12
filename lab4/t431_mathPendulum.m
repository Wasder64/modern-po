function t431_mathPendulum
  clear all; clc; close all;

  g = 9.81;
  l = 1.0;
  w0 = sqrt(g / l);
  T0 = 2 * pi / w0;

  fprintf('Theoretical period T0 = %.2f\n\n', T0);

  N = 25;
  alpha_grid = linspace(0.1, 3.0, N);
  T_simulated = zeros(size(alpha_grid));

  mathPendulum = @(t, phi, w0) [
    phi(2);
    - w0 ^ 2 * sin(phi(1))
  ];

  options = odeset('MaxStep', 0.1);

  for i = 1:N
    alpha = alpha_grid(i);
    phi0 = [alpha; 0.0];
    tspan = [0 75];

    [t, phi_solution] = ode45(@(t, phi) mathPendulum(t, phi, w0), tspan, phi0, options);
    phi = phi_solution(:, 1);

    zero_cross_idx = find(phi(1:end-1) .* phi(2:end) <= 0);
    T_simulated(i) = t(zero_cross_idx(3)) - t(zero_cross_idx(1));
  endfor

  relative = (T_simulated - T0) / T0;

  idx_1pct = find(relative >= 0.01, 1, 'first');
  alpha_1pct = (alpha_grid(idx_1pct) + alpha_grid(idx_1pct - 1)) / 2.0;

  idx_10pct = find(relative >= 0.10, 1, 'first');
  alpha_10pct = (alpha_grid(idx_10pct) + alpha_grid(idx_10pct - 1)) / 2.0;

  fprintf('Make sure linear model is right:\n');
  fprintf('1%% deviation: alpha = %.3f rad (%.1f deg)\n', alpha_1pct, rad2deg(alpha_1pct));
  fprintf('10%% deviation: alpha = %.3f rad (%.1f deg)\n\n', alpha_10pct, rad2deg(alpha_10pct));

  figure; hold on; grid on;
  xlim([0.0, pi]);
  ylim([0.0, 3 * T0]);
  plot(alpha_grid, T_simulated, 'LineWidth', 1.5, 'DisplayName', 'T numeric');
  plot([0, pi], [T0, T0], 'g-', 'LineWidth', 1.5, 'DisplayName', 'T0 school');
  plot([alpha_1pct, alpha_1pct], [T0, 3 * T0], 'r--', 'DisplayName', '1% deviation');
  plot([alpha_10pct, alpha_10pct], [T0, 3 * T0], 'k--', 'DisplayName', '10% deviation');
  xlabel('alpha'); ylabel('T');
  legend('FontSize', 12);

  figure; hold on; grid on;

  osc_angles = [-3.2, 0.5, 1.5, 3.0, 3.2];
  for alpha0 = osc_angles
    [~, phi] = ode45(@(t, phi) mathPendulum(t, phi, w0), linspace(0, 10, 201), [alpha0; 0.0]);
    plot(phi(:, 1), phi(:, 2), 'b.');
  endfor

  rot_velocities = [2.1, 2.5, 3.0] * w0;
  for om0 = rot_velocities
    [~, phi_pos] = ode45(@(t, phi) mathPendulum(t, phi, w0), linspace(0, 10, 201), [0; om0]);
    plot(phi_pos(:, 1), phi_pos(:, 2), 'r.');

    [~, phi_neg] = ode45(@(t, phi) mathPendulum(t, phi, w0), linspace(0, 10, 201), [0; -om0]);
    plot(phi_neg(:, 1), phi_neg(:, 2), 'g.');
    xlim([-3 * pi, 3 * pi]);
  endfor

  xlabel('phi'); ylabel('d phi / dt'); title('Phase portrait');
endfunction

