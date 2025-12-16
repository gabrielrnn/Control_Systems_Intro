clearvars 
close all 
clc

global g
omega_0 = 3;
T = 2*pi/omega_0;
b = 1;
r2d = 180/pi;
d2r = pi/180;

A = [0 1; -omega_0^2 0];
B = [0; b];
C = [1 0];
D = 0;


linSys = ss(A,B,C,D);

%% Pole placing

syms k1 k2
A_hat = A-b*[0 0; k1 k2];
lambdas = eig(A_hat);
% para s = -4, temos que k1 = 7 e k2 = 8
K = [7 8];
vars = [k1 k2];
lambdas = subs(lambdas, vars, K);
Kr = -1/(C/(A-B*K)*B);
r = 70*d2r;
%% System simulation and sanity checks 
ti = 0;
tf = 10;
t = linspace(ti,tf,100);
x0 = [45*d2r;0];
[~, xL] = ode45(@(t,x) linearPend(t,x,b,omega_0), t, x0);
[~, xNL] = ode45(@(t,x) nonLinearPend(t,x,b,omega_0, Kr, r), t, x0);

figure
plot(t, xL(:,1)*r2d, 'r');
hold on
plot(t, xNL(:,1)*r2d, 'bo')
grid on;
xlim([ti tf]);
xlabel("Seconds");
ylabel("\theta (deg)");
title("Sanity Check!");
legend("Linear", "NonLinear");

modelError = abs(xL-xNL);
figure 
plot(t, modelError);
grid on;
xlim([0 5]);
xlabel("Seconds");
title("Sanity Check!");
legend("\theta", "\theta_t");




%% Animar movimento do pêndulo 
x_pos = sin(xNL(:,1));
y_pos = -cos(xNL(:,1));
 

figure;
axis equal
axis([-1.2 1.2 -1.2 1.2])
grid on
hold on

% cria os objetos gráficos
h_line = plot([0 x_pos(1)], [0 y_pos(1)], 'k-', 'LineWidth', 2);
h_mass = plot(x_pos(1), y_pos(1), 'ro', 'MarkerSize', 10, ...
              'MarkerFaceColor','r');

for i = 1:length(x_pos)
    set(h_line, 'XData', [0 x_pos(i)], 'YData', [0 y_pos(i)])
    set(h_mass, 'XData', x_pos(i), 'YData', y_pos(i))
    dt = 0.03;  % passo de tempo da simulação
    pause(dt)

    drawnow
end
function xDot = nonLinearPend(t, x, b, omega_0, Kr, r)
    
    % u = -7*x(1)-8*x(2); % state feedback
    % u = -7*x(1)-8*x(2) + Kr*r; % state feedback w/ reference tracking

    u = 0;
    xDot = [x(2); -omega_0^2*sin(x(1)) + b*u];
end

function xDot = linearPend(t, x, b, omega_0)
    % u = -7*x(1)-8*x(2); % lei de controle
    u = 0;
    xDot = [x(2); -omega_0^2*x(1) + b*u];
end