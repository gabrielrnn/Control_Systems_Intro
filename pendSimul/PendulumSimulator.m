classdef PendulumSimulator
    properties 
        pend
        tSpan
        x0
    end

    methods
        function obj = PendulumSimulator(pend, tSpan, x0)
            obj.pend = pend;
            obj.tSpan = tSpan;
            obj.x0 = x0;
        end

        function [t, x] = simulate(obj)
            f = @(t, x) obj.pend.dynamics(t, x);
            [t, x] = ode45(f, obj.tSpan, obj.x0);
        end
    end
end
