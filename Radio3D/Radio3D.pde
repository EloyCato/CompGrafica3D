void setup(){
  size(1600,1000,P3D);
}
//6
void draw(){
  background(50);
  translate(1000,500,100);
  //box(100,200,100);
  rotateX(0.0*HALF_PI);
  rotateY(-1.1*HALF_PI);
  rotateZ(0.0*HALF_PI);
  beginShape();
  vertex(-200,200,-200);
  vertex(200,200,-200);
  vertex(200,200,200);
  vertex(-200,200,200);
  endShape();
  
  beginShape();
  vertex(-200,-200,0);
  vertex(-200,200,200);
  vertex(200,200,200);
  vertex(200,-200,0);
  endShape();
  
  beginShape();
  vertex(-200,200,-200);
  vertex(200,200,-200);
  vertex(200,-200,0);
  vertex(-200,-200,0);
  endShape();
}

void cubo(int x, int y, int z, int pX,int pY, int pZ){
  pushMatrix();
  translate(pX,pY,pZ);
  box(x,y,z);
  popMatrix();
}

void cubo(int x, int y, int z, int pX,int pY, int pZ, float rX, float rY, float rZ){
  pushMatrix();
  translate(pX,pY,pZ);
  rotateX(rX*HALF_PI);
  rotateY(rY*HALF_PI);
  rotateZ(rZ*HALF_PI);
  box(x,y,z);
  popMatrix();
}

void rampa(int pX, int pY, int pZ, int lX, int lY, int lZ, float rX, float rY, float rZ){
  pushMatrix();
  translate(pX,pY,pZ);
  rotateX(rX*HALF_PI);
  rotateY(rY*HALF_PI);
  rotateZ(rZ*HALF_PI);
  beginShape();
  vertex(-lX/2,lY/2,-lZ/2);
  vertex(lX/2,lY/2,-lZ/2);
  vertex(lX/2,lY/2,lZ/2);
  vertex(-lX/2,lY/2,lZ/2);
  endShape();
  
  beginShape();
  vertex(-lX/2,lY/2,-lZ/2);
  vertex(lX/2,lY/2,-lZ/2);
  vertex(lX/2,lY/2,lZ/2);
  vertex(-lX/2,lY/2,lZ/2);
  endShape();
  
  beginShape();
  vertex(-200,200,-200);
  vertex(200,200,-200);
  vertex(200,-200,0);
  vertex(-200,-200,0);
  vertex(-lX/2,-lY/2,0);
  vertex(-lX/2,lY/2,lZ/2);
  vertex(lX/2,lY/2,lZ/2);
  vertex(-lX/2,-lY/2,0);
  endShape();
  
  popMatrix();
}
