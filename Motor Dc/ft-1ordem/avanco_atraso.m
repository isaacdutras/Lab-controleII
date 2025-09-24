 clc, clear

s = tf('s');

%g = (0.46)/(s+3.3);
g = tf([-0.01288 -24.6 6115], [1 145.7 13600 43650]);

kc = 30.035;
%Avanço
z1 = 2.1;                                                                                                                                                                                                                                                                           
p1 = 5.92;
%Atraso
z2 = 4.108;
p2 = 0.1;

c = kc*(((s+z1)*(s+z2))/((s+p1)*(s+p2)));

rlocus(g);

sys = feedback(c * g, 1);              
[wn, zeta] = damp(sys)

figure;
step(sys);
grid on;

% Obtém informações detalhadas da resposta ao degrau
info = stepinfo(sys); 

% Obtém o valor final para o erro estacionário
final_value = dcgain(sys);

sysd = c2d(c, 0.035, 'zoh')

% Exibe apenas as informações solicitadas
fprintf('Sobressinal (Overshoot): %.2f%%\n', info.Overshoot);
fprintf('Tempo de acomodação (2%%): %.2f s\n', info.SettlingTime);
fprintf('Erro estacionário: %.4f\n', 1 - final_value);

%Teste 01 - Melhor resultado ( Para melhorar foi deslocado o z para a
%esquerda )

%kc = 26.354;
%Avanço
%z1 = 2.1; 
%p1 = 5.92;
%Atraso
%z2 = 5.7;
%p2 = 0.05;
%ZOH: u[k] = 1.811u[k-1]-0.8114u[k-2]+26.22e[k]-45.86e[k-1]+20.12e[k-2]

%Teste 02 - Poderia melhorar (aumentar kp e afastar um pouco o z2)
%Obs:Atende os requisitos e nao altera muito o valor calculado de Kc

%kc = 30.035;
%Avanço
%z1 = 2.1; 
%p1 = 5.92;
%Atraso
%z2 = 4.108;
%p2 = 0.1;
%ZOH: u[k]=1.809u[k-1]-0.81u[k-2]+30.03e[k]-54.03e[k]-54.03e[k-1]+24.28e[k-2]
