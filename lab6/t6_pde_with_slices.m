function t6_pde_with_slices
  clear all; clc; close all;

  L = 10;
  Nx = 200; Ny = 200;
  x = linspace(0, L, Nx); h = x(2) - x(1);
  y = linspace(0, L, Ny);

  [X, Y] = meshgrid(x, y);

  c = 1.0;
  gamma_critical = 1 / sqrt(2);
  gamma = 0.9 * gamma_critical;
  tau = h * gamma / c;
  Nt = 300;

  pulse_period = 1.0;

  resultTime = Nt * tau;
  fprintf('Result time = %.2f\n', resultTime);

  wall_mask = false(Ny, Nx);
  wall_x_index = round(Nx / 3);
  wall_mask(:, wall_x_index:wall_x_index+1) = true;

  gap_width = round(Ny * 0.04);
  gap_y_index1 = round(Ny * 0.35);
  gap_y_index2 = round(Ny * 0.65);
  wall_mask(gap_y_index1-gap_width : gap_y_index1+gap_width, wall_x_index:wall_x_index+1) = false;
  wall_mask(gap_y_index2-gap_width : gap_y_index2+gap_width, wall_x_index:wall_x_index+1) = false;

  source_profile = sin(pi * linspace(0, 1, Ny))';

  u_prev = zeros(Ny, Nx);
  u_curr = zeros(Ny, Nx);
  u_next = zeros(Ny, Nx);

  u_next(2:end-1, 2:end-1) = 0.5 * (gamma ^ 2 * (u_curr(2:end-1, 3:end) + u_curr(2:end-1, 1:end-2) + ...
    u_curr(3:end, 2:end-1) + u_curr(1:end-2, 2:end-1)) + ...
    2 * (1 - 2 * gamma ^ 2) * u_curr(2:end-1, 2:end-1));

  t_time = 1 * tau;
  if t_time <= pulse_period
    gen_val = 0.75 * (sin(pi * (t_time / pulse_period))) ^ 2;
  else
    gen_val = 0;
  endif

  u_next(1, :) = 0; u_next(end, :) = 0; u_next(:, end) = 0;
  u_next(:, 1) = source_profile * gen_val;
  u_next(wall_mask) = 0;

  u_prev = u_curr;
  u_curr = u_next;

  figure;
  for t = 2:Nt
    u_next(2:end-1, 2:end-1) = (gamma ^ 2 * (u_curr(2:end-1, 3:end) + u_curr(2:end-1, 1:end-2) + ...
      u_curr(3:end, 2:end-1) + u_curr(1:end-2, 2:end-1)) + ...
      2 * (1 - 2 * gamma ^ 2) * u_curr(2:end-1, 2:end-1) - u_prev(2:end-1, 2:end-1));

    t_time = t * tau;
    if t_time <= pulse_period
      gen_val = 0.75 * (sin(pi * (t_time / pulse_period))) ^ 2;
    else
      gen_val = 0;
    endif

    u_next(1, :) = 0; u_next(end, :) = 0; u_next(:, end) = 0;
    u_next(:, 1) = source_profile * gen_val;
    u_next(wall_mask) = 0;

    u_prev = u_curr;
    u_curr = u_next;

    if mod(t, 5) == 0
      subplot(1, 2, 1);
      surf(X, Y, u_curr, 'EdgeColor', 'none');
      colormap(jet);
      shading interp;
      zlim([-1.0, 1.0]);
      caxis([-0.5, 0.5]);
      view(-35, 50);
      xlabel('X'); ylabel('Y'); zlabel('U');
      title(sprintf('3D graph. | t = %.2f с', t_time));

      subplot(1, 2, 2);
      display_matrix = u_curr;
      display_matrix(wall_mask) = NaN;

      imagesc(x, y, display_matrix);
      set(gca, 'YDir', 'normal');
      colormap(jet);
      caxis([-0.5, 0.5]);
      axis equal tight;
      xlabel('X'); ylabel('Y');
      title('2D graph.');

      drawnow;
    endif
  endfor
endfunction
