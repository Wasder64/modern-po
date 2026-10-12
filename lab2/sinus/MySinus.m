function [y, k] = MySinus (x)
  sum = x;
  adding = x;

  k = ones(size(x));
  mask = abs(adding) > 0;

  n = 1;
  while any(mask)
    adding = adding .* (-x .^ 2) / (2 * n * (2 * n + 1));
    new_sum = sum + adding;

    mask(abs(new_sum - sum) == 0) = false;
    k(mask) = k(mask) + 1;

    sum = new_sum;
    n = n + 1;
  endwhile
  y = sum;
endfunction
