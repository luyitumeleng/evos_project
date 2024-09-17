function offspring = uniformCrossover(population, crossoverRate)
        popSize = size(population, 1);
        numGenes = size(population, 2);
        offspring = population;
        for i = 1:2:popSize-1
            if rand() < crossoverRate
                mask = rand(1, numGenes) > 0.5;
                offspring(i, mask) = population(i+1, mask);
                offspring(i+1, mask) = population(i, mask);
            end
        end
        if mod(popSize, 2) ~= 0
            offspring(popSize, :) = population(popSize, :);
        end
    end