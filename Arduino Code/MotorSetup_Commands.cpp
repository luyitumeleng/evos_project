

// I made the following assuming that both the motors 
// of the robot are connected to a separate DPDT relays
// which have two sets of contacts, one set for each direction
// of the motor.

// But this can be adjusted accordingly based on your motor setup.


// Motor Pin Definitions
const int leftMotorForward = 9;
const int leftMotorBackward = 10;
const int rightMotorForward = 11;
const int rightMotorBackward = 12;
const int stopLightLeft = 7;
const int stopLightRight = 8;

void setup() {
  // Set motor pins as output
  pinMode(leftMotorForward, OUTPUT);
  pinMode(leftMotorBackward, OUTPUT);
  pinMode(rightMotorForward, OUTPUT);
  pinMode(rightMotorBackward, OUTPUT);
  pinMode(stopLightLeft, OUTPUT);
  pinMode(stopLightRight, OUTPUT);

  // Setup serial communication
  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) {
    char command = Serial.read(); // Read command var from Pi 

    if (command == 'F') {
      // Move forward
      digitalWrite(leftMotorForward, HIGH);
      digitalWrite(rightMotorForward, HIGH);
    } else if (command == 'B') {
      // Move backward
      digitalWrite(leftMotorBackward, HIGH);
      digitalWrite(rightMotorBackward, HIGH);
    } else if (command == 'L') {
      // Turn left
      digitalWrite(leftMotorBackward, HIGH);
      digitalWrite(rightMotorForward, HIGH);
    } else if (command == 'R') {
      // Turn right
      digitalWrite(leftMotorForward, HIGH);
      digitalWrite(rightMotorBackward, HIGH);
    } else if (command == 'S') {
      // Stop
      digitalWrite(leftMotorForward, LOW);
      digitalWrite(leftMotorBackward, LOW);
      digitalWrite(rightMotorForward, LOW);
      digitalWrite(rightMotorBackward, LOW);
      digitalWrite(stopLightLeft, HIGH);
      digitalWrite(stopLightRight, HIGH);
    }
  }
}
