function out = jumpPriority(z,rule)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Ricardo Sanfelice
%
% Project: Simulation of a hybrid system
%
% Name: jumpPriority.m
%
% Description: Jump priority function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% state
flowFlag = z(1);
jumpFlag = z(2);
stateFlag = z(3);
randomInput = z(4);

% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
% rule = 3 -> no priority, random selection when simultaneous conditions

if (rule == 1) & (jumpFlag == 1)
   out = 1;
elseif (rule == 1) & (jumpFlag == 0)
   out = 0;
elseif (rule == 2) & (flowFlag == 1)
   out = 0;
elseif (rule == 2) & (flowFlag == 0) & (jumpFlag == 0)
   out = 0;
elseif (rule == 2) & (flowFlag == 0) & (jumpFlag == 1)
   out = 1;
elseif (rule == 3)
   if (flowFlag == 1) & (jumpFlag == 0)
      out = 0;
   elseif (flowFlag == 0) & (jumpFlag == 1)
      out = 1;
   elseif (flowFlag == 1) & (jumpFlag == 1)
%      aux = 0.4 + (0.6-0.4).*rand;
      if (randomInput >= 0.5)
         out = 1;
      else
         out = 0;
      end
   else
       out = 0;
   end
end

