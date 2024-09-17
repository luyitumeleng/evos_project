function startObstacleAvoidanceWithGA()
        
        net = yolov3ObjectDetector('tiny-yolov3-coco');
     
        % Initialize Raspberry Pi and Camera
        rpi = raspi();
        cam = cameraboard(rpi, 'Resolution', '640x480');
        pause(2);  % Allow camera to stabilize
        
        % Set up serial communication
        serialDevice = serialdev(rpi, '/dev/ttyACM0', 9600);
        
        % Initialize GA Parameters
        populationSize = 50;
        chromosomeLength = 5;  % Number of decisions (FBLRS)
        mutationRate = 0.2;
        crossoverRate = 0.6;
        numGenerations = 300;
        threshold = 0.95;  % Stop GA when fitness reaches this value
    
        % Initialize Population
        population = randi([0 1], populationSize, chromosomeLength);
    
        % Create the GUI
        createGA_GUI(cam, net, serialDevice, populationSize, chromosomeLength, mutationRate, crossoverRate, numGenerations, threshold);
    end
    