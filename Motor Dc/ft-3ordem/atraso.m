clc, clear

s = tf('s');

g = (-0.01288*s^2-24.6*s+6115)/(s^3+145.7*s^2+13600*s+43650);

rlocus(g);
figure;
step(g);
title("Sistema sem compensador");
pole(g)

kc = 60.2;
zc = 1.12;
pc = 0.01;

c = kc*(s + zc)/(s + pc);

sys = c*g;
figure;
rlocus(sys);
title("Sistema com compensador");

mf = feedback(sys, 1);

figure;
step(mf);
grid on;

% Obtém informações detalhadas da resposta ao degrau
info = stepinfo(mf); 

% Obtém o valor final para o erro estacionário
final_value = dcgain(mf);

% Exibe apenas as informações solicitadas
fprintf('Sobressinal (Overshoot): %.2f%%\n', info.Overshoot);
fprintf('Tempo de acomodação (2%%): %.2f s\n', info.SettlingTime);
fprintf('Erro estacionário: %.4f\n', 1 - final_value);

%Coeficientes esp32
%b0 = 61.37;
%b1 = -59.01;
%a1 = +0.999; 
%Equação: u[k] = b0*e[k] + b1*e[k - 1] - a1*u[k-1]
%u[k] = -61.37*e[k] - 59.01*e[k - 1] - 0.999*u[k - 1]