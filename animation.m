%% Animate the double pendulum on cart movement
% Author: Marvin Ahlborn
% Date: 2025-02-25

clear variables

% Constants
M1 = 1;  % Pendulum mass 1 [kg]
M2 = 1;  % Pendulum mass 2 [kg]
m = 10;  % Sled mass [kg]
L1 = 1;  % Pendulum length 1 [m]
L2 = 1;  % Pendulum length 2 [m]
g = 9.81;  % Earth acc [m/s^2]

% Integrate the equations of motion
t0 = 0;
tf = 10;

fps = 15;
frames = round((tf - t0) * fps);
dt = (tf - t0) / frames;
tspan = linspace(t0, tf, frames);

% Integrate solution
x0 = [0; pi; pi + 1e-3; 0; 0; 0];  % Sled position, pendulum angle 1, pendulum angle 2, sled velocity, pendulum ang vel 1, pendulum ang vel 2
odeoptions = odeset(RelTol = 1e-10, AbsTol = 1e-10);
[~, x] = ode113(@(t, x) f(x, u(t), L1, L2, M1, M2, g, m), tspan, x0, odeoptions);

%% Animate solution
fig = figure();

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

% Because matlab is slow
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
end

% ---------- The dynamics of the double pendulum ---------------------
function xdot = f(x, u, L1, L2, M1, M2, g, m)
    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
    x4 = x(4);
    x5 = x(5);
    x6 = x(6);

    xdot = [x4;x5;x6;(M1.*u.*2.0+M2.*u-M2.*u.*cos(x2.*2.0-x3.*2.0)+M1.^2.*g.*sin(x2.*2.0)+L1.*M1.^2.*x5.^2.*sin(x2).*2.0+M1.*M2.*g.*sin(x2.*2.0)+L1.*M1.*M2.*x5.^2.*sin(x2).*2.0+L2.*M1.*M2.*x6.^2.*sin(x3)+L2.*M1.*M2.*x6.^2.*sin(x2.*2.0-x3))./(M1.*m.*2.0+M2.*m-M1.^2.*cos(x2.*2.0)+M1.^2+M1.*M2-M1.*M2.*cos(x2.*2.0)-M2.*m.*cos(x2.*2.0-x3.*2.0));-(M2.*u.*cos(x2-x3.*2.0).*(-1.0./2.0)+M1.^2.*g.*sin(x2)+M1.*u.*cos(x2)+(M2.*u.*cos(x2))./2.0+M1.*M2.*g.*sin(x2)+M1.*g.*m.*sin(x2)+(M2.*g.*m.*sin(x2))./2.0+(L1.*M1.^2.*x5.^2.*sin(x2.*2.0))./2.0+(M2.*g.*m.*sin(x2-x3.*2.0))./2.0+(L2.*M1.*M2.*x6.^2.*sin(x2-x3))./2.0+L2.*M2.*m.*x6.^2.*sin(x2-x3)+(L1.*M1.*M2.*x5.^2.*sin(x2.*2.0))./2.0+(L1.*M2.*m.*x5.^2.*sin(x2.*2.0-x3.*2.0))./2.0+(L2.*M1.*M2.*x6.^2.*sin(x2+x3))./2.0)./(L1.*(M1.*m+(M2.*m)./2.0-(M1.^2.*cos(x2.*2.0))./2.0+M1.^2./2.0+(M1.*M2)./2.0-(M1.*M2.*cos(x2.*2.0))./2.0-(M2.*m.*cos(x2.*2.0-x3.*2.0))./2.0));((M1.*u.*cos(x2.*2.0-x3))./2.0+(M2.*u.*cos(x2.*2.0-x3))./2.0-(M1.*u.*cos(x3))./2.0-(M2.*u.*cos(x3))./2.0+(M1.*g.*m.*sin(x2.*2.0-x3))./2.0+(M2.*g.*m.*sin(x2.*2.0-x3))./2.0-(M1.*g.*m.*sin(x3))./2.0-(M2.*g.*m.*sin(x3))./2.0+L1.*M1.*m.*x5.^2.*sin(x2-x3)+L1.*M2.*m.*x5.^2.*sin(x2-x3)+(L2.*M2.*m.*x6.^2.*sin(x2.*2.0-x3.*2.0))./2.0)./(L2.*(M1.*m+(M2.*m)./2.0-(M1.^2.*cos(x2.*2.0))./2.0+M1.^2./2.0+(M1.*M2)./2.0-(M1.*M2.*cos(x2.*2.0))./2.0-(M2.*m.*cos(x2.*2.0-x3.*2.0))./2.0))];
end

% The open loop control function
function f = u(t)
    f = 0;
end