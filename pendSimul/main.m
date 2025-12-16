clc; clearvars;

% Pendulum Parameters
L = 1;
m = 1;
g = 9.81;
b = 0.1;

% Simul Parameters
tSpan = [0 5];
x0 = [10*pi/180 0];

pend = Pendulum(L, m, g, b);
pendSimul = PendulumSimulator(pend, tSpan, x0);
[t, x] = pendSimul.simulate();

figure
plot(t, x, 'bo');
grid on;
title("Pendulum Simulation");
ylabel("\theta [rad]");
xlabel("Time [s]")
