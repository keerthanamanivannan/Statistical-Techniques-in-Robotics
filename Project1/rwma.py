#!/usr/bin/env python
import matplotlib.pyplot as plt
import numpy as np
import math
import random
import IPython

def expert1(t):
	return 1

def expert2(t):
	return -1

def expert3(t):
	return 1 if (t%2 == 0) else -1

def expert4(t,weather):
	if t%5 is not 0:
		if weather=='sunny':
			return 1
		else:
			return -1
	else:
		if weather == 'sunny':
			return -1
		else:
			return 1

def stochastic(t):
	set = [-1,1]
	return random.choice(set)

def deterministic(t,flag,weather):
	if(flag):
		return 1 if (t%2 == 0) else -1
	else:
		return 1 if weather == 'sunny' else -1

def adversarial(w,h):
	i = w.index(max(w))
	return -h[i]

def randomized_weighted_majority(T):
	w = [1,1,1,1]
	#For Loss of Learner
	loss_algorithm = 0
	sum_loss = 0
	cum_loss = [0]*T

	#For Loss of Experts; cumulative loss is stored as list of lists
	loss_expert = [0]*4
	sum_loss_expert = [0]*4
	cum_loss_expert = [[0 for i in range (4)] for j in range(T)]
	eta = 0.1

	#WEIGHTED MAJORITY ALGORITHM
	for t in range(T):
		weather = random.choice(['sunny','rainy'])
		h = [expert1(t),expert2(t),expert3(t),expert4(t,weather)]
		y_pred = sample(w,h)
		#y_t = stochastic(t)
		#y_t = deterministic(t)
		#y_t = adversarial(w,h)
		y_t = deterministic(t,1,weather)

		for i in range(3):
			w[i] = w[i]*(1-(eta*(h[i]!=y_t)))

		#CALCULATE THE LEARNER'S CUMULATIVE LOSS
		loss_algorithm = 1 if y_pred!=y_t else 0
		sum_loss = sum_loss + loss_algorithm
		cum_loss[t] = sum_loss

		#CALCULATE EACH EXPERT'S CUMULATIVE LOSS
		for i in range(3):
			loss_expert[i] = 1 if h[i]!=y_t else 0
			
			sum_loss_expert[i] = sum_loss_expert[i] + loss_expert[i]
			cum_loss_expert[t][i] = sum_loss_expert[i]

	plot_loss(cum_loss, cum_loss_expert)
	plot_regret(cum_loss, cum_loss_expert,T)
	plt.show()

def sample(w,h):
	sum_weights = 0
	prob_weights = [0]*4
	sum_prob = 0

	sum_weights = math.fsum(w)
	for i in range(4):
		prob_weights[i] = 1.0*w[i]/sum_weights
		sum_prob = sum_prob + prob_weights[i]
		prob_weights[i] = sum_prob

	y = random.random()
	print str(y) + "\n"
	print "prob_weights: " + str(prob_weights) + "\n"
	for i in range(4):
		if y<prob_weights[i]:
			return i
		
def plot_loss(cum_loss, cum_loss_expert):
	plt.figure(1)
	print "plotting losses"
	Expert1, = plt.plot([row[0] for row in cum_loss_expert],'r-',label='Expert1')
	Expert2, = plt.plot([row[1] for row in cum_loss_expert],'b-',label = 'Expert2')
	Expert3, = plt.plot([row[2] for row in cum_loss_expert],'y-',label = 'Expert3')
	Expert4, = plt.plot([row[3] for row in cum_loss_expert],'k-',label = 'Expert4')
	Learner, = plt.plot(cum_loss,'g-',label = 'Learner')
	plt.legend([Expert1, Expert2, Expert3, Expert4, Learner],['Expert1','Expert2','Expert3','Expert4','Learner'])
	plt.xlabel('t')
	plt.ylabel('Cumulative Loss')
	#plt.title('Stochastic')
	#plt.title('Deterministic')
	#plt.title('Adversarial')
	plt.title('Deterministic with extra observation and expert')

def plot_regret(cum_loss,cum_loss_expert,T):
	print "plotting regret"
	best_loss_expert = [0]*T
	regret = [0]*T
	sum_regret = 0
	avg_regret = [0]*T
	#IPython.embed()
	for t in range(T):
		best_loss_expert[t] = min(cum_loss_expert[t])
		regret[t] = cum_loss[t] - best_loss_expert[t]
		#sum_regret = sum_regret + regret[t]
	
		avg_regret[t] = (1.0*regret[t])/(t+1)

	plt.figure(2)
	plt.plot(avg_regret,'r-')
	plt.xlabel('t')
	plt.ylabel('Average Regret')
	#plt.title('Stochastic')
	#plt.title('Deterministic')
	#plt.title('Adversarial')
	plt.title('Deterministic with extra observation and expert')

def main():
	T = 100
	randomized_weighted_majority(T)

if __name__ == '__main__':
	main()