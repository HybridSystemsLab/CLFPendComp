function [v] = O(u) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Ricardo Sanfelice
%
% Project: Simulation of a hybrid system
%
% Name: O.m
%
% Description: State space
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% state
x1 = u(1);
x2 = u(2);
tau = u(3);
x = [x1; x2];

global r;

%r = 0.1;
%x1 = 0.205;
%x2 = 0.205;
%V = exp(1/omega*real(asin(sqrt(2)/2*(abs(x1)+x2)/(sqrt(x1^2+x2^2)))))*(x1^2 + x2^2);
P = [2 1; 1 1];
V = x'*P*x;
if (V >= r)
   v = 1;
else
%    V
    v = 0;
end

