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

%Error checking
if(numel(size(P)) ~= 3)
    error('MyComponent:incorrectType',...
        'Error. \nProbability Matrix is not 3-D');
end
if(size(P,1) ~= size(P,2))
    error('MyComponent:incorrectType',...
        ['Error. \nThe number of rows and colums are not equal'...
        '\nRows: %i =/= %i: Cols'],size(P,1),size(P,2));
end
if(size(policy) ~= size(R))
     error('MyComponent:incorrectType',...
        ['Error. \nThe size of R must be equal to the policy'...
        '\nR: %i,%i =/= %i,%i: Policy'],size(R,1),size(R,2),...
        size(policy,1),size(policy,2));
end

%Find the Policy's Probability Matrix
P_pi = zeros(size(P,1),size(P,2));

for i = 1:size(P,3)
    P_pi = P_pi+policy(:,i).*P(:,:,i);
end

%Find the Policy's Reward Matrix
R_pi = sum(R.*policy,2);

%Find the State-Values
v_pi = (eye(size(R_pi,1))-.9999*P_pi)\R_pi;

%Find the Action-Value Pairs
q_pi = R;
for i = 1:size(P,2)
    Ptemp = reshape(P(:,i,:),size(P,1),size(P,3));
    q_pi = q_pi+y*Ptemp.*v_pi(i);
end
end
