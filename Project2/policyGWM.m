classdef policyGWM < Policy
    %POLICYGWM This policy implementes GWM for the bandit setting.
    
    properties
        nbActions % number of bandit actions
        % Add more member variables as needed
        w % weight vector
        eta
        t
        lastAction
    end
    
    methods
        function init(self, nbActions)
            % Initialize any member variables
            self.nbActions = nbActions;
            
            % Initialize other variables as needed
            self.w = ones(1,self.nbActions);
            self.lastAction = self.nbActions(1);
            self.t = 0;
        end
        
        function action = decision(self)
            % Choose an action according to multinomial distribution
            action = randsample(self.nbActions,1,true,self.w);
            self.lastAction = action;
            self.t = self.t+1;
        end
        
        function getReward(self, reward)
            % Update the weights
            self.eta = sqrt(log(self.nbActions)/self.t);
            
            % First we create the loss vector for GWM
            lossScalar = 1 - reward; % This is loss of the chosen action
            lossVector = zeros(1,self.nbActions);
            lossVector(self.lastAction) = lossScalar;
            
            % Do more stuff here using loss Vector
            self.w(self.lastAction) = self.w(self.lastAction)*exp(-self.eta*lossVector(self.lastAction));
        end        
    end
end

