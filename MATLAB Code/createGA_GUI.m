 function createGA_GUI(cam, detector, serialDevice, populationSize, chromosomeLength, mutationRate, crossoverRate, numGenerations, threshold)
    % Create a figure for the GUI
    fig = uifigure('Name', 'GA Optimization with YOLOv3');
    
    % Live feed display (axes)
    ax = uiaxes(fig, 'Position', [50, 200, 640, 480]);
    ax.Title.String = 'Live Feed';  % Set the title using the String property
    
    % Object detection feedback (label)
    detectionLabel = uilabel(fig, 'Position', [50, 700, 200, 20], 'Text', 'Detected: None');
    
    % Current GA Parameters (static text fields)
    uilabel(fig, 'Position', [750, 700, 200, 20], 'Text', 'GA Parameters:');
    mutationRateLabel = uilabel(fig, 'Position', [750, 670, 200, 20], 'Text', ['Mutation Rate: ' num2str(mutationRate)]);
    crossoverRateLabel = uilabel(fig, 'Position', [750, 640, 200, 20], 'Text', ['Crossover Rate: ' num2str(crossoverRate)]);
    
    % Commands sent to Arduino (text area)
    commandHistory = uitextarea(fig, 'Position', [750, 450, 200, 150], 'Editable', 'off');  
    
    % Selection and Crossover method dropdowns
    uilabel(fig, 'Position', [750, 400, 100, 20], 'Text', 'Selection Method:');
    selectionDropdown = uidropdown(fig, 'Position', [750, 370, 150, 20], ...
        'Items', {'Tournament', 'Roulette', 'Rank'}, 'Value', 'Tournament');
    
    uilabel(fig, 'Position', [750, 340, 100, 20], 'Text', 'Crossover Method:');
    crossoverDropdown = uidropdown(fig, 'Position', [750, 310, 150, 20], ...
        'Items', {'SinglePoint', 'TwoPoint', 'Uniform'}, 'Value', 'SinglePoint');
    
    % Start Button
    startBtn = uibutton(fig, 'Position', [750, 100, 100, 30], 'Text', 'Start', ...
        'ButtonPushedFcn', @(btn,event) startGA_Callback(ax, detectionLabel, commandHistory, ...
                                                         selectionDropdown, crossoverDropdown, ...
                                                         mutationRateLabel, crossoverRateLabel, ...
                                                         cam, detector, serialDevice, ...
                                                         populationSize, chromosomeLength, ...
                                                         mutationRate, crossoverRate, numGenerations, threshold));
    
    % Stop Button
    stopBtn = uibutton(fig, 'Position', [860, 100, 100, 30], 'Text', 'Stop', ...
        'ButtonPushedFcn', @(btn,event) stopGA_Callback());
end
