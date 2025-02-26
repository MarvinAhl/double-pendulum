%% Double Pendulum on a Sled Transition Animation
% Author: Marvin Ahlborn
% Date: 2025-02-25
%
% Combining the solutions for transfers between the 4 equilibrium states in
% a single animation. See solve.m

clear variables

L1 = 1;
L2 = 1;
M1 = 1;
M2 = 1;
m = 10;
g = 9.81;

fps = 15;

% The three transfers
t0 = 0;
tf = 3;
x0 = [0; 0; 0; 0; 0; 0];
xf = [0; pi; 0; 0; 0; 0];
lambda0 = [1.069500874604264e+04;-3.663027713651169e+04;-1.398278876915920e+04;1.456652987459533e+04;7.847188265688156e+03;2.871839225480095e+03];

frames1 = round((tf - t0) * fps);
tspan = linspace(t0, tf, frames1);
[~, ~, xhistory1] = flowy(x0, lambda0, tspan, L1, L2, M1, M2, m, g);

t0 = 0;
tf = 3;
x0 = [0; pi; 0; 0; 0; 0];
xf = [0; 0; pi; 0; 0; 0];
lambda0 = [-1.626063751768224e+03;  2.669616328097065e+04; -2.902571015030689e+03; -3.522673086568268e+03;  5.472412520180777e+03;  1.972941430131935e+03];

frames2 = round((tf - t0) * fps);
tspan = linspace(t0, tf, frames2);
[~, ~, xhistory2] = flowy(x0, lambda0, tspan, L1, L2, M1, M2, m, g);

t0 = 0;
tf = 5;
x0 = [0; 0; pi; 0; 0; 0];
xf = [0; pi; pi; 0; 0; 0];
lambda0 = [5.053852505432984e+01; -1.186961810886124e+04;  1.628296874282102e+04; -5.475540491867783e+02; -2.151029653013957e+03;  4.087304109263098e+03];

frames3 = round((tf - t0) * fps);
dt = (tf - t0) / frames3;
tspan = linspace(t0, tf, frames3);
[~, ~, xhistory3] = flowy(x0, lambda0, tspan, L1, L2, M1, M2, m, g);

xhistory = [xhistory1; xhistory2; xhistory3];
frames = frames1 + frames2 + frames3;

savevideo = false;
animate(xhistory, frames, dt, L1, L2, M1, M2, m, g, savevideo);

% ====================== Functions ===========================

