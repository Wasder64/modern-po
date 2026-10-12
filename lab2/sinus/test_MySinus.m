clear all; clc;

x1 = -100 : 0.01 : 3;
[y1, k1] = MySinus(x1);
sinus1 = sin(x1);

figure;
plot(x1, k1);
grid on;
title('Iteration');
xlabel('x');
ylabel('k');

figure;
plot(x1, y1, 'r-'); hold on;
plot(x1, sinus1, 'b-');
title('Sinus comparation');
xlabel('x');
ylabel('y');
legend('MySin', 'Def Sin');

