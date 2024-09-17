 function mutatedPop = mutation(population, mutationRate)
        populationSize = size(population, 1);
        chromosomeLength = size(population, 2);
        mutatedPop = population; 
        
        for i = 1:populationSize
            for j = 1:chromosomeLength
                if rand < mutationRate               
                    mutatedPop(i, j) = 1 - population(i, j);
                end
            end
        end
    end