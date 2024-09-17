 function fitness = evaluateFitness(chromosome, obstacleDetected)
       
        if obstacleDetected
            fitness = -sum(chromosome); % Penalize if obstacle is detected
        else
            fitness = sum(chromosome); % Reward if no obstacle detected
        end
    end