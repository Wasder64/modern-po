function [t, y] = LV (y0, tspan, params, reltol, abstol)
  dydt = @(t, y) [
    (params.alpha - params.beta * y(2)) * y(1);
    (-params.gamma + params.delta * y(1)) * y(2)
  ];

  options = odeset('RelTol', reltol, 'AbsTol', abstol);
  [t, y] = ode45(dydt, tspan, y0, options);
endfunction
