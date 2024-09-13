/*void settings()
{
  System.setProperty("jogl.disable.openglcore","false");
  size(800, 800, P3D);
  PImage grade = loadImage("gradeDeAltoFalante.jpg");
} */

void setup(){
   size(1200, 800, P3D);
}

int[] controle = {0,0,0};

void draw(){
  float s;
  s = 0.0;
  background(50);
  ambientLight(233,234,230);
  directionalLight(207, 216, 230, -103, 48, -60);
  float novoMouseX = map(mouseX,0,width,-width,width);
  float novoMouseY = map(mouseY,0,height,-height,height);
  
  noStroke();
  pushMatrix();
  controle = controleCamera(controle[0],controle[1],controle[2]);
  camera(334+controle[0], -78+controle[1], 874+controle[2], 415+novoMouseX, 138+novoMouseY, 17, 0.0, 0.6, 0.0);
  rotateX(0.00*PI);
  rotateY(0.00*PI);
  rotateZ(0.00*PI);
  /*camera(334, -78, 874, 415, 138, 17, 0.0, 0.6, 0.0);
  rotateX(0.00*PI);
  rotateY(0.00*PI);
  rotateZ(0.00*PI);*/
  fill(198,170,16);
  cubo(220,-50,168,260,75,163,0.4,0.0,0.0);
  caixaRadio();
  //caixa de som
  pushMatrix();
  translate(0,0,337);
  fill(2,2,2);
  for(int i=0; i< 5;i++){
    for( int j=0;j <5; j++){
      if((i==0 || i==4) &&(j==0 ||j==4)){
      }else{
        circle(81+ 35*i,130+35*j,22);
        circle(478+ 35*i,130+35*j,22);
      }  
    }
  }
  popMatrix();
  fill(53);
  drawCylinder(150,200, 290, 15,93,92,0,0,0);
  drawCylinder(550,200, 290, 15,93,92,0,0,0);
  //botão de frequência
  botaoFreq(s);
  /*pushMatrix();
  translate(573,15,330);
  rotateX(0.6);
  rotateZ(s*QUARTER_PI);
  triangle(-10,-7,0,-16,10,-7);
  popMatrix();
  fill(152,149,142);
  drawCylinder(573,40, 290, 8,18,92,0.7,0.0,s);
  */
  //botão de ligar
  fill(255,0,0);
  rampa(115,0, 250, 55,32,51,0.0,4.0,0.0);
  fill(0,255,0);
  rampa(590,0, 250, 55,32,51,0.0,4.0,0.0);
  fill(0,0,255);
  rampa(645,0, 250, 55,32,51,0.0,4.0,0.0);
  beginShape();
  popMatrix();
  }

int[] controleCamera(int X, int Y, int Z){
  int S=10;//sensibilidade do movimento;
  if(keyPressed == true){
    if(key ==' '){
      Y=Y-S;
    }
    if(key == CODED){
      if(keyCode == UP){
        Z=Z-S;
      }
      if(keyCode == DOWN){
        Z=Z+S;
      }
      if(keyCode == LEFT){
        X=X-S;
      }
      if(keyCode== RIGHT){
        X=X+S;
      }
      if(keyCode==CONTROL){
        Y=Y+S;
      }
    }
  }
  return new int[]{X, Y,Z};
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
  vertex(lX,0,-lZ); //<>// //<>// //<>// //<>// //<>// //<>//
  endShape();
   //<>// //<>//
  beginShape(); //<>// //<>//
  vertex(0,-lY,0); //<>// //<>//
  vertex(lX,0,0);
  vertex(lX,0,-lZ);
  endShape();
  
  beginShape();
  vertex(0,-lY,0); //<>// //<>// //<>// //<>//
  vertex(lX,0,0); //<>// //<>// //<>// //<>//
  vertex(0,0,0);
  endShape(); //<>// //<>//
   //<>// //<>//
  beginShape();
  vertex(0,0,0); //<>// //<>// //<>// //<>// //<>//
  vertex(0,0,-lZ); //<>// //<>//
  vertex(lX,0,-lZ); //<>//
  vertex(lX,0,0); //<>//
  endShape(); //<>//

  popMatrix();
} //<>// //<>//

void drawCylinder( int pX, int pY, int pZ, int sides, float r, float h, float rX, float rY, float rZ)
{ //<>// //<>//
    pushMatrix(); //<>// //<>//
    translate(pX,pY,pZ);
    rotateX(rX*QUARTER_PI); //<>//
    rotateY(rY*QUARTER_PI); //<>//
    rotateZ(rZ*QUARTER_PI);
    float angle = 360 / sides; //<>//
    float halfHeight = h / 2; //<>//
    // draw top shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight); //<>//
    }
    endShape(CLOSE);
    // draw bottom shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);    
    }
    endShape(CLOSE);
    
    // draw body
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, halfHeight);
      vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
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

