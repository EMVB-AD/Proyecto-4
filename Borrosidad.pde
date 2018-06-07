import gab.opencv.*;
import processing.video.*;

Capture Face;
OpenCV System;
int Resolt;

void setup() {
  size(640, 480);
  
  Face = new Capture(this, 640, 480);
  System = new OpenCV(this, 640, 480);  

  Face.start();
  noSmooth();
  Resolt = 20;
  background(0);
}

void draw() {
 System.loadImage(Face);
 System.calculateOpticalFlow();
  
 pushMatrix();
  noStroke();
  for(int y=0; y<480 ; y+= Resolt){
   for(int x=0; x<640 ; x+= Resolt){
    PVector COFF = System.getFlowAt(x,y);
    if(COFF.x * Resolt > 30 || COFF.y * Resolt > 30){
     fill(randomGaussian()*(COFF.x + COFF.y)*2,randomGaussian()*(COFF.x + COFF.y)*2,randomGaussian()*(COFF.x + COFF.y)*2);
    }
    else{
     fill(Face.pixels[x+y*640]);
    }
    rectMode(CORNER);
    rect(x+random(-COFF.x*Resolt,COFF.x*Resolt),y+random(-COFF.y*Resolt,COFF.y*Resolt),Resolt,Resolt);
   }
  }   
 popMatrix();

 fill(255);
 textSize(18);
 textAlign(RIGHT,TOP);
 text(frameRate,width-16,16);
 textAlign(CENTER,BOTTOM);
 text("Manten presionado 'Click izq' para cambiar la resolución",width/2,height-16);
 
 if(mousePressed && Resolt >= 2){
  if(mouseButton == LEFT){
   Resolt = (mouseX/8) + (mouseY/8);
  }
 }
 if(Resolt <= 1){
  Resolt = 2;
 }
}

void captureEvent(Capture c) {
  c.read();
}