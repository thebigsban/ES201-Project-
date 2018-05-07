%% Repeat analysis with top 10 spike rate neurons

dt = 0.001;
nonzero = [];
betas = [];
tests = [];
for i = 1:4
    for j = i+1:5
    spiketrains = spiketrain_generate([maxIndex(i), maxIndex(j)], binedges, Spike_timeline, dt);
    
    [beta,test] = calcbeta(spiketrains);
    betas = [betas; beta];
    tests = [tests; test];
    nonzero = [nonzero; nnz(beta) - sum(isnan(beta))];
    end
end

plot(betas')
xlabel('j');
ylabel('\beta_{i,j}')
set(gca,'fontsize',13)


for i = 1:4
    for j = i+1:5
                spiketrains = spiketrain_generate([connections(i,1), connections(i,2)], binedges, Spike_timeline, dt);

        beta = betas(i,:);
        test = tests(i,:);

        gamma = gammafit(spiketrains, beta, test);

        gammas = [gammas; gamma];
        
    end
end