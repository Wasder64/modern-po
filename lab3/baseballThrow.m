function L = baseballThrow(v0, alpha_degrees, k)
  m = 0.145;
  g = 9.81;

  alpha_radian = alpha_degrees * pi / 180.0;
  Y0 = [
    0; 0;
    v0 * cos(alpha_radian);
    v0 * sin(alpha_radian);
  ];

  options = odeset('OutputFcn', @stop_when_y_negative);
  tspan = [0 1000];

  [t, Y] = ode45(@system, tspan, Y0, options);
  x_all = Y(:, 1);
  y_all = Y(:, 2);

  idx = find(y_all < 0, 1);

  x_positive = x_all(idx - 1);
  y_positive = y_all(idx - 1);

  x_negative = x_all(idx);
  y_negative = y_all(idx);

  % Linear interpolation
  L = x_positive - y_positive * (x_negative - x_positive) / (y_negative - y_positive);

  x_plot = [x_all(1:idx-1); L];
  y_plot = [y_all(1:idx-1); 0];

  figure;
  plot(x_plot, y_plot);
  hold on; grid on;
  plot(L, 0.0, 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
  plot(0.0, 0.0, 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r');

  xlabel('x');
  ylabel('y');
  axis equal;
  title(sprintf('L = %.3f', L));

  function dY = system(~, Y)
    Vx = Y(3);
    Vy = Y(4);
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
