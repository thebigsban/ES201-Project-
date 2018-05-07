%% Autoregressive Portion
%{
gamma = zeros(1,J) + 1;
gammanew = zeros(1,J);
iterations = 5;
power = [];
value = sum(gamma);
gammas = gamma;
for i = 1:iterations
    c = 1;
    for j = 1:M
        totaltemp = 0;
        for k = 1:length(spiketrains)
            temp = 0;
            if k-M*W+W*mod(j,M) +1> 0
            if nnz(spiketrains(floor(abs((j-0.01)/M))+1, (k-M*W+W*mod(j,M)+1):(k-M*W+W*mod(j,M)+W))) >= 1
                temp = nnz(spiketrains(floor(abs((j-0.01)/M))+1, (k-M*W+W*mod(j,M)+1):(k-M*W+W*mod(j,M)+W)));
                for l = 1:M
                    if nnz(spiketrains(floor(abs((l-0.01)/M))+1, (k-M*W+W*mod(l,M)+1):(k-M*W+W*mod(l,M)+W))) >= 1
                        if gamma(l) ~= 0
                            temp = temp * gamma(l)^nnz(spiketrains(floor(abs((l-0.01)/M))+1, (k-M*W+W*mod(l,M)+1):(k-M*W+W*mod(l,M)+W)));
                            %power = [power, nnz(spiketrains(floor(abs((l-0.01)/M))+1, (k-M*W+W*mod(l,M)+1):(k-M*W+W*mod(l,M)+W)))];
                        end
                    end
                end
            end
            end
            totaltemp = temp + totaltemp;
        end
        gammanew(j) = gamma(j) * (test(j)/(totaltemp * dt))^beta(j);
    end
    value = [value, sum(gammanew)];
    gammas = [gammas; gammanew]
    gamma = gammanew;
end

%}
%% Probing Connections

function gamma = gammafit(spiketrains, beta, test)

C = 2;
M = 12;
W = 10;
J = C * M;
dt = 0.001;
gammas = [];
gamma = zeros(1,J) + 1;
gammanew = zeros(1,J);
iterations = 3;
tic 
value = sum(gamma);
for i = 1:iterations
    for j = 1:J
        totaltemp = 0;
        for k = 1:length(spiketrains)
            temp = 0;
            if k-M*W+W*mod(j-1,M)+1> 0
            if nnz(spiketrains(floor(abs((j-0.01)/M))+1, (k-M*W+W*mod(j-1,M)+1):(k-M*W+W*mod(j-1,M)+W))) >= 1
                temp = nnz(spiketrains(floor(abs((j-0.01)/M))+1, (k-M*W+W*mod(j-1,M)+1):(k-M*W+W*mod(j-1,M)+W)));
                for l = 1:J
                    if k-M*W+W*mod(l-1,M)+1 > 0
                    if nnz(spiketrains(floor(abs((l-0.01)/M))+1, (k-M*W+W*mod(l-1,M)+1):(k-M*W+W*mod(l-1,M)+W))) >= 1
                        if gamma(l) ~= 0
                            temp = temp * gamma(l)^nnz(spiketrains(floor(abs((l-0.01)/M))+1, (k-M*W+W*mod(l-1,M)+1):(k-M*W+W*mod(l-1,M)+W)));
                        end
                    end
                    end
                end
            end
            end
            totaltemp = temp + totaltemp;
        end
        gammanew(j) = gamma(j) * (test(j)/(totaltemp * dt))^beta(j);
    end
    value = [value, sum(gammanew)];
    gamma = gammanew;
    gammas = [gammas; gamma];
end
toc