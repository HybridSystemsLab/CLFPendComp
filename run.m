%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Ricardo Sanfelice
%
% Project: Simulation of a hybrid system
%
% Name: run.m
%
% Description: run script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all 

%%%%%%%% INITIALIZE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initial conditions                                                  
x0 = [2;-10;0;0;0;0;0;0]; % position, velocity, timer, memory state for flow 
                    % input, memory state for jump,  second timer, and 2d memoy

% global constants
global a b c cprime e0 d r lambda Tu Ts
% computing threshold Tu
%Tu = 0.1; % Tu0
%Tu = 0.01; % Tu1
%Tu = 0.005; % Tu2
Tu = 0.001; % Tu3
%Tu = 0.0001; % Tu4
%Tu = 0.00001; % Tu4

% sampling threshold Ts
Ts = 0.1;

a = 1;
b = 1;
%rho = 0; % now define parameters of rho function (rho.m)
cprime = -0.1;
c = 2/pi*(1+cprime)*0.9;
% e = 1/2; % now define parameters of e function (restitutionE.m)
e0 = 1/2;
d = -2/pi*(1-e0)*0.9;
r = 0.0015;
% lambda = 1-e^2; % compute lambda

s = linspace(-pi/2,0,100);
for i = 1:100
    minToGo(i) = min(2*(1-(1+rho(s(i),c,cprime))^2),1-restitutionE(s(i),d,e0)^2);
end
lambda = min(minToGo)/2;

% select control law at jumps
s = -pi/2;
s = linspace(-pi/2,0,100);
for i = 1:100
   Gamma11 = -2*(1-(1+rho(s(i),c,cprime))^2) + lambda;
   Gamma12 = -(2+rho(s(i),c,cprime))*restitutionE(s(i),d,e0);
   Gamma21 = Gamma12;
   Gamma22 = -(1-restitutionE(s(i),d,e0)^2) + lambda;
   % but the cross terms grow away from D, so we remove them
   Gamma = [Gamma11, 0; 0, Gamma22];
   eig(Gamma)
end

% plot rho and e
% figure(1)
% clf
% s = linspace(-pi/2,0,100);
% plot(s,rho(s,c,cprime),'r')
% hold on
% plot(s,restitutionE(s,d,e0),'b')

% simulation horizon
T = 50;
%J = 1e7;
J = 1e9;

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
% rule = 3 -> no priority, random selection when simultaneous conditions (Simulink only)
rule = 1;

%solver tolerances
RelTol = 1e-4;
MaxStep = .01;

%%%%%%%%%%%%%%%%%%%% SIMULATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Comment one of these out to use the other method of simulation

% 1) simulate using hybridsolver
%[t x j] = hybridsolver( @f,@g,@C,@D,x0,T,J,rule);

% 2) simulate using HybridSimulator
sim('HybridSimulator')

%%%%%%%%%%%%%%%%%%%%% POSTPROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x1 = x(:,1);
x2 = x(:,2);
tau = x(:,3);
z1 = x(:,4);
z2 = x(:,5);
tau2 = x(:,6);

% save data
%save SimData-Delta3