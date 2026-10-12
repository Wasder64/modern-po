function t441_mathPendulum_with_friction
  clear all; clc; close all;

  g = 9.81;
  l = 1.0;
  w0 = sqrt(g / l);
  T0 = 2 * pi / w0;

  gamma = 0.1;

  fprintf('Theoretical period T0 = %.2f\n\n', T0);

  mathPendulum = @(t, phi, w0) [
    phi(2);
    - w0 ^ 2 * sin(phi(1)) - gamma * phi(2)
  ];

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

