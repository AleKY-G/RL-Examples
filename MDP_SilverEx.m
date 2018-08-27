function [v_pi,q_pi] = MDP_SilverEx(P,R,policy,y)
% This function is the Markov Reward Process described in Deepmind's
% lectures on Reinforcement Learning. This example comes from lecture 2.
%
% Inputs:   P - Probability  Matrix
%           R - Reward Matrix
%           policy - Probability Matrix of taking each action
%           y - gamma
% 
% Outputs:  v - State-Values of the environment
%           q - Action-Values of the environment
       %C1 C2 C3 FB Sleep
P_pi = P.*policy;

R_pi = sum(R.*policy,2);

v_pi = (eye(size(P_pi,1))-y*P_pi)\R_pi;
q_pi = 0;
end
