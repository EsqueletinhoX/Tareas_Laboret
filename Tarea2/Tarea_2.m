clc; clear; close all;

S = 5;

t_r = 2;

psita = (-log(S/100)) / (sqrt(pi^2 + log(S/100)^2));

w_0 = 4 / (psita * t_r);

w_d = w_0 * sqrt(1 - psita^2);

t_d = (2*pi) / w_d;

Tm = 0.2;

m = t_d / Tm;

r = exp(-psita * w_0 * Tm);

omega_pos = w_d * Tm;
omega_neg = -w_d * Tm;

p1 = r + 1i*omega_pos;
p2 = r + 1i*omega_neg; 

% Sobrepaso = 5
% td = 4
% Ts = 0.2
% K = 10

G = zpk(-10, [-2 -2], 10);

Gd = c2d(G, Tm, 'zoh');

% step(G)
% step(Gd)

% sisotool(Gd)

C1 = zpk(0.6611, 1, 0.02394, Tm);
C2 = zpk([0.669 -0.06202], [1 0], 0.022637, Tm);

LC1 = feedback(C1*Gd,1);
LC2 = feedback(C2*Gd,1);

% pole(LC1)
% zero(LC1)
% 
% pole(LC2)
% zero(LC2)

figure
pzmap(LC1)
title('Pzmap PI')

figure
pzmap(LC2)
title('Pzmap PID')

figure
step(LC1)
hold on;
step(LC2)
legend('PI','PID')

%% Plots para resultados del simulink

Kp = 0.02394*5.5;
Ki = 0.01355;

% Load model
load_system('PID_digital_tarea');

% Simulate model
sim('PID_digital_tarea');

figure
plot(tout,yout(:,1))
grid on;
title('Salida')
xlabel('Tiempo[s]')

figure
plot(tout,yout(:,2))
grid on;
title('Accion de Control')
xlabel('Tiempo[s]')

figure
plot(tout,yout(:,3))
grid on;
title('Error')
xlabel('Tiempo[s]')

figure
plot(tout,yout(:,5))
grid on;
title('Accion Integral')
xlabel('Tiempo[s]')

figure
plot(tout,yout(:,6))
grid on;
title('Accion Proporcional')
xlabel('Tiempo[s]')