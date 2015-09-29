% initialization for bouncing ball example

clear all                                                               
                                                                        
% initial conditions                                                    
x0 = [1;0];                                                             
u0 = 0;                                                                 
% combine initial conditions                                            
z0 = [x0; u0];                                                          
                                                                        
% simulation horizon                                                    
T = 10;                                                                 
J = 20;                                                                 
                                                                        
% rule for jumps                                                        
% rule = 1 -> priority for jumps                                        
% rule = 2 -> priority for flows                                        
% rule = 3 -> no priority, random selection when simultaneous conditions
rule = 1;                                                               
                                                                        
% constants                                                                                                                        
n = 2; %# of state components                                       
m = 1; %# of input components  

%solver tolerances
%options = odeset('RelTol',1e-8,'MaxStep',.1);

RelTol = 1e-8;
MaxStep = .01;

%paramNameValStruct.RelTol = '1e-8';
%paramNameValStruct.MaxStep = '.01';

% simulate
sim('HybridSimulator_v06')