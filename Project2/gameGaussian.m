classdef gameGaussian < Game
    %GAMEGAUSSIAN This is a concrete class defining a game where rewards a
    %   are drawn from a gaussian distribution.
    
    methods
        function self = gameGaussian(nbActions, totalRounds) 
            % Input
            %   nbActions - number of actions
            %   totalRounds - number of rounds of the game
            
            self.nbActions = nbActions;
            self.totalRounds = totalRounds;
            self.N = 0;
            s = 1*ones(nbActions,totalRounds);
            for i=1:nbActions
                mu = rand();
                sigma = rand();
                for t = 1:totalRounds
                    s(i,t) = normrnd(mu,sigma);
                    while s(i,t) < 0 || s(i,t) > 1
                        s(i,t) = normrnd(mu,sigma); %rejection sampling
                    end
                end
            end
            self.tabR = s;
        end
    end    
end
