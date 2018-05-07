% function to index each spike time by the bin edges


function index = index(spikes, binedges)

index = [];
for i = 1:length(binedges)
    index = [index, spikes(:, binedges(i,1):binedges(i,2))]; 
end