import SimpleOpenNI.*;
import processing.serial.*;
SimpleOpenNI kinect;
int xpos=0;
int ypos=0;
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
stroke(255,0,0);
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
fill(0,0,255);
ellipse(position.x, position.y, 25,25);
if (mousePressed && (mouseButton == LEFT)) 
{
 println("xpixel: "+position.x+"; ypixel: "+position.y);
}
arupdate(mouseX,mouseY);
}
}
void arupdate(float x, float y)
{
 strokeWeight(0.5);
 line(x,y,x+10,y);
 line(x,y,x-10,y);
 line(x,y,x,y+10);
 line(x,y,x,y-10);
 strokeWeight(2);
 line(x+10,y,x+25,y);
 line(x-10,y,x-25,y);
 line(x,y+10,x,y+25);
 line(x,y-10,x,y-25);
 noFill();
 ellipse(x,y,25,25);
 xpos=(int)map(x,0,640,180,0);
 ypos=(int)map(y,0,480,90,180);
 port.write(xpos);
 port.write(ypos);
 if(mousePressed && (mouseButton == RIGHT))
 {
 println("panservo: "+xpos + "; tiltservo: "+ypos);
 }
}
