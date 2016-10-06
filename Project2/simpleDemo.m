%% This script applies a random policy on a constant game
clc;
close; 
clear all;

%% Initializing values 
%totalRounds = 1000;
%nbActions = 10;

%% Set the game
%game = gameConstant();
%game = gameGaussian(nbActions,totalRounds);
game = gameAdversarial();

% Latencies
% load('data/univLatencies.mat');
% game = gameLookupTable(univ_latencies,1);
% totalRounds = size(univ_latencies,2);

% Planner
% load('data/plannerPerformance.mat');
% game = gameLookupTable(planner_performance,1);
% totalRounds = size(planner_performance,2);

%% Get a set of policies to try out
% policies = {policyConstant(), policyRandom(), policyGWM(), policyEXP3(),policyUCB()};
% policy_names = {'policyConstant', 'policyRandom','policyGWM','policyEXP3','policyUCB'};

% policies = {policyEXP3(), policyUCB()};
% policy_names = {'policyEXP3', 'policyUCB'};

policies = {policyUCB()};
policy_names = {'policyUCB'};

%% Run the policies on the game
figure;
hold on;

for k = 1:length(policies)
    policy = policies{k};
    game.resetGame();
    [reward, action, regret] = game.play(policy);
    fprintf('Policy: %s Reward: %.2f\n', class(policy), sum(reward));
%     plot(regret);
    plot(action);
    axis([1,game.totalRounds,0,game.nbActions+1])
end
 legend(policy_names);
% title('Regret Bound');
% xlabel('No. of Rounds of the Game');
% ylabel('Regret');

title('Actions Chosen');
xlabel('No. of Rounds of the Game');
ylabel('Action');
