import SimpleOpenNI.*;
import processing.serial.*;
SimpleOpenNI kinect;
float xs=0;
float ys=0;
int panservo=0;
int tiltservo=0;
Serial port;
void setup() 
{
size(640, 480);
frameRate(100);
println(Serial.list());
port=new Serial(this,Serial.list()[0],9600);
kinect = new SimpleOpenNI(this);
kinect.enableDepth();
kinect.enableUser(); 
kinect.setMirror(true);
}
void draw() 
{
kinect.update();
image(kinect.depthImage(), 0, 0);
IntVector userList = new IntVector();
kinect.getUsers(userList);
for (int i=0; i<userList.size(); i++) { 
int userId = userList.get(0);
PVector position = new PVector();
kinect.getCoM(userId, position); 
kinect.convertRealWorldToProjective(position, position);
fill(255, 0, 0);
ellipse(position.x, position.y, 25,25);
arupdate(position.x, position.y);
}
}
void arupdate(float x, float y)
{
 xs=-0.0837*x+124.43;
 ys=-0.0364*y*y*y+7.8092*y*y-883.96*y+41389;
 panservo=(int) xs;
 tiltservo=(int) ys;
 port.write(panservo);
 port.write(tiltservo);
}
