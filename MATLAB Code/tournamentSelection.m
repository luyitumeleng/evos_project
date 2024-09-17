function selectedPopulation = tournamentSelection(population, fitness)
        popSize = size(population, 1);
        selectedPopulation = zeros(size(population));
        for i = 1:popSize
            candidates = randperm(popSize, 2); % Alter tsize
            if fitness(candidates(1)) < fitness(candidates(2))
                selectedPopulation(i, :) = population(candidates(1), :);
            else
                selectedPopulation(i, :) = population(candidates(2), :);
            end
        end
    end