% time2spike
% translate spike times to a series of 0's and 1's representing spikes for
% a given time bin dt

function spike = time2spike(time,dt)

spike = zeros(1,(20*60+1)/dt);
time = floor((time)/dt);
spike(time) = spike(time)+1;


