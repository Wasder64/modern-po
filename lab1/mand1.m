function mand1 (R, max_n)
  x = -2.0 : 0.01 : 0.5;
  y = -1.2 : 0.01 : 1.2;
  [X, Y] = meshgrid(x, y);
  C = X + 1i * Y;

  Z = zeros(size(C));
  inside_mask = true(size(C));

  for k = 1:max_n
    Z(inside_mask) = Z(inside_mask) .^ 2 + C(inside_mask);
    inside_mask = inside_mask & ( abs(Z) < R );
  endfor

  figure;
  imshow(inside_mask, 'XData', x, 'YData', y);
  axis on;
  axis xy;
  xlabel('Re(c)');
  ylabel('Im(c)');
  title(['Mandelbrot (R = ', num2str(R), ', max\_n = ', num2str(max_n), ')']);
endfunction
