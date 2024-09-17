function stopGA_Callback()
        global stopFlag;
        stopFlag = true;  % Set the flag to true to stop the GA loop
        disp('Stopping the GA and live feed...');
 end