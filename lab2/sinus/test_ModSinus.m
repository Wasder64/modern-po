clear all; clc;

x1 = -4 * pi : 0.01 : 4 * pi;
[y1, k1] = ModSinus(x1);
sinus1 = sin(x1);

figure;
plot(x1, y1);
grid on;
title('Iteration');
xlabel('x');
ylabel('k');