void caixaRadio(){
  cubo(0,0, 0, 700,400,300,0.0,0.0,0.0);// corpo principipal
  cubo(50,-30, 50, 600,400,200,0.0,0.0,0.0);// corpo topo  
  cubo(50,50, -30, 600,300,360,0.0,0.0,0.0);// corpo frente/atras  
  cubo(-30,50, 50, 760,300,200,0.0,0.0,0.0);// corpo esqueda/direita
  //rampas parte de cima  
  rampa(50,50, 0, 600,50,30,0.0,0.0,0.0);  
  rampa(50,0, 50, 600,30,50,0.0,0.0,0.0);  
  rampa(650,0, 250, 600,30,50,0.0,4.0,0.0);  
  rampa(50,50, 300, 600,30,50,2.0,4.0,4.0);  
  rampa(650,0, 50, 200,30,50,0.0,-2.0,0.0);  
  rampa(700,50, 250, 200,30,50,6.0,0.0,2.0);  
  rampa(50,0, 250, 200,30,50,0.0,2.0,0.0);  
  rampa(0,50, 50, 200,30,50,2.0,4.0,2.0);
  //rampas lados  
  rampa(50,350, 300, 300,30,50,4.0,2.0,2.0);  
  rampa(650,50, 300, 300,30,50,0.0,6.0,2.0);  
  rampa(700,350, 250, 300,30,50,4.0,0.0,2.0);  
  rampa(700,50, 50, 300,30,50,0.0,0.0,2.0);  
  rampa(650,350, 0, 300,30,50,4.0,-2.0,2.0);  
  rampa(50,50, 0, 300,30,50,0.0,2.0,2.0);  
  rampa(0,50, 250, 300,30,50,0.0,4.0,2.0);  
  rampa(0,350, 50, 300,30,50,0.0,0.0,6.0);  
  //rampas parte de baixo
  rampa(650,350, 0, 600,50,30,0.0,0.0,4.0);  
  rampa(650,350, 300, 600,30,50,2.0,0.0,4.0);  
  rampa(700,350, 50, 200,30,50,2.0,0.0,2.0);  
  rampa(0,350, 250, 200,30,50,2.0,0.0,-2.0);
  //quinas parte de baixo
  quina(50,350, 0, 50,30,50,2.0,2.0,0.0);  
  quina(650,350, 0, 50,30,50,2.0,0.0,0.0);  
  quina(50,350, 300, 50,30,50,2.0,0.0,4.0);  
  quina(650,350, 300, 50,30,50,2.0,-2.0,4.0);  
  quina(700,350, 250, 50,30,50,2.0,0.0,2.0);  
  quina(700,350, 50, 50,30,50,0.0,0.0,2.0);  
  quina(0,350, 50, 50,30,50,2.0,0.0,-2.0);  
  quina(0,350, 250, 50,30,50,4.0,0.0,-2.0);  
  //quinas parte de cima
  quina(50,50, 0, 50,30,50,2.0,-4.0,0.0);  
  quina(50,0, 50, 50,30,50,0.0,2.0,0.0); 
  quina(650,50, 0, 50,30,50,0.0,-2.0,-2.0);
  quina(650,0, 250, 50,30,50,4.0,-2.0,4.0);
  quina(650,50, 300, 50,30,50,-2.0,0.0,0.0);
  quina(50,50, 300, 50,30,50,2.0,2.0,4.0);
  quina(700,50, 250, 50,30,50,4.0,0.0,2.0);
  quina(650,0, 50, 50,30,50,0.0,0.0,0.0);
  quina(700,50, 50, 50,30,50,2.0,4.0,-2.0);
  quina(0,50, 50, 50,30,50,0.0,0.0,-2.0);
  quina(50,0, 250, 50,30,50,4.0,0.0,-4.0);
  quina(0,50, 250, 50,30,50,2.0,4.0,2.0);
}

void botaoFreq(float s){
  pushMatrix();
  fill(246,6,249);
  translate(573,15,330);
  rotateX(0.6);
  rotateZ(s*QUARTER_PI);
  triangle(-10,-7,0,-16,10,-7);
  popMatrix();
  fill(152,149,142);
  drawCylinder(573,40, 290, 8,18,92,0.7,0.0,s);
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
