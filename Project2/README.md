Project 2 - Multi Armed Bandits

A multi-armed bandit problem (or, simply, a bandit problem) is a sequential allocation problem deﬁned by a set of actions. At each time step, a unit resource is allocated to an action and some observable payoﬀ is obtained. The goal is to maximize the total payoﬀ obtained in a sequence of allocations. The name bandit refers to the colloquial term for a slot machine (“one-armed bandit” in American slang). In a casino, a sequential allocation problem is obtained when the player is facing many slot machines at once (a “multi-armed bandit”) and must repeatedly choose where to insert the next coin. 

In project 1, we looked at the Prediction with Expert Advice (PWEA) problem. We will begin by understanding why naively applying Generalized Weighted Majority does not work in the bandit setting. We will then work through two classes of bandit algorithms - one that makes assumptions about nature (stochastic bandits) and one that does not (adversarial bandits). The goal of this project is to understand the behaviour of these algorithms and also understand which one to use in a real world application.

In this project, algorithms for Bandit Problems like GWM, EXP3 and UCB were implemented.
