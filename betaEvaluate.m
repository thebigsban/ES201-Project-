% testing which connections are evaluatable by calculating betas
dt = 0.001;
nonzero = [];
betas = [];
tests = [];
for i = 1:length(connections)
    spiketrains = spiketrain_generate([connections(i,1), connections(i,2)], binedges, Spike_timeline, dt);
    
    [beta,test] = calcbeta(spiketrains);
    betas = [betas; beta];
    tests = [tests; test];
    nonzero = [nonzero; nnz(beta) - sum(isnan(beta))];
end


fig =figure();
plot(betas')
xlabel('j');
ylabel('\beta_{i,j}')
saveas(fig, 'betas.png');


fig =figure();
plot(sort(nonzero))
xlabel('Number');
ylabel('Nonzero \beta Terms')
saveas(fig, 'betasnnz.png');
