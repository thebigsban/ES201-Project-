%% Loop through connected neurons

gammas = [];
for i = 1:length(connections)
    if nonzero(i) == 24
        spiketrains = spiketrain_generate([connections(i,1), connections(i,2)], binedges, Spike_timeline, dt);

        beta = betas(i,:);
        test = tests(i,:);

        gamma = gammafit(spiketrains, beta, test);

        gammas = [gammas; gamma];
        
    end
end

%{
gammas1 = gammas;
beta = betas(1,:);
test = tests(1,:);
gammafit;

beta = betas(3,:);
test = tests(3,:);
gammafit;

fig = figure();
plot(log(gammas1'));
xlabel('j');
ylabel('\alpha_{1,j}')

%}

