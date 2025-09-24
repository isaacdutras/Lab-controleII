clear; clc; close all;

s = tf('s');
G = 0.46 / (s + 3.3);

% Compensador por atrasinho
z = 12.49;
p = 0.0547;
Gc = (s + z) / (s + p);

fprintf('Compensador Projetado Gc(s):\n');
display(Gc);

L_comp = Gc * G;
T_comp = feedback(L_comp, 1);
display(T_comp);

Kp_comp = dcgain(L_comp);
ess_comp = 1 / (1 + Kp_comp);
info_comp = stepinfo(T_comp, 'SettlingTimeThreshold', 0.02);

fprintf('Sobressinal: %.2f %%\n', info_comp.Overshoot);
fprintf('Tempo de Acomodação: %.4f s\n', info_comp.SettlingTime);
fprintf('Erro em Regime Estacionário: %.4f\n', ess_comp);

figure('Name', 'Resposta ao Degrau do Sistema Compensado');
step(T_comp, 'b-', 10);
grid on;
title('Resposta ao Degrau do Sistema Compensado');
xlabel('Tempo (segundos)');
ylabel('Amplitude');