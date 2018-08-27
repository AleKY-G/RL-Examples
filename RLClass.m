%% Lecture 2
%% Description
% This .m file solves the examples from Lecture 2. This includes the Markov
% Reward Process (MRP) and a Markov Decision Process (MDP). Please see the
% following link for the Markov diagram for the values used in these
% examples.
% 
% http://www0.cs.ucl.ac.uk/staff/d.silver/web/Teaching_files/MDP.pdf
clear all; close all; clc;
format compact; format long g;

%% Markov Reward Process
%Probability Matrix                            S
%                                              | 
%   S'-> C1   C2   C3   Pass Pub  FB   Sleep   V
MRP_P = [0.0, 0.5, 0.0, 0.0, 0.0, 0.5, 0.0;    %C1
         0.0, 0.0, 0.8, 0.0, 0.0, 0.0, 0.2;    %C2
         0.0, 0.0, 0.0, 0.6, 0.4, 0.0, 0.0;    %C3
         0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1;    %Pass
         0.2, 0.4, 0.4, 0.0, 0.0, 0.0, 0.0;    %Pub
         0.1, 0.0, 0.0, 0.0, 0.0, 0.9, 0.0;    %FB
         0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0];   %Sleep 

%Labels for the columns and rows
names = ["Class1","Class2","Class3","Pass","Pub","FaceBook","Sleep"];

%Creates the Markov model
mc = dtmc(MRP_P,'StateNames',names);
figure; graphplot(mc,'ColorEdges',true);

%Reward Matrix for Markov Reward Process
MRP_R = [-2; -2; -2; 10; 1; -1; 0];

v0_0 = MRP_SilverEx(MRP_P,MRP_R,0); %gamma = 0
v0_9 = MRP_SilverEx(MRP_P,MRP_R,.9); %gamma = .9
v1_0 = MRP_SilverEx(MRP_P,MRP_R,.9999999); %gamma = ~1

%% Markov Decision Process

%Probability Matrix
%rows are S, cols are S', and sheets are a
%Example) P(1,2,1) is the probability of going from Class1 (State 1) to
%Class2 (State 2) with the action of studying (Action 1)
P = zeros(5,5,9);
P(1,2,1) = 1; %Study
P(1,4,2) = 1; %Facebook
P(2,3,3) = 1; %Study
P(2,5,4) = 1; %Sleep
P(3,1,5) = .2; P(3,2,5) = 0.4; P(3,3,5) = .4; %Pub 
P(3,5,6) = 1; %Study
P(4,4,7) = 1; %Facebook
P(4,1,8) = 1; %Quit
P(5,5,9) = 1; %Sleep

%Reward Matrix
%rows are the state you are in and the columns are the rewards you recieve
%for completeing the action. Ex) R_sa(1,1) corresponds to being in class 1
%and completeing action 1 (Studying)
R_sa = zeros(5,9);
R_sa(1,1) = -2; %Study
R_sa(1,2) = -1; %Facebook
R_sa(2,3) = -2; %Study
R_sa(2,4) = 0;  %Sleep
R_sa(3,5) = 1;  %Pub
R_sa(3,6) = 10; %Study
R_sa(4,7) = -1; %Facebook
R_sa(4,8) = 0;  %Sleep
R_sa(5,9) = 0;  %Sleep

%Policy Matrix pi(a|s) = .5
policy = R_sa*0+.5;

%Solving for State-Values (v(s)) and Action-Values (q(s,a))
[v_pi q_pi] = MDP_SilverEx(P,R_sa,policy,.9999);