clc; clearvars;

% Pendulum Parameters
L = 1;
m = 1;
g = 9.81;
b = 0.5;

% Simul Parameters
tSpan = [0 20];
x0 = [10*pi/180 0];

pend = Pendulum(L, m, g, b);
pendSimul = PendulumSimulator(pend, tSpan, x0);
[t, x] = pendSimul.simulate();
theta = x(:,1);
thetaDot = x(:,2);
E = -m*g*L*cos(theta) + m*L^2*thetaDot.^2/2;
E0 = -m*g*L;

figure
plot(t, theta, 'b', LineWidth=2);
grid on;
title("Pendulum Position");
ylabel("\theta [rad]");
xlabel("Time [s]")
xlim([0 5])

figure 
plot(thetaDot, theta, 'k', LineWidth=1);
grid on;
title("Pendulum Phase Map");
ylabel("\theta [rad]");
xlabel("\theta Dot [rps]")

figure 
plot(t, E, 'r', LineWidth=1);
hold on 
plot([0 20], [E0 E0], 'k--')
grid on;
title("Pendulum Energy");
ylabel("E [J]");
xlabel("Time [s]")
xlim([0 15])
legend("E", "E_0")