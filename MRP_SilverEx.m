function v = MRP_SilverEx(P, R, y)
% This function is the Markov Reward Process described in Deepmind's
% lectures on Reinforcement Learning. This example comes from lecture 2.
%
% Inputs:   P - Probability  Matrix
%           R - Reward Matrix
%           y - gamma
% 
% Outputs:  v - State-Values of the environment
    
    %State-Values
    v = (eye(7)-y*P)\R; 
end

