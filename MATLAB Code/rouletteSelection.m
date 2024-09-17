 function selectedPopulation = rouletteSelection(population, fitness)
        popSize = size(population, 1);
        totalFitness = sum(1 ./ (fitness + 1e-6)); % Avoid division by zero
        probs = (1 ./ (fitness + 1e-6)) / totalFitness;
        cumulativeProbs = cumsum(probs);
        selectedPopulation = zeros(size(population));
        for i = 1:popSize
            r = rand();
            id = find(cumulativeProbs >= r, 1, 'first');
            selectedPopulation(i, :) = population(id, :);
        end
    end