function ydot = F(y, L1, L2, M1, M2, m, g)
    x1 = y(1);
    x2 = y(2);
    x3 = y(3);
    x4 = y(4);
    x5 = y(5);
    x6 = y(6);
    lambda1 = y(7);
    lambda2 = y(8);
    lambda3 = y(9);
    lambda4 = y(10);
    lambda5 = y(11);
    lambda6 = y(12);

    ydot = [x4;x5;x6;(M1.^2.*g.*sin(x2.*2.0)+L1.*M1.^2.*x5.^2.*sin(x2).*2.0+M1.*M2.*g.*sin(x2.*2.0)+L1.*M1.*M2.*x5.^2.*sin(x2).*2.0+L2.*M1.*M2.*x6.^2.*sin(x3)+L2.*M1.*M2.*x6.^2.*sin(x2.*2.0-x3)+(M1.*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))+(M2.*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)-(M2.*cos(x2.*2.0-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0))./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0));((M1.^2.*g.*sin(x2)+M1.*M2.*g.*sin(x2)+M1.*g.*m.*sin(x2)+(M2.*g.*m.*sin(x2))./2.0+(L1.*M1.^2.*x5.^2.*sin(x2.*2.0))./2.0+(M2.*g.*m.*sin(x2-x3.*2.0))./2.0+(L2.*M1.*M2.*x6.^2.*sin(x2-x3))./2.0+L2.*M2.*m.*x6.^2.*sin(x2-x3)+(L1.*M1.*M2.*x5.^2.*sin(x2.*2.0))./2.0+(L1.*M2.*m.*x5.^2.*sin(x2.*2.0-x3.*2.0))./2.0+(L2.*M1.*M2.*x6.^2.*sin(x2+x3))./2.0+(M1.*cos(x2).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)+(M2.*cos(x2).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)-(M2.*cos(x2-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)).*-2.0)./(L1.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)));(((M1.*g.*m.*sin(x2.*2.0-x3))./2.0+(M2.*g.*m.*sin(x2.*2.0-x3))./2.0-(M1.*g.*m.*sin(x3))./2.0-(M2.*g.*m.*sin(x3))./2.0+L1.*M1.*m.*x5.^2.*sin(x2-x3)+L1.*M2.*m.*x5.^2.*sin(x2-x3)+(L2.*M2.*m.*x6.^2.*sin(x2.*2.0-x3.*2.0))./2.0+(M1.*cos(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)+(M2.*cos(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)-(M1.*cos(x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)-(M2.*cos(x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)).*2.0)./(L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)));0.0;-(lambda4.*(M1.^2.*g.*cos(x2.*2.0).*2.0+L1.*M1.^2.*x5.^2.*cos(x2).*2.0+M1.*M2.*g.*cos(x2.*2.0).*2.0+L2.*M1.*M2.*x6.^2.*cos(x2.*2.0-x3).*2.0+L1.*M1.*M2.*x5.^2.*cos(x2).*2.0+(M2.*sin(x2.*2.0-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))))./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0))+lambda4.*(M1.^2.*sin(x2.*2.0).*2.0+M1.*M2.*sin(x2.*2.0).*2.0+M2.*m.*sin(x2.*2.0-x3.*2.0).*2.0).*1.0./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).^2.*(M1.^2.*g.*sin(x2.*2.0)+L1.*M1.^2.*x5.^2.*sin(x2).*2.0+M1.*M2.*g.*sin(x2.*2.0)+L1.*M1.*M2.*x5.^2.*sin(x2).*2.0+L2.*M1.*M2.*x6.^2.*sin(x3)+L2.*M1.*M2.*x6.^2.*sin(x2.*2.0-x3)+(M1.*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))+(M2.*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)-(M2.*cos(x2.*2.0-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0))-(lambda6.*(M1.*g.*m.*cos(x2.*2.0-x3)+M2.*g.*m.*cos(x2.*2.0-x3)+L1.*M1.*m.*x5.^2.*cos(x2-x3)+L1.*M2.*m.*x5.^2.*cos(x2-x3)+L2.*M2.*m.*x6.^2.*cos(x2.*2.0-x3.*2.0)-(M1.*sin(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)-(M2.*sin(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)).*2.0)./(L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))+(lambda5.*(M1.^2.*g.*cos(x2).*2.0+M1.*M2.*g.*cos(x2).*2.0+M1.*g.*m.*cos(x2).*2.0+M2.*g.*m.*cos(x2)+L1.*M1.^2.*x5.^2.*cos(x2.*2.0).*2.0+M2.*g.*m.*cos(x2-x3.*2.0)+L2.*M1.*M2.*x6.^2.*cos(x2-x3)+L2.*M2.*m.*x6.^2.*cos(x2-x3).*2.0+L1.*M1.*M2.*x5.^2.*cos(x2.*2.0).*2.0+L1.*M2.*m.*x5.^2.*cos(x2.*2.0-x3.*2.0).*2.0+L2.*M1.*M2.*x6.^2.*cos(x2+x3)-(M1.*sin(x2).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))-(M2.*sin(x2).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)+(M2.*sin(x2-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)))./(L1.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))-(lambda5.*(M1.^2.*sin(x2.*2.0)+M1.*M2.*sin(x2.*2.0)+M2.*m.*sin(x2.*2.0-x3.*2.0)).*1.0./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).^2.*(M1.^2.*g.*sin(x2)+M1.*M2.*g.*sin(x2)+M1.*g.*m.*sin(x2)+(M2.*g.*m.*sin(x2))./2.0+(L1.*M1.^2.*x5.^2.*sin(x2.*2.0))./2.0+(M2.*g.*m.*sin(x2-x3.*2.0))./2.0+(L2.*M1.*M2.*x6.^2.*sin(x2-x3))./2.0+L2.*M2.*m.*x6.^2.*sin(x2-x3)+(L1.*M1.*M2.*x5.^2.*sin(x2.*2.0))./2.0+(L1.*M2.*m.*x5.^2.*sin(x2.*2.0-x3.*2.0))./2.0+(L2.*M1.*M2.*x6.^2.*sin(x2+x3))./2.0+(M1.*cos(x2).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)+(M2.*cos(x2).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)-(M2.*cos(x2-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)).*4.0)./L1+(lambda6.*(M1.^2.*sin(x2.*2.0)+M1.*M2.*sin(x2.*2.0)+M2.*m.*sin(x2.*2.0-x3.*2.0)).*1.0./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).^2.*((M1.*g.*m.*sin(x2.*2.0-x3))./2.0+(M2.*g.*m.*sin(x2.*2.0-x3))./2.0-(M1.*g.*m.*sin(x3))./2.0-(M2.*g.*m.*sin(x3))./2.0+L1.*M1.*m.*x5.^2.*sin(x2-x3)+L1.*M2.*m.*x5.^2.*sin(x2-x3)+(L2.*M2.*m.*x6.^2.*sin(x2.*2.0-x3.*2.0))./2.0+(M1.*cos(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)+(M2.*cos(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)-(M1.*cos(x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)-(M2.*cos(x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)).*4.0)./L2;(lambda6.*(M1.*g.*m.*cos(x3)+M2.*g.*m.*cos(x3)+M1.*g.*m.*cos(x2.*2.0-x3)+M2.*g.*m.*cos(x2.*2.0-x3)+L1.*M1.*m.*x5.^2.*cos(x2-x3).*2.0+L1.*M2.*m.*x5.^2.*cos(x2-x3).*2.0+L2.*M2.*m.*x6.^2.*cos(x2.*2.0-x3.*2.0).*2.0-(M1.*sin(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)-(M2.*sin(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)-(M1.*sin(x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)-(M2.*sin(x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)))./(L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))+(M2.*lambda4.*(L2.*M1.*x6.^2.*cos(x2.*2.0-x3)-L2.*M1.*x6.^2.*cos(x3)+(sin(x2.*2.0-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))))./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0))-(M2.*lambda5.*(g.*m.*cos(x2-x3.*2.0).*2.0+L2.*m.*x6.^2.*cos(x2-x3).*2.0+L1.*m.*x5.^2.*cos(x2.*2.0-x3.*2.0).*2.0-L2.*M1.*x6.^2.*cos(x2+x3)+L2.*M1.*x6.^2.*cos(x2-x3)+(sin(x2-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))))./(L1.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))-M2.*lambda4.*m.*sin(x2.*2.0-x3.*2.0).*1.0./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).^2.*(M1.^2.*g.*sin(x2.*2.0)+L1.*M1.^2.*x5.^2.*sin(x2).*2.0+M1.*M2.*g.*sin(x2.*2.0)+L1.*M1.*M2.*x5.^2.*sin(x2).*2.0+L2.*M1.*M2.*x6.^2.*sin(x3)+L2.*M1.*M2.*x6.^2.*sin(x2.*2.0-x3)+(M1.*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))+(M2.*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)-(M2.*cos(x2.*2.0-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)).*2.0-(M2.*lambda6.*m.*sin(x2.*2.0-x3.*2.0).*1.0./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).^2.*((M1.*g.*m.*sin(x2.*2.0-x3))./2.0+(M2.*g.*m.*sin(x2.*2.0-x3))./2.0-(M1.*g.*m.*sin(x3))./2.0-(M2.*g.*m.*sin(x3))./2.0+L1.*M1.*m.*x5.^2.*sin(x2-x3)+L1.*M2.*m.*x5.^2.*sin(x2-x3)+(L2.*M2.*m.*x6.^2.*sin(x2.*2.0-x3.*2.0))./2.0+(M1.*cos(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)+(M2.*cos(x2.*2.0-x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)-(M1.*cos(x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)-(M2.*cos(x3).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)).*4.0)./L2+(M2.*lambda5.*m.*sin(x2.*2.0-x3.*2.0).*1.0./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).^2.*(M1.^2.*g.*sin(x2)+M1.*M2.*g.*sin(x2)+M1.*g.*m.*sin(x2)+(M2.*g.*m.*sin(x2))./2.0+(L1.*M1.^2.*x5.^2.*sin(x2.*2.0))./2.0+(M2.*g.*m.*sin(x2-x3.*2.0))./2.0+(L2.*M1.*M2.*x6.^2.*sin(x2-x3))./2.0+L2.*M2.*m.*x6.^2.*sin(x2-x3)+(L1.*M1.*M2.*x5.^2.*sin(x2.*2.0))./2.0+(L1.*M2.*m.*x5.^2.*sin(x2.*2.0-x3.*2.0))./2.0+(L2.*M1.*M2.*x6.^2.*sin(x2+x3))./2.0+(M1.*cos(x2).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*2.0)+(M2.*cos(x2).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)-(M2.*cos(x2-x3.*2.0).*(L2.*M1.*lambda5.*cos(x2).*2.0+L1.*M1.*lambda6.*cos(x3)+L2.*M2.*lambda5.*cos(x2)+L1.*M2.*lambda6.*cos(x3)-L2.*M2.*lambda5.*cos(x2-x3.*2.0)-L1.*L2.*M1.*lambda4.*2.0-L1.*L2.*M2.*lambda4-L1.*M1.*lambda6.*cos(x2.*2.0-x3)-L1.*M2.*lambda6.*cos(x2.*2.0-x3)+L1.*L2.*M2.*lambda4.*cos(x2.*2.0-x3.*2.0)))./(L1.*L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)).*4.0)).*4.0)./L1;-lambda1;-(L2.*M1.^2.*lambda2+L2.*M1.*M2.*lambda2+L2.*M1.*lambda2.*m.*2.0+L2.*M2.*lambda2.*m-L2.*M1.^2.*lambda2.*cos(x2.*2.0)-L2.*M2.*lambda2.*m.*cos(x2.*2.0-x3.*2.0)-L2.*M1.^2.*lambda5.*x5.*sin(x2.*2.0).*2.0-L2.*M1.*M2.*lambda2.*cos(x2.*2.0)+L1.*M1.*lambda6.*m.*x5.*sin(x2-x3).*4.0+L1.*M2.*lambda6.*m.*x5.*sin(x2-x3).*4.0+L1.*L2.*M1.^2.*lambda4.*x5.*sin(x2).*4.0-L2.*M1.*M2.*lambda5.*x5.*sin(x2.*2.0).*2.0-L2.*M2.*lambda5.*m.*x5.*sin(x2.*2.0-x3.*2.0).*2.0+L1.*L2.*M1.*M2.*lambda4.*x5.*sin(x2).*4.0)./(L2.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)));-(L1.*M1.^2.*lambda3+L1.*M1.*M2.*lambda3+L1.*M1.*lambda3.*m.*2.0+L1.*M2.*lambda3.*m-L1.*M1.^2.*lambda3.*cos(x2.*2.0)-L1.*M2.*lambda3.*m.*cos(x2.*2.0-x3.*2.0)-L1.*M1.*M2.*lambda3.*cos(x2.*2.0)-L2.*M1.*M2.*lambda5.*x6.*sin(x2-x3).*2.0-L2.*M2.*lambda5.*m.*x6.*sin(x2-x3).*4.0+L1.*M2.*lambda6.*m.*x6.*sin(x2.*2.0-x3.*2.0).*2.0-L2.*M1.*M2.*lambda5.*x6.*sin(x2+x3).*2.0+L1.*L2.*M1.*M2.*lambda4.*x6.*sin(x3).*2.0+L1.*L2.*M1.*M2.*lambda4.*x6.*sin(x2.*2.0-x3).*2.0)./(L1.*(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0)))];
