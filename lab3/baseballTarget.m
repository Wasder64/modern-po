function [alpha1, iter1, alpha2, iter2] = baseballTarget (v0, k, L_target, deltaL)
  m = 0.145;
  g = 9.81;

  max_L = 0.0;
  optimal_alpha = 0.0;

  for a = 1 : 1 : 89
    [L, ~, ~] = get_trajectory(a);
    if L > max_L
      max_L = L;
      optimal_alpha = a;
    endif
  endfor

  fprintf('Max L=%.3f with alpha=%.2f\n', max_L, optimal_alpha);
  if L_target > max_L
    error('Target is too far');
  endif

  figure;
  hold on; grid on;

  plot([L_target, L_target], [0.0, max_L / 4], 'k-', 'LineWidth', 2);
  plot(L_target, 0.0, 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r');

  xlabel('x');
  ylabel('y');
  axis equal;

  function [alpha_result, iters, x_final, y_final] = dihotomia(a_min, a_max, is_increasing, color_str)
    iters = 0;
    h_line = plot(NaN, NaN, color_str, 'LineWidth', 1.5);

    while true
      iters = iters + 1;
      mid_alpha = (a_min + a_max) / 2.0;
      [L_mid, X, Y] = get_trajectory(mid_alpha);
      set(h_line, 'XData', X, 'YData', Y);
      title(sprintf('Search (alpha=%.2f, Miss=%.3f)', mid_alpha, abs(L_target - L_mid)));
      drawnow;
      pause(0.5);

      if abs(L_target - L_mid) <= deltaL
        alpha_result = mid_alpha;
        x_final = X;
        y_final = Y;
        break;
      endif

      if is_increasing
        if L_mid < L_target
          a_min = mid_alpha;
        else
          a_max = mid_alpha;
        endif
      else
        if L_mid < L_target
          a_max = mid_alpha;
        else
          a_min = mid_alpha;
        endif
      endif
    endwhile

    delete(h_line);
  endfunction

  [alpha1, iter1, X1, Y1] = dihotomia(0.1, optimal_alpha, true, 'b--');
  plot(X1, Y1, 'b-', 'LineWidth', 2);

  [alpha2, iter2, X2, Y2] = dihotomia(optimal_alpha, 89.9, false, 'g--');
  plot(X2, Y2, 'g-', 'LineWidth', 2);

  title(sprintf('Traj1: alpha1=%.2f, iter1=%d | Traj2: alpha2=%.2f, iter2=%d', alpha1, iter1, alpha2, iter2));
  hold off;

  function [L_exact, x_plot, y_plot] = get_trajectory(alpha_degrees)
    alpha_radian = alpha_degrees * pi / 180.0;
    Y0 = [
      0; 0;
      v0 * cos(alpha_radian);
      v0 * sin(alpha_radian);
    ];

    options = odeset('OutputFcn', @stop_when_y_negative);
    tspan = [0 1000];

    [~, Y_out] = ode45(@system, tspan, Y0, options);

    x_all = Y_out(:, 1);
    y_all = Y_out(:, 2);

    idx = find(y_all < 0, 1);

    x_positive = x_all(idx - 1);
    y_positive = y_all(idx - 1);

    x_negative = x_all(idx);
    y_negative = y_all(idx);

    L_exact = x_positive - y_positive * (x_negative - x_positive) / (y_negative - y_positive);

    x_plot = [x_all(1:idx-1); L_exact];
    y_plot = [y_all(1:idx-1); 0];
  endfunction

  function dY = system(~, Y_val)
    Vx = Y_val(3);
    Vy = Y_val(4);
    V = sqrt(Vx ^ 2 + Vy ^ 2);
    dY = [Vx; Vy; -(k/m) * V * Vx; -g - (k/m) * V * Vy];
  endfunction

  function status = stop_when_y_negative(~, Y_val, flag)
    status = 0;
    if isempty(flag) && ~isempty(Y_val)
      if any(Y_val(2, :) < 0)
        status = 1;
      endif
    endif
  endfunction
endfunction
