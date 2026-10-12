function [t, y] = Lorenz (y0, tspan, params, reltol, abstol)
  dydt = @(t, y) [
    params.sigma * (y(2) - y(1));
    y(1) * (params.r - y(3)) - y(2);
    y(1) * y(2) - params.b * y(3);
  ];

  options = odeset('RelTol', reltol, 'AbsTol', abstol);
  [t, y] = ode45(dydt, tspan, y0, options);
endfunction
