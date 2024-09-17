function startGA_Callback(ax, detectionLabel, commandHistory, selectionDropdown, crossoverDropdown, ...
                          mutationRateLabel, crossoverRateLabel, cam, detector, serialDevice, ...
                          populationSize, chromosomeLength, mutationRate, crossoverRate, numGenerations, threshold)
    global stopFlag
    stopFlag = false;
    
    % Initialize Population
    population = randi([0 1], populationSize, chromosomeLength);
    
    % Fetch selected selection and crossover methods from the dropdown
    selectedMethod = selectionDropdown.Value;  % e.g., 'Tournament'
    crossoverMethod = crossoverDropdown.Value;  % e.g., 'Single Point'
    
    % Update GA parameter display
    mutationRateLabel.Text = ['Mutation Rate: ' num2str(mutationRate)];
    crossoverRateLabel.Text = ['Crossover Rate: ' num2str(crossoverRate)];
    
    % Initialize video player for live feed
    videoPlayer = vision.VideoPlayer('Position', [100, 100, 640, 480]);
    
    for generation = 1:numGenerations
        % % Check if manual stop has been triggered
        if stopFlag
            disp('GA manually stopped.');
            break;
        end
        
        % Capture frame from Raspberry Pi camera
        img = snapshot(cam);
        
        % Perform object detection using YOLO (use vision-specific step function)
        [bboxes, scores, labels] = detect(detector, img);

        % Determine if an obstacle is detected based on bounding boxes
        obstacleDetected = ~isempty(bboxes);

        % Annotate detections on the image
        detectedImg = insertObjectAnnotation(img, 'rectangle', bboxes, cellstr(labels));

        % Display the image with detections
        step(videoPlayer, detectedImg);

        % Evaluate fitness for each chromosome
        fitnessValues = arrayfun(@(x) evaluateFitness(x, obstacleDetected), population);

        % Fetch selected selection and crossover methods from the dropdown
        selectedMethod = lower(selectionDropdown.Value);  % e.g., 'tournament'
        crossoverMethod = lower(crossoverDropdown.Value);  % e.g., 'twoPoint'

        % Dynamically call the correct selection and crossover functions
        selectedPopulation = feval([selectedMethod 'Selection'], population, fitnessValues);  % e.g., tournamentSelection
        newPopulation = feval([crossoverMethod 'Crossover'], selectedPopulation, crossoverRate);  % e.g., twoPointCrossover

        % Apply mutation
        population = mutation(newPopulation, mutationRate);

        % Get Best Chromosome and Send Command
        [~, bestIndex] = max(fitnessValues);
        bestChromosome = population(bestIndex, :);
        command = decodeChromosome(bestChromosome);  % Decode to command
        sendCommand(serialDevice, command);  % Send command to Arduino via serial

        % Plot real-time performance
        hold(ax, 'on');
        plot(ax, generation, max(fitnessValues), 'bo');
        
        % Break if satisfactory solution is found
        if max(fitnessValues) > threshold
            % break;
        end

        % Small delay for real-time processing
        pause(0.1);
    end
    
    release(videoPlayer);  % Release video player resources
end
