function out = g(u)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Ricardo Sanfelice
%
% Project: Simulation of a hybrid system
%
% Name: g.m
%
% Description: Jump map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global c cprime d e0 Ts Tu;

% state
x1 = u(1);
x2 = u(2);
tau = u(3);
z1 = u(4);
z2 =  u(5);
tau2 = u(6);
z3 = [u(7);u(8)];

uc2 = z2;

% jump map
if ((x1 <= uc2) && (x2 <= 0))
	x1plus = x1 + rho(uc2,c,cprime) * x1;
    x1plus = uc2 + rho(uc2,c,cprime) * uc2;
	x2plus = -restitutionE(uc2,d,e0) * x2;
else
	x1plus = x1;
	x2plus = x2;
end

if (tau >= Tu)
	z1plus = fmincon(@(u) optFunction(u),0,[],[],[],[],[],[],@(u) optConstraintsFlow(z3,u));
    %z2plus = fmincon(@(u) optFunction(u),0,[],[],[],[],[],[],@(u) optConstraintsJump([x1;x2],u));
    z2plus = 0;  % set to zero since \rho_d \equiv 0
	tauplus = 0;
    tau2plus = tau2;
    z3plus = z3;
elseif (tau2 >= Ts)
	z1plus = z1;
    z2plus = z2;
	tauplus = tau;
    tau2plus = 0;
    z3plus = [x1;x2];
else
	z1plus = z1;
    z2plus = z2;
	tauplus = tau;
    tau2plus = tau2;
    z3plus = z3;
end

out = [x1plus;x2plus;tauplus;z1plus;z2plus;tau2plus;z3plus];
end

function out = optFunction(u)
    out = norm(u);
end

function [c,ceq] = optConstraintsFlow(x,u)
    global  lambda a b
    x1 = x(1);
    x2 = x(2);
    psi0 = 4*x1*x2 + 2*x2^2 + 2*(-a*sin(x1) - b*x2) * (x2 + x1) + lambda * norm(x)^2;
    psi1 = 2*(x1 + x2);
    c = psi0+psi1*u;
    ceq = [];
end

function [cineq,ceq] = optConstraintsJump(x,u)
    global c cprime lambda
    x1 = x(1);
    x2 = x(2);
    
    cineq = -2*x1^2*(1-(1+rho(u,c,cprime) * x1)^2)-x2^2*(1-restitutionE(u,c,cprime)^2)+lambda*norm(x)^2;
    ceq = [];
end