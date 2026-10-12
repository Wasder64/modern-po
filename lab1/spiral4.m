function result = spiral4 (startNum, turns)
  n = 2 * turns;
  result = zeros(n);

  value = startNum;
  top = 1;
  bottom = n;
  left = 1;
  right = n;

  while left <= right && top <= bottom
    for j = left:right
      result(top, j) = value;
      value = value + 1;
    endfor
    top = top + 1;

    for i = top:bottom
      result(i, right) = value;
     value = value + 1;
    endfor
    right = right - 1;

    if top <= bottom
      for j = right:-1:left
         result(bottom, j) = value;
         value = value + 1;
      endfor
      bottom = bottom - 1;
    endif

    if left <= right
      for i = bottom:-1:top
        result(i, left) = value;
        value = value + 1;
      endfor
      left = left + 1;
    endif
  endwhile
endfunction
