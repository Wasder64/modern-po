function weier3(N)
  x = linspace(-1, 1, 1000);

  figure;

  a_fixed = 3;
  b_vals = linspace(1/a_fixed, 0.95, 60);

  for b_cur = b_vals
    w = zeros(size(x));
    for n = 0:(N - 1)
      w = w + (b_cur^n) * cos((a_fixed^n) * pi * x);
    end

    plot(x, w, 'b-');
    grid on;
    xlabel('x');
    ylabel('y');
    xlim([-1, 1]);
    ylim([-3, 3]);
    title(sprintf('a = %.1f (fixed), b = %.3f', a_fixed, b_cur));
    drawnow;
    pause(0.01);
  end

  pause(1.0);

  b_fixed = 0.5;
  a_vals = linspace(2, 11, 60);

  for a_cur = a_vals
    w = zeros(size(x));
    for n = 0:(N - 1)
      w = w + (b_fixed^n) * cos((a_cur^n) * pi * x);
    end

    plot(x, w, 'r-');
    grid on;
    xlabel('x');
    ylabel('y');
    xlim([-1, 1]);
    ylim([-3, 3]);
    title(sprintf('a = %.2f, b = %.2f (fixed)', a_cur, b_fixed));
    drawnow;
    pause(0.01);
  end
end
