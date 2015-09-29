function [v] = D(u) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Ricardo Sanfelice
%
% Project: Simulation of a hybrid system
%
% Name: D.m
%
% Description: Jump set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Tu Ts;

% state
x1 = u(1);
x2 = u(2);
tau = u(3);

uc2 = u(5);
tau2 = u(6);

if ((x1 <= uc2) && (x2 <= 0)) || (tau >= Tu)  || (tau2 >= Ts)  % jump condition
    v = 1;  % report jump
else
    v = 0;   % do not report jump
end

