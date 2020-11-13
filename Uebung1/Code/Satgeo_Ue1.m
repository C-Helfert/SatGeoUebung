%% Satgeo Ü1
% Nadine & Ziqing

clc
close all
clear all

load('rhocoe.mat');

%% GOCE
a = 6378137+225e3;
I = deg2rad(96.6);
e = 0;
Omega = deg2rad(335);
w = deg2rad(273);
M = deg2rad(5);

[r,v] = kep2cart(I,Omega,w,M,e,a);