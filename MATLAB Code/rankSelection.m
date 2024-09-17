function selectedPopulation = rankSelection(population, fitness)
        popSize = size(population, 1);
        [~, sortedId] = sort(fitness, 'ascend');
        ranks = 1:popSize;
        selectionProb = (popSize - ranks + 1) / sum(1:popSize);
        cumulativeProbs = cumsum(selectionProb);
        selectedPopulation = zeros(size(population));
        for i = 1:popSize
            r = rand();
            id = find(cumulativeProbs >= r, 1, 'first');
            selectedPopulation(i, :) = population(sortedId(id), :);
        end
    end
    