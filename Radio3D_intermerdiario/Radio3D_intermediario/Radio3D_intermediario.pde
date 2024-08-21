void
settings()
{
 System.setProperty("jogl.disable.openglcore","false");
 size(800, 800, P3D);
} 

void draw(){
  background(120);
  camera(1077, -138, 30, 224, 181, 11, 0.0, 0.8, 0.0);
  rotateX(0.01*PI);
  rotateY(-0.02*PI);
  rotateZ(0.00*PI);
  fill(177,47,47);//vermelho
  cubo(0,0, 0, 600,400,300,0.0,0.0,0.0);// corpo principipal
  fill(59,47,177);//azul
  cubo(50,-30, 50, 500,400,200,0.0,0.0,0.0);// corpo topo
  fill(69,177,47);//verde
  cubo(50,50, -30, 500,300,360,0.0,0.0,0.0);// corpo frente/atras
  fill(175,47,177);//roxo
  cubo(-30,50, 50, 660,300,200,0.0,0.0,0.0);// corpo esqueda/direita
  fill(255,255,255);
  rampa(50,50, 0, 500,50,30,0.0,0.0,0.0);
  fill(39,114,48);
  rampa(50,0, 50, 500,30,50,0.0,0.0,0.0);
 
  
}

void rampa(int pX, int pY, int pZ, int lX, int lY, int lZ, float rX, float rY, float rZ){
  pushMatrix();
  translate(pX,pY,pZ);
  rotateX(rX*QUARTER_PI);
  rotateY(rY*QUARTER_PI);
  rotateZ(rZ*QUARTER_PI);
  
  beginShape();
  vertex(lX,0,-lZ);
  vertex(0,0,-lZ);
  vertex(0,-lY,0);
  vertex(lX,-lY,0);
  endShape();
  
  beginShape();
  vertex(0,-lY,0);
  vertex(lX,-lY,0);
  vertex(lX,0,0);
  vertex(0,0,0);
  endShape();
  
  beginShape();
  vertex(0,0,0);
  vertex(lX,0,0);
  vertex(lX,0,-lZ);
  vertex(0,0,-lZ);
  endShape();
  
  beginShape();
  vertex(lX,-lY,0);
  vertex(lX,0,0);
  vertex(lX,0,-lZ);

  endShape();
  
  beginShape();
  vertex(0,-lY,0);
  vertex(0,0,0);
  vertex(0,0,-lZ);

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
  vertex(0,0,0);
  vertex(0,-lY,0);
  vertex(0,0,-lZ);
  endShape();
  
  beginShape();
  vertex(0,0,-lZ);
  vertex(0,-lY,0);
  vertex(lX,0,-lZ);
  endShape();
  
  beginShape();
  vertex(0,-lY,0);
  vertex(lX,0,0);
  vertex(lX,0,-lZ);
  endShape();
  
  beginShape();
  vertex(0,-lY,0);
  vertex(lX,0,0);
  vertex(0,0,0);
  endShape();
  
  beginShape();
  vertex(0,0,0);
  vertex(0,0,-lZ);
  vertex(lX,0,-lZ);
  vertex(lX,0,0);
  endShape();

  popMatrix();
}

void cubo(int pX, int pY, int pZ, int lX, int lY, int lZ, float rX, float rY, float rZ){
  pushMatrix();
  translate(pX,pY,pZ);
  translate(lX/2,lY/2,lZ/2);
  rotateX(rX*QUARTER_PI);
  rotateY(rY*QUARTER_PI);
  rotateZ(rZ*QUARTER_PI);
  box(lX, lY,lZ);
  popMatrix();
}
