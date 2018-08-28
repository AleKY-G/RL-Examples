%% Lecture 3
%% Description
% This file solves the examples shown in Lecture 3 of Dr. Silver's lectures
% on Reinforcement Learning. Link for the powerpoint can be found below.
% 
% http://www0.cs.ucl.ac.uk/staff/d.silver/web/Teaching_files/DP.pdf
clear all; close all; clc;
format compact; format long g;

%% Small Grid World

% State Values v(s)
v_SGW = zeros(4,4);
%Probability Matrix
P = zeros(16,16,5); 
%Standing Still
P(1,1,5) = 1; P(16,16,5) = 1;
%Going Left
P(2:15,1:14,1) = eye(14); 
P(5,5,1) = 1; P(5,4,1) = 0;
P(9,9,1) = 1; P(9,8,1) = 0;
P(13,13,1) = 1; P(13,12,1) = 0;
%Going Right
P(2:15,3:16,2) = eye(14);
P(4,4,2) = 1; P(4,5,2) = 0;
P(8,8,2) = 1; P(8,9,2) = 0;
P(12,12,2) = 1; P(12,13,2) = 0;
%Going Up
P(2:4,2:4,3) = eye(3);
P(5:15,1:11,3) = eye(11);
%Going Down
P(13:15,13:15,4) = eye(3);
P(2:12,6:16,4) = eye(11);

%Reward Matrix pi(s|a) = .25 for all moving actions when the state is not
%in the two terminal positions
R = zeros(16,5); R(2:15,1:4) = -1;
R(2,1) = 0; R(15,2) = 0; R(5,3) = 0; R(12,4) = 0;
policy = R*0; policy(2:15,1:4) = .25;
% policy(2,:) = [1/3 1/3 0 1/3 0]; policy(3,:) = policy(2,:);
% policy(4,:) = [1/2 0 0 1/2 0];
% policy(5,:) = [0 1/3 1/3 1/3 0]; policy(9,:) = policy(5,:);
% policy(6,:) = [1/4 1/4 1/4 1/4 0]; policy(11,:) = policy(6,:);
% policy(7,:) = policy(6,:); policy(10,:) = policy(6,:);
% policy(8,:) = [1/3 0 1/3 1/3 0]; policy(12,:) = policy(8,:);
% policy(13,:) = [1/2 0 1/2 0 0];
% policy(14,:) = [1/3 1/3 1/3 0 0]; policy(15,:) = policy(14,:);
v_pi = zeros(16,1);
y = 1;
v_pinew = v_pi;
for h = 1:2
    for i = 1:16
        for j = 1:4
            v_pinew(i) = v_pinew(i)+policy(i,j)*R(i,j);
            for k = 1:16
               v_pinew(i) = v_pinew(i)+policy(i,j)*y*P(i,k,j)*v_pi(k); 
            end
        end
    end
end
v_pinew = reshape(v_pinew,4,4);