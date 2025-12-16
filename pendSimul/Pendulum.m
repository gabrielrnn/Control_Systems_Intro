classdef Pendulum
    properties 
        L_m 
        m_kg
        g_mps2
        b
    end
    methods
        function obj = Pendulum(L, m, g, b)
            obj.L_m = L;
            obj.m_kg = m;
            obj.g_mps2 = g;
            obj.b = b;
        end

        function xDot = dynamics(obj, ~, x)
            % y = [theta, thetaDot]
            theta = x(1);
            thetaDot = x(2);

            dTheta = thetaDot;
            dThetaDot = -obj.g_mps2/obj.L_m*sin(theta) - obj.b*thetaDot;

            xDot = [dTheta; dThetaDot];
        end

        function [x,y] = position(obj, theta)
            % (r, theta) -> (x,y)
            x = obj.L_m*sin(theta);
            y = -obj.L_m*cos(theta);
        end
    end
end