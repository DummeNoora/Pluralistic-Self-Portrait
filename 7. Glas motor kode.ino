#include <AFMotor.h>

// Number of steps per output rotation
// Change this as per your motor's specification
const int stepsPerRevolution = 48;

// connect motor to port #2 (M3 and M4)
AF_Stepper motor(stepsPerRevolution, 2);

void setup() {
  Serial.begin(9600);
  Serial.println("Stepper test!");

  motor.setSpeed(20);  // 10 rpm   
}

void loop() {
  Serial.println("Micrsostep steps");
  motor.step(100, FORWARD, MICROSTEP); 
 
}