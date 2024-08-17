void
settings()
{
 System.setProperty("jogl.disable.openglcore","false");
 size(800, 800, P3D);
} 

void draw(){
  background(120);
  //noStroke();
  quina(274,338,100,288,283,173,-0.8,0.1,0.0);

}

void rampa(int pX, int pY, int pZ, int lX, int lY, int lZ, float rX, float rY, float rZ){
  pushMatrix();
  translate(pX,pY,pZ);
  rotateX(rX*QUARTER_PI);
  rotateY(rY*QUARTER_PI);
  rotateZ(rZ*QUARTER_PI);
  
  beginShape();
  vertex(lX/2,lY/2,lZ/2);
  vertex(-lX/2,lY/2,lZ/2);
  vertex(-lX/2,lY/2,-lZ/2);
  vertex(lX/2,lY/2,-lZ/2);
  endShape();
  
  beginShape();
  vertex(lX/2,lY/2,lZ/2);
  vertex(-lX/2,lY/2,lZ/2);
  vertex(-lX/2,-lY/2,-lZ/2);
  vertex(lX/2,-lY/2,-lZ/2);
  endShape();
  
  beginShape();
  vertex(-lX/2,-lY/2,-lZ/2);
  vertex(lX/2,-lY/2,-lZ/2);
  vertex(lX/2,lY/2,-lZ/2);
  vertex(-lX/2,lY/2,-lZ/2);
  endShape();
  
  beginShape();
  vertex(lX/2,lY/2,lZ/2);
  vertex(lX/2,lY/2,-lZ/2);
  vertex(lX/2,-lY/2,-lZ/2);

  endShape();
  
  beginShape();
  vertex(-lX/2,lY/2,lZ/2);
  vertex(-lX/2,-lY/2,-lZ/2);
  vertex(-lX/2,lY/2,-lZ/2);

  endShape();

  popMatrix();
}

void quina(int pX, int pY, int pZ, int lX, int lY, int lZ, float rX, float rY, float rZ){
  pushMatrix();
  translate(pX,pY,pZ);
  rotateX(rX*QUARTER_PI);
  rotateY(rY*QUARTER_PI);
  rotateZ(rZ*QUARTER_PI);
  
  beginShape();
  vertex(lX/2,-lY/2,lZ/2);
  vertex(-lX/2,lY/2,-lZ/2);
  vertex(lX/2,lY/2,-lZ/2);
  endShape();
  
  beginShape();
  vertex(lX/2,-lY/2,lZ/2);
  vertex(lX/2,lY/2,-lZ/2);
  vertex(lX/2,lY/2,lZ/2);
  endShape();
  
  beginShape();
  vertex(lX/2,-lY/2,lZ/2);
  vertex(lX/2,lY/2,lZ/2);
  vertex(-lX/2,lY/2,lZ/2);
  endShape();
  
  beginShape();
  vertex(lX/2,-lY/2,lZ/2);
  vertex(-lX/2,lY/2,-lZ/2);
  vertex(-lX/2,lY/2,lZ/2);
  endShape();
  
  beginShape();
  vertex(-lX/2,lY/2,-lZ/2);
  vertex(lX/2,lY/2,-lZ/2);
  vertex(lX/2,lY/2,lZ/2);
  vertex(-lX/2,lY/2,lZ/2);
  endShape();

  popMatrix();
}
