clear; clc; close all;
s = tf('s');

% A planta original
P = tf([-0.01288 -24.6 6115], [1 145.7 13600 43650]);

% O compensador de avanço projetado
K   = 200.40;
z_c = 3.4518;
p_c = 77.55;
G1 = K * (s + z_c) / (s + p_c);

%Compensador de atraso
z_at = 5.94;
p_at = 0.05;
G2 = (s + z_at)/(s + p_at);
L = G2 * G1 * P;

T = feedback(L, 1);

disp('Planta Original:');
P

% Resposta do sistema final
figure
step(T)
title('Resposta Final ao Degrau do Sistema com Compensador de Avanço')
ylabel('Amplitude')
xlabel('Tempo (segundos)')
grid on
legend('Sistema Controlado')

% Obtém informações detalhadas da resposta ao degrau
info = stepinfo(T); 

% Obtém o valor final para o erro estacionário
final_value = dcgain(T);

% Exibe apenas as informações solicitadas
fprintf('Sobressinal (Overshoot): %.2f%%\n', info.Overshoot);
fprintf('Tempo de acomodação (2%%): %.2f s\n', info.SettlingTime);
fprintf('Erro estacionário: %.4f\n', 1 - final_value);

% Coeficientes para esp32 com Ts = 0.035s
%const float b0 = 99.439;
%const float b1 = -168.82;
%const float b2 = 71.516;
%const float a1 = -0.846;
%const float a2 = -0.151;

%u[k] = 10.123*e[k] - 17.185*e[k - 1] + 7.28*e[k - 2] + 0.847*u[k - 1] +
%0.151*u[k -2] 

