function command = decodeChromosome(chromosome)
        % Decode chromosome to command
        % The 5 bits represent command choice
        % Define possible commands (e.g., forward, backward, left, right, stop)
        commandOptions = ['F', 'B', 'L', 'R', 'S']; 
    
        % Convert binary to decimal via custom function
        commandIndex = customBi2De(chromosome(1:3), 'left-msb') + 1;
        
        if commandIndex > length(commandOptions)
            commandIndex = mod(commandIndex, length(commandOptions)) + 1;
        end
        
        % Map the index to a command
        command = commandOptions(commandIndex);
    end