function out = f(u)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Ricardo Sanfelice
%
% Project: Simulation of a hybrid system
%
% Name: f.m
%
% Description: Flow map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global a b 

% state
x1 = u(1);
x2 = u(2);
tau = u(3);
z1 = u(4);
x = [x1;x2];

uc1 = z1;

% flow map
x1dot = x2;
x2dot = -a*sin(x1) - b*x2 + uc1;  % write z instead of uc1

out = [x1dot; x2dot; 1; 0;0;1;0;0];
end

