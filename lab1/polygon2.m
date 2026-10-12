function [P, S] = polygon2(x, y)
    figure;
    plot(x, y);
    axis equal;

    dx = diff(x);
    dy = diff(y);

    P = sum(sqrt(dx .^ 2 + dy .^ 2));
    S = abs(sum(x(1:end-1) .* y(2:end) - y(1:end-1) .* x(2:end))) / 2;
end
