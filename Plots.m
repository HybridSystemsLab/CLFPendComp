% plots
clear all
load optimalSol.mat

figure(2) % planar plot
clf
plotHarc(x1,j,x2,[],'g');
hold on
plot(x1(1),x2(1),'g*')

load SimData-Tu0.mat

figure(2) % planar plot
plotHarc(x1,j,x2,[],'b');
hold on
plot(x1(1),x2(1),'b*')

grid on
ylabel('x2')
xlabel('x1')

print -depsc -tiff -r300 PlanarPendulumImplementedCLF.eps
pause

load SimData-Tu1.mat

figure(2) % planar plot
plotHarc(x1,j,x2,[],'r');
hold on
plot(x1(1),x2(1),'r*')

load SimData-Tu2.mat

figure(2) % planar plot
plotHarc(x1,j,x2,[],'g');
hold on
plot(x1(1),x2(1),'g*')

load SimData-Tu3.mat

figure(2) % planar plot
plotHarc(x1,j,x2,[],'m');
hold on
plot(x1(1),x2(1),'k*')

grid on
ylabel('x2')
xlabel('x1')

%print -depsc -tiff -r300 PlanarPendulumImplementedCLF-Zoom.eps

break

% other plotting calls (some are stale)

figure(1) % height
clf
subplot(2,1,1),plotflows(t,j,x1)
grid on
ylabel('x1')
axis([0 11 -0.5 3])

% subplot(2,1,2),plotjumps(t,j,x1)
% grid on
% ylabel('x1')

%figure(2) % velocity
%clf
subplot(2,1,2), hold on, plotflows(t,j,x2)
grid on
ylabel('x2')
axis([0 11 -10 5])

print -depsc -tiff -r300 PositionAndVelocityPendulum2.eps
% subplot(2,1,2),plotjumps(t,j,x2)
% grid on
% ylabel('x2')

% plot hybrid arc
% plotHybridArc(t,j,x)
% xlabel('j')
% ylabel('t')
% zlabel('x')
% 

figure(2) % planar plot
%clf
plotHarc(x1,j,x2,[],'b');
hold on
plot(x1(1),x2(1),'b*')
grid on
ylabel('x2')
xlabel('x1')

print -depsc -tiff -r300 PlanarSimulation2.eps

load optimalSol.mat

figure(1) % height
subplot(2,1,1),plotflows(t,j,x1)
hold on
%grid on
%ylabel('x1')
%axis([0 11 -0.5 3])
subplot(2,1,2),plotflows(t,j,x2)
hold on
%grid on
%ylabel('x2')
%axis([0 11 -10 5])

figure(2) % planar plot
plotHarc(x1,j,x2,[],'g');
hold on
plot(x1(1),x2(1),'g*')

print -depsc -tiff -r300 PositionAndVelocityPendulum2.eps

break

figure(3) % plot psi0 and psi1 used in the control law during flows
clf
N = length(x1);
for i = 1:N
    [psi0(i) psi1(i)] = plotPsis(x1(i),x2(i),a,b,lambda);
end
plot(t,psi0,'r')
hold on
plot(t,psi1,'b')

hold on
plot(t,-psi0./psi1,'g')


break

figure(4) % planar plot
clf
plot(x1,x2,'b')
hold on
plot(x1(1),x2(1),'b*')
grid on
ylabel('x2')
ylabel('x1')


break

axis([-2 2 -2 2])
axis equal
ezplot('y=x')
ezplot('y=-x')

% add plot of level sets of V

% V(x) = 1/omega*(x1^2 + x2^2)
%ezplot('exp(1/5*asin(sqrt(2)/2*(abs(x)+y)/(sqrt(x^2+y^2))))*(x^2 + y^2) = 0.1')

[X,Y] = meshgrid(-0.5:.001:0.5,-0.5:.001:0.5);
Z = exp((1/omega).*asin(sqrt(2)/2.*(abs(X)+Y)./(sqrt(X.^2+Y.^2)))).*(X.^2 + Y.^2);
%Z = X.*exp(-X.^2-Y.^2);
[C,h] = contour(X,Y,Z,r);
set(h,'ShowText','off')
colormap cool

title('')
xlabel('x1')
ylabel('x2')
print -depsc -tiff -r300 PlanarSimulation2.eps

break

figure(5) % time to reach
clf
plot(t,tau,'r')
hold on
% from the paper, the time to jump is given by:
TtoJump = 1/omega.*asin((abs(x1) + x2)./sqrt(x1.^2+x2.^2) .* sqrt(2)/2);
plot(t,TtoJump,'g')
%hold on
%plot(t,tau)

figure(6) % time to reach as a function of x
[x1,x2] = meshgrid(0:.01:1,-1:.005:1);
Z = real(1/omega.*asin((abs(x1) + x2)./sqrt(x1.^2+x2.^2) .* sqrt(2)/2));
meshc(x1,x2,Z);
xlabel('x1')
ylabel('x2')
zlabel('z')
axis([0 1 -1 1 0 1])

%plot3('1/5*asin((abs(x) + y)/sqrt(x^2+y^2) * sqrt(2)/2');


figure(7) % planar plot
clf
plot(x1,x2,'r')
grid on
ylabel('x2')
ylabel('x1')
axis([-2 2 -2 2])
axis equal
hold on
ezplot('y=x')
ezplot('y=-x')

