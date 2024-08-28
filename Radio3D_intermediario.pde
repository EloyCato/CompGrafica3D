void
settings()
{
 System.setProperty("jogl.disable.openglcore","false");
 size(800, 800, P3D);
} 

void draw(){
  background(120);
  camera(9, -77, 1243, 274, 199, 239, 0.0, 0.6, 0.0);
  rotateX(0.00*PI);
  rotateY(0.00*PI);
  rotateZ(0.00*PI);
  fill(177,47,47);//vermelho
  cubo(0,0, 0, 600,400,300,0.0,0.0,0.0);// corpo principipal
  fill(59,47,177);//azul
  cubo(50,-30, 50, 500,400,200,0.0,0.0,0.0);// corpo topo
  fill(69,177,47);//verde
  cubo(50,50, -30, 500,300,360,0.0,0.0,0.0);// corpo frente/atras
  fill(175,47,177);//roxo
  cubo(-30,50, 50, 660,300,200,0.0,0.0,0.0);// corpo esqueda/direita
  //rampas parte de cima
  fill(255,255,255);
  rampa(50,50, 0, 500,50,30,0.0,0.0,0.0);
  fill(255,255,255);
  rampa(50,0, 50, 500,30,50,0.0,0.0,0.0);
  fill(255,255,0);
  rampa(550,0, 250, 500,30,50,0.0,4.0,0.0);
  fill(255,255,0);
  rampa(50,50, 300, 500,30,50,2.0,4.0,4.0);
  fill(255,0,255);
  rampa(550,0, 50, 200,30,50,0.0,-2.0,0.0);
  fill(255,0,255);
  rampa(600,50, 250, 200,30,50,6.0,0.0,2.0);
  fill(0,0,255);
  rampa(50,0, 250, 200,30,50,0.0,2.0,0.0);
  fill(0,0,255);
  rampa(0,50, 50, 200,30,50,2.0,4.0,2.0);
  //rampas lados
  fill(252,255,3);
  rampa(50,350, 300, 300,30,50,4.0,2.0,2.0);
  fill(252,255,3);
  rampa(550,50, 300, 300,30,50,0.0,6.0,2.0);
  fill(255,0,255);
  rampa(600,350, 250, 300,30,50,4.0,0.0,2.0);
  fill(255,0,255);
  rampa(599,50, 50, 300,30,50,0.0,0.0,2.0);
  fill(255,255,255);
  rampa(550,350, 0, 300,30,50,4.0,-2.0,2.0);
  fill(255,255,255);
  rampa(50,50, 0, 300,30,50,0.0,2.0,2.0);
  fill(0,0,255);
  rampa(0,50, 250, 300,30,50,0.0,4.0,2.0);
  fill(0,0,255);
  rampa(0,350, 50, 300,30,50,0.0,0.0,6.0);
  //rampas parte de baixo
   fill(255,255,255);
  rampa(550,350, 0, 500,50,30,0.0,0.0,4.0);
  fill(255,255,0);
  rampa(550,350, 300, 500,30,50,2.0,0.0,4.0);
  fill(255,0,255);
  rampa(600,350, 50, 200,30,50,2.0,0.0,2.0);
  fill(0,0,255);
  rampa(0,350, 250, 200,30,50,2.0,0.0,-2.0);
  //quinas parte de baixo
   fill(255,255,255);
  quina(50,350, 0, 50,30,50,2.0,2.0,0.0);
  fill(255,255,255);
  quina(550,350, 0, 50,30,50,2.0,0.0,0.0);
  fill(255,255,0);
  quina(50,350, 300, 50,30,50,2.0,0.0,4.0);
  fill(255,255,0);
  quina(550,350, 300, 50,30,50,2.0,-2.0,4.0);
  fill(255,0,255);
  quina(600,350, 250, 50,30,50,2.0,0.0,2.0);
  fill(255,0,255);
  quina(600,350, 50, 50,30,50,0.0,0.0,2.0);
  fill(0,0,255);
  quina(0,350, 50, 50,30,50,2.0,0.0,-2.0);
  fill(0,0,255);
  quina(0,350, 250, 50,30,50,4.0,0.0,-2.0);
  //quinas parte de cima
   fill(255,255,255);
  quina(50,50, 0, 50,30,50,2.0,-4.0,0.0);
  fill(2,255,222);
  quina(50,0, 50, 50,30,50,0.0,2.0,0.0);
  fill(255,255,255);
  quina(550,50, 0, 50,30,50,0.0,-2.0,-2.0);
  fill(255,255,0);
  quina(550,0, 250, 50,30,50,4.0,-2.0,4.0);
  fill(255,255,0);
  quina(550,50, 300, 50,30,50,-2.0,0.0,0.0);
  fill(255,255,0);
  quina(50,50, 300, 50,30,50,2.0,2.0,4.0);
  fill(255,0,255);
  quina(600,50, 250, 50,30,50,4.0,0.0,2.0);
  fill(255,0,255);
  quina(550,0, 50, 50,30,50,0.0,0.0,0.0);
  fill(255,0,255);
  quina(600,50, 50, 50,30,50,2.0,4.0,-2.0);
  fill(0,0,255);
  quina(0,50, 50, 50,30,50,0.0,0.0,-2.0);
  fill(0,0,255);
  quina(50,0, 250, 50,30,50,4.0,0.0,-4.0);
  fill(0,0,255);
  quina(0,50, 250, 50,30,50,2.0,4.0,2.0);


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
