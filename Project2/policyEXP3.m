classdef policyEXP3 < Policy
    %POLICYEXP3 This is a concrete class implementing EXP3.
    
    properties
        % Define member variables
        nbActions % number of bandit actions
        w
        eta
        t
        lastAction
    end
    
    methods

        function init(self, nbActions)
            % Initialize member variables
            self.nbActions = nbActions;
            self.w = ones(1,self.nbActions);
            self.lastAction = self.nbActions(1);
            self.t = 0;
        end
        
        function action = decision(self)
            % Choose an action
            action = randsample(self.nbActions,1,true,self.w);
            self.lastAction = action;
            self.t = self.t+1;
        end
        
        function getReward(self, reward)
            % reward is the reward of the chosen action
            % update internal model
            self.eta = sqrt(log(self.nbActions)/(self.t*self.nbActions));
            
            % First we create the loss vector for GWM
            lossScalar = 1 - reward; % This is loss of the chosen action
            lossVector = zeros(1,self.nbActions);
            lossVector(self.lastAction) = lossScalar/(self.w(self.lastAction)/sum(self.w));
            
            % Do more stuff here using loss Vector
            self.w(self.lastAction) = self.w(self.lastAction)*exp(-self.eta*lossVector(self.lastAction));
        end        
    end
end