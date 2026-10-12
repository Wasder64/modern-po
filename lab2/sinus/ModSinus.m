function [y, k] = ModSinus (x)
  correct_x = mod(x + pi, 2 * pi) - pi;
  [y, k] = MySinus(correct_x);
endfunction
