//Necessary for OSC communication with Wekinator:
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;

float diameter = 40;
float posX = 400;
float posY = 400;

//Floats to receive three outputs from wekinator
float p1 = 0.5;
float p2 = 0.5;
float p3 = 0.5;

void setup(){
  size(800,800);
  stroke(0.0);
  ellipse(posX,posY,diameter,diameter);
  
  //Initialize OSC communication
  //listen for OSC messages on port 12000 (Wekinator default)
  oscP5 = new OscP5(this,12000); 
  
  //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  //dest = new NetAddress("127.0.0.1",6448); 
}
void oscEvent(OscMessage theOscMessage){
  if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
     if(theOscMessage.checkTypetag("fff")) { //Now looking for 2 parameters
        p1 = theOscMessage.get(0).floatValue(); //get this parameter
        p2 = theOscMessage.get(1).floatValue(); //get 2nd parameter
        p3 = theOscMessage.get(2).floatValue(); //get third parameters
        println("Received new params value from Wekinator: %f, %f, and %f",p1,p2,p3);  
      } else {
        println("Error: unexpected params type tag received by Processing");
      }
  }
}

void updateX(){
  diameter = (p1*100+p2*80+p3*30);
}
void draw(){
  background(p2*225,p3*200,227);
  updateX();
  ellipse(posX,posY,diameter,diameter);
  fill((p1*100+p3*100),33,p2*200);
}
