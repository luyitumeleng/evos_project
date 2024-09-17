  function decimal = customBi2De(binaryVector, msbFlag)
        % Convert a binary vector to a decimal number
        % msbFlag determines the ordering: 'left-msb' or 'right-msb'
    
        if nargin < 2
            msbFlag = 'left-msb'; % Default to 'left-msb'
        end
        
        if strcmp(msbFlag, 'left-msb')
            % Treat the most significant bit (MSB) on the left
            decimal = sum(binaryVector .* 2.^(length(binaryVector)-1:-1:0));
        else
            % Treat the most significant bit (MSB) on the right
            decimal = sum(binaryVector .* 2.^(0:length(binaryVector)-1));
        end
    end