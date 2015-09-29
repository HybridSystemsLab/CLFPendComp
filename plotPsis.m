function [psi0 psi1] = plotPsis(x1,x2,a,b,lambda)

x = [x1;x2];

psi0 = 4*x1*x2 + 2*x2^2 + 2*(-a*sin(x1) - b*x2) * (x2 + x1) + lambda * norm(x);
%+ \lambda x^\top x;
psi1 = 2*(x1 + x2);
