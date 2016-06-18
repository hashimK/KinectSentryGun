import SimpleOpenNI.*; //importing the SimpleOpenNI library
SimpleOpenNI kinect; //object declaration
void setup() 
{
size(640*2, 480);
/*In Processing, the x-coordinate is the distance from the left edge of the Display Window and the y-coordinate is the distance from the top edge. Almost every Processing program has a size() function to set the width and height of the Display Window.*/
frameRate(100);
kinect = new SimpleOpenNI(this); //instantiation
kinect.enableDepth(); //access application for the depth image
kinect.enableRGB(); //access application for the rgb image
kinect.enableUser(); //enables user tracking
kinect.setMirror(true); //set it to false if the detected human is moving in the opposite direction
}
void draw() 
{
kinect.update(); //gets fresh data from the kinect
image(kinect.depthImage(), 0, 0); //displays the most recent depth image
image(kinect.rgbImage(), 640, 0); //displays the most recent rgb image
IntVector userList = new IntVector(); 
kinect.getUsers(userList); /*We ask OpenNI to give us a list of all of the users that it is currently tracking.*/
for (int i=0; i<userList.size(); i++) 
{ 
 int userId = userList.get(0);
 PVector position = new PVector();
 kinect.getCoM(userId, position); //finds each user’s center of mass
 kinect.convertRealWorldToProjective(position, position); /*we convert this position (CoM) into
projective coordinates so it matches our depth image and then use it to display a circle.*/
 fill(255, 0, 0);
 ellipse(position.x, position.y, 25,25);
}
}
