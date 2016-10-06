classdef gameAdversarial<Game
    %GAMEADVERSARIAL This is a concrete class defining a game where rewards
    %   are adversarially chosen.

    methods
        
        function self = gameAdversarial()
            self.nbActions = 2;
            self.totalRounds = 1000;
            
            self.tabR = ones(2,1000);
            self.tabR = repmat([0,0.98; 0.98,0], 1, self.totalRounds);
            self.N = 0;
        end
        
    end    
end

