classdef policyUCB < Policy
    %POLICYUCB This is a concrete class implementing UCB.
   
    properties
        % Member variables
        S
        C
        t
        cb
        alpha
        nbActions
        lastAction
    end
    
    methods
        function init(self, nbActions)
            % Initialize
            self.nbActions = nbActions;
            self.S = zeros(1,self.nbActions);
            self.C = zeros(1,self.nbActions);
            self.lastAction = 1;
            self.alpha = 1;
            self.t = 0;
            self.cb = zeros(self.nbActions,1);
            
        end
        
        function action = decision(self)
            % Choose action
            if self.t < self.nbActions
                action = self.t+1;
            else
                for i = 1:self.nbActions
                    self.cb(i) = self.S(i)/self.C(i) + sqrt(self.alpha*log(self.t+1)/2/self.C(i));
                end
                [~,action] = max(self.cb);
            end  
            self.t = self.t+1;
%             figure(1);
%             plot(self.t,self.cb(1),'r.');
%             hold on;
%             plot(self.t,self.cb(2),'b.');
%             legend({'confidence bound of action1','confidence bound of action2'})
            self.lastAction = action;
%             drawnow;
        end
        
        function getReward(self, reward)
            % Update ucb
            self.S(self.lastAction) = self.S(self.lastAction) + reward;
            self.C(self.lastAction) = self.C(self.lastAction) + 1;
        end        
    end

end
