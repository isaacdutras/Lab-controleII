clc, clear

s = tf('s');

%Teste com a ft de 1° ordem
%g = (0.46)/(s+3.3);

%Teste com a ft de 3° ordem
g = tf([-0.01288 -24.6 6115], [1 145.7 13600 43650]);

kc = 50.354;
z = 2.1;
p = 5.92;

c = kc*((s+z)/(s+p));

rlocus(g);

sys = feedback(c  * g, 1);
[wn, zeta] = damp(sys)

figure;
step(sys);
grid on;
sysd = c2d(c, 0.035, 'zoh')

% Obtém informações detalhadas da resposta ao degrau
info = stepinfo(sys); 

% Obtém o valor final para o erro estacionário
final_value = dcgain(sys);

% Exibe apenas as informações solicitadas
fprintf('Sobressinal (Overshoot): %.2f%%\n', info.Overshoot);
fprintf('Tempo de acomodação (2%%): %.2f s\n', info.SettlingTime);
fprintf('Erro estacionário: %.4f\n', 1 - final_value);

%Teste - Erro ainda muito alto
%kc = 50.354;
%z = 2.1;
%p = 5.92;
%ZOH: u[k]=0.8129u[k-1]+50.35e[k-1]-47.01e[k-1]