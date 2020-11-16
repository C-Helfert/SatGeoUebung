%% Satgeo Ü1
% Nadine & Ziqing
clear all
clc
close all
load('rhocoe.mat')

%% GOCE
a = 6378137+225e3; % meter
I = deg2rad(96.6); % radiant
e = 0; % keine Einheit
Omega = deg2rad(335);% radiant
w = deg2rad(273); % radiant
M = deg2rad(5); % radiant
GM = 3.9865005*10^14; %m`3/s`2

h_GOCE = 225; % km

% r and v are the initial position and velocity
[r,v] = kep2cart(I,Omega,w,M,e,a,GM); % meter for r and m/s for v
r11 = [r';v'];
f1 = drag_force(dc,h_GOCE,v');


options = odeset('RelTol',1e-15,'AbsTol',1e-15);
TC=2*pi*(sqrt((norm(r11(1:3)))^3/GM));  % aus dem Bachelor übernommen
t_1_sec=[0 10*TC];                       % aus dem Bachelor übernommen
[T1,Y1]=ode113(@(t,y)odefun(t,y,dc,h_GOCE),t_1_sec, r11,options);
plot3(Y1(:,1),Y1(:,2),Y1(:,3),'r');

% numerische Integration für GOCE
function dydt = odefun(t,y,dc,h_GOCE)
GM=3.9865005e14;
ft = drag_force(dc,h_GOCE,[y(4);y(5);y(6)]);
dydt = [y(4);
        y(5);
        y(6);
        -y(1)*GM/norm(y(1:3))^3 + ft(1);
        -y(2)*GM/norm(y(1:3))^3 + ft(2);
        -y(3)*GM/norm(y(1:3))^3 + ft(3)];
end