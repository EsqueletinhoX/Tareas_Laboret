clear; clc; close all

%% A lazo abierto
G = zpk(-10,[-2 -2],10); % Se obtiene la función de transferencia continua
Tm = 0.2; 

% Hallar la FT discreta lazo abierto Gd del sist. con Z0H a la
% entrada y el Tm
Gd = c2d(G, Tm, 'zoh');


% Mapa de p y z del sist. cont y discreto
figure;
pzmap(G)
figure;
pzmap(Gd)

Gd1 = c2d(G, 10*Tm, 'zoh');
figure;
pzmap(Gd1);

figure;
step(G)

figure;
step(Gd)

% Para el sist. discreto
Kp = dcgain(Gd);
F = feedback(Gd, 1);
figure;
step(F);

t = 0:Tm:100*Tm;

figure;
lsim(F,t,t)

figure;
rlocus(G);
title('G');

figure;
rlocus(Gd);
title('Gd');

figure;
rlocus(Gd1);
title('Gd1');