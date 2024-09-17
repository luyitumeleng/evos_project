 % Function to send command to Raspberry Pi 
    function sendCommand(serialObj, command)
        % Convert the command to uint8 and send it to the Raspberry Pi via serial
        try
            % Convert the string command to uint8
            data = uint8(command);  % Convert the command 'F', 'B',  to uint8
            
            % Write the data to the serial device
            write(serialObj, data, 'uint8');  % Send data as 'uint8' precision
            
            disp(['Command sent: ' command]);
        catch exception
            disp(['Failed to send command: ' getReport(exception)]);
        end
    
        clear serialObj; %Closes connection for resource management
    end
    