end

% Same as flow but without propagating the state transition matrix
function [x, lambda, xhistory, lambdahistory] = flowy(x0, lambda0, tspan, L1, L2, M1, M2, m, g)
    y0 = [x0; lambda0];

    odeoptions = odeset(RelTol = 1e-6, AbsTol = 1e-6, MinStep=1e-8);
    [~, y] = ode113(@(t, y) F(y, L1, L2, M1, M2, m, g), tspan, y0, odeoptions);

    x = y(end, 1:6)';
    lambda = y(end, 7:12)';
    xhistory = y(:, 1:6);
    lambdahistory = y(:, 7:12);
end

function animate(x, frames, dt, L1, L2, M1, M2, m, g, savevideo)
    figure();
    
    % Draw pendulum
    rm = [x(1, 1); 0];
    rM1 = rm + L1 * [sin(x(1, 2)); -cos(x(1, 2))];
    rM2 = rM1 + L2 * [sin(x(1, 3)); -cos(x(1, 3))];
    arm1 = plot([rm(1), rM1(1)], [rm(2), rM1(2)], 'k-', 'LineWidth', 1);
    hold on
    arm2 = plot([rM1(1), rM2(1)], [rM1(2), rM2(2)], 'k-', 'LineWidth', 1);
    sled = plot(rm(1), rm(2), 'r.', 'MarkerSize', 20);
    mass1 = plot(rM1(1), rM1(2), 'k.', 'MarkerSize', 20);
    mass2 = plot(rM2(1), rM2(2), 'k.', 'MarkerSize', 20);
    
    window_size_x = 5;
    window_size_y = 2.5;
    axis equal
    xlim([-window_size_x, window_size_x])
    ylim([-window_size_y, window_size_y])
    grid on
    
    title("Double Pendulum Sled Simulation")
    xlabel("x / m")
    ylabel("y / m")
    
    % Playback factor because matlab is slow af
    playfac = 2;

    % Animate pendulum
    for frame = 1:frames
        pause(dt / playfac);
    
        rm = [x(frame, 1); 0];
        rM1 = rm + L1 * [sin(x(frame, 2)); -cos(x(frame, 2))];
        rM2 = rM1 + L2 * [sin(x(frame, 3)); -cos(x(frame, 3))];
    
        arm1.XData = [rm(1), rM1(1)];
        arm1.YData = [rm(2), rM1(2)];
        arm2.XData = [rM1(1), rM2(1)];
        arm2.YData = [rM1(2), rM2(2)];
        sled.XData = rm(1);
        sled.YData = rm(2);
        mass1.XData = rM1(1);
        mass1.YData = rM1(2);
        mass2.XData = rM2(1);
        mass2.YData = rM2(2);
    
        axis equal
        xlim([-window_size_x, window_size_x])
        ylim([-window_size_y, window_size_y])
    
        drawnow

        if (savevideo)
            exportgraphics(gcf, 'choreography.gif', 'Append', true);
        end
    end
end