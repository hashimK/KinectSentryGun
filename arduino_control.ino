#include <Servo.h> 
// declare both servos
Servo xservo;
Servo yservo;
// setup the array of servo positions 
int nextServo = 0;
int servoAngles[] = {0,0};
void setup() {
// attach servos to their pins 
yservo.attach(11);
xservo.attach(10);
Serial.begin(9600);
}
void loop() {
if(Serial.available()){ 
int servoAngle = Serial.read();
servoAngles[nextServo] = servoAngle;
nextServo++;
if(nextServo > 1){
nextServo = 0;
}
xservo.write(servoAngles[0]); 
yservo.write(servoAngles[1]);
}
}
