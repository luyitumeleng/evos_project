import serial
import time


try:
    ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
    print(f"Connected to {ser.port} at {ser.baudrate} baud.")
except serial.SerialException as e:
    print(f"Error opening serial port: {e}")
    exit()

def send_command(command):
    """Sends a command to the device via the serial port."""
    try:
        ser.write(command.encode())  # Send encoded command
        print(f"Command '{command}' sent.")
    except serial.SerialException as e:
        print(f"Failed to send command: {e}")

def read_data():
    """Reads incoming data from the serial port."""
    if ser.in_waiting > 0:
        incoming_data = ser.readline().decode('utf-8').strip()  # Read and decode data
        if incoming_data:
            print(f"Received: {incoming_data}")

try:
    # Keep the serial connection running
    while True:
        # Example: Continuously listen for incoming data from the device
        read_data()

        # You can also periodically send commands
        # send_command('F')  # Example of sending a command to the device
        # time.sleep(2)  # Adjust the sleep interval as needed

        time.sleep(0.1)  # Small delay to avoid CPU overuse

except KeyboardInterrupt:
    print("\nProgram interrupted by user.")

finally:
    if ser.is_open:
        ser.close()  # Close the serial port when done
        print(f"Serial port {ser.port} closed.")
