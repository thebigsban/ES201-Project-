
function [beta,test] = calcbeta(spiketrains)

%spiketrains = con1;
C = 2;
M = 12;
W = 10;
J = C * M;

%calculate beta i,j
beta = [];
test = [];
for j = 1:J
    total = 0;
    for k = 1:length(spiketrains)
        if k-M*W+W*mod(j-1,M) > 0 
            if spiketrains(floor(abs((j-0.01)/M))+1,k) == 1
                if nnz(spiketrains(floor(abs((j-0.01)/M))+1, (k-M*W+W*mod(j-1,M)+1):(k-M*W+W*mod(j-1,M)+W))) >= 1
                    total = total+nnz(spiketrains(floor(abs((j-0.01)/M))+1, (k-M*W+W*mod(j-1,M)+1):(k-M*W+W*mod(j-1,M)+W)));
                end
            end
        end
    end
    test = [test,total];
end

test2 = [];
for j = 1:J
    total = 0;
    for k = 1:length(spiketrains)
        if k-M*W+W*mod(j-1,M) > 0 
        if spiketrains(floor(abs((j-0.01)/M))+1,k) == 1 %N_i,k:k+1
            if  nnz(spiketrains(floor(abs((j-0.01)/M))+1, (k-M*W+W*mod(j-1,M)+1):(k-M*W+W*mod(j-1,M)+W))) >= 1 %I_j,k
                total = total + nnz(spiketrains(floor(abs((j-0.01)/M))+1, (k-M*W+W*mod(j-1,M)+1):(k-M*W+W*mod(j-1,M)+W)))...
                    *sum(sum(spiketrains(:,(k-M*W+1):k)));
            end
        end
        end
    end
    test2 = [test2,total];
end
beta = test./test2;
%plot(beta)
