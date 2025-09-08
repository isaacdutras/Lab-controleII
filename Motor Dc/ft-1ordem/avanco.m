clc, clear

s = tf('s');

g = (0.46)/(s+3.3);

kc = 8.56;
z = 6.5;
p = 7.2;

c = kc*((s+z)/(s+p));

rlocus(g);

sys = feedback(c  * g, 1);
[wn, zeta] = damp(sys)

figure;
step(sys);
grid on;

% Obtém informações detalhadas da resposta ao degrau
info = stepinfo(sys); 

% Obtém o valor final para o erro estacionário
final_value = dcgain(sys);

% Exibe apenas as informações solicitadas
fprintf('Sobressinal (Overshoot): %.2f%%\n', info.Overshoot);
fprintf('Tempo de acomodação (2%%): %.2f s\n', info.SettlingTime);
fprintf('Erro estacionário: %.4f\n', 1 - final_value);