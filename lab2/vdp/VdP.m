function [t, y] = VdP (y0, tspan, params, reltol, abstol)
  dydt = @(t, y) [
    y(2);
    params.mu * (1 - y(1) ^ 2) * y(2) - y(1);
  ];

  options = odeset('RelTol', reltol, 'AbsTol', abstol);
  [t, y] = ode23s(dydt, tspan, y0, options);
endfunction
