% Main File
load('Spike_timeline.mat'); %cell containing spike times
load('connections_translated.mat'); %array containing directed connections
load('binedges.mat'); %bins for indexing and removing silent time periods
load('maxIndex.mat'); %indexes for highest spike frequency neurons


%% If you would like to observe results 
load('betas_max.mat') %betas from connected neurons determined by intracellular array
load('gammas_10.mat') %gammas from connected neurons determined by intracellular array
plot(betas') 
plot(log(gammas')) 


load('betas_max.mat');%gammas from neurons with max spiking frequency
load('gamma_max1.mat');%gammas from neurons with max spiking frequency
plot(betas') 
plot(log(gammas_max1))


%% If you would like to run things yourself

betaEvaluate; %calculate betas for connected neurons
gammaLoop; %calculate gammas for connected neurons

plot(log(gammas'));

%for the 10 pairwise analysis for 5 top spiking neurons
betaGammaMax;


%note that both of these things save variables as beta and gamma so be
%careful