  function offspring = twopointCrossover(population, crossoverRate)
        popSize = size(population, 1);
        numGenes = size(population, 2);
        offspring = population;
        for i = 1:2:popSize-1
            if rand() < crossoverRate
                points = sort(randi([1, numGenes-1], 1, 2));
                offspring(i, points(1):points(2)) = population(i+1, points(1):points(2));
                offspring(i+1, points(1):points(2)) = population(i, points(1):points(2));
            end
        end
        if mod(popSize, 2) ~= 0
            offspring(popSize, :) = population(popSize, :);
        end
    end