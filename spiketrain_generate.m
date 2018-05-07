% generate spiketrain from indexes

function spiketrain = spiketrain_generate(indexes, binedges, Spike_timeline, dt)

spiketrain = [];
for i = 1:length(indexes)
    spiketrain = [spiketrain; time2spike(Spike_timeline{indexes(i)},dt)];
end


spiketrain = index(spiketrain, binedges);