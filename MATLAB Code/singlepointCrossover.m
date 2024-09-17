 function offspring = singlepointCrossover(population, crossoverRate)
        popSize = size(population, 1);
        numGenes = size(population, 2);
        offspring = population;
        for i = 1:2:popSize-1
            if rand() < crossoverRate
                point = randi([1, numGenes-1]);
                offspring([i, i+1], :) = [population(i, 1:point), population(i+1, point+1:end);
                                          population(i+1, 1:point), population(i, point+1:end)];
            end
        end
        if mod(popSize, 2) ~= 0
            offspring(popSize, :) = population(popSize, :);
        end
    end