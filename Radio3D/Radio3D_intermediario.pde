void settings()
{
  System.setProperty("jogl.disable.openglcore","false");
  size(800, 600, P3D);
  PImage grade = loadImage("gradeDeAltoFalante.jpg");
} 
PImage grade;

int numBars = 15;
float[] barHeights = new float[numBars];
color[] barColors = new color[numBars];
float maxHeight = 60;
float barWidth = 240.0 / numBars;
float selectorPosX = 0;
boolean movingRight = true;
int boca_width = 250;
int boca_hight = 255;
int Cursor = 0;

void setup(){
   //size(800, 800, P3D);
   grade = loadImage("gradeDeAltoFalante.jpg");
   textureMode(NORMAL);
}

void draw(){
  background(50);
  ambientLight(233,234,230);
  directionalLight(207, 216, 230, -103, 48, -60);
  noStroke();
  pushMatrix();
  camera(350, -48, 888, 377, 189, 249, 0.0, 0.6, 0.0);
  rotateX(0.00*PI);
  rotateY(0.00*PI);
  rotateZ(0.00*PI);
  fill(198,170,16);
  cubo(220,-50,168,260,75,163,0.4,0.0,0.0);
  caixaRadio();
  //caixa des som
  drawCylinder(150,200, 290, 15,93,92,0,0,0,grade);
  drawCylinder(550,200, 290, 15,93,92,0,0,0,grade);
  fill(152,149,142);
  //botão de frequência
  drawCylinder(573,40, 290, 8,18,92,0.7,0.0,0.0);
  //botão de ligar
  fill(255,0,0);
  rampa(115,0, 250, 55,32,51,0.0,4.0,0.0);
  fill(0,255,0);
  rampa(590,0, 250, 55,32,51,0.0,4.0,0.0);
  fill(0,0,255);
  rampa(645,0, 250, 55,32,51,0.0,4.0,0.0);
  beginShape();
  
  translate(-54, -371, 332);
  // Desenhar a régua de frequências AM (acima) como traços
  stroke(255);
  strokeWeight(2);
  for (int i = 0; i <= numBars; i++) {
    float x = i * barWidth - 260 / 2 + barWidth/2;
    line(width/2 + x, height/2 + 40, width/2 + x, height/2 + 48);
  }
  
  // Desenhar a régua de frequências FM (abaixo) como traços
  for (int i = 0; i <= numBars; i++) {
    float x = i * barWidth - 260 / 2 + barWidth / 2;
    line(width/2 + x, height/2 , width/2 + x, height/2 + 10);
  }
  
  // Desenhar a barra de seleção
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(width/2 + selectorPosX, height/2 + 22, 5, 46);
  
  // Movimentação da barra de seleção
  if (movingRight) {
    selectorPosX += 2;
    if (selectorPosX > 120) movingRight = false;
  } else {
    selectorPosX -= 2;
    if (selectorPosX < -120) movingRight = true;
  }
  popMatrix();
  
  //pushMatrix();
  //translate(0, 0, 701);
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
  
  beginShape(); //<>// //<>// //<>// //<>//
  vertex(0,-lY,0); //<>// //<>// //<>// //<>// //<>//
  vertex(lX,0,0); //<>//
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

void drawCylinder( int pX, int pY, int pZ, int sides, float r, float h, float rX, float rY, float rZ, PImage img)
{
    pushMatrix();
    translate(pX,pY,pZ);
    rotateX(rX*QUARTER_PI);
    rotateY(rY*QUARTER_PI);
    rotateZ(rZ*QUARTER_PI);
    float xT, yT;
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // draw top shape
    beginShape();
    texture(img);
    textureMode(NORMAL);
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        xT=map(cos( radians( i * angle )),-1,1,0,1);
        yT=map(sin( radians( i * angle )),-1,1,0,1); //<>// //<>//
        vertex( x, y, -halfHeight,xT,yT); //<>// //<>// //<>//
    }
    endShape(CLOSE);
    // draw bottom shape
    beginShape(); //<>// //<>// //<>// //<>//
    texture(grade); //<>//
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        xT=map(cos( radians( i * angle )),-1,1,0,1);
        yT=map(sin( radians( i * angle )),-1,1,0,1);
        vertex( x, y, halfHeight,xT,yT);    
    }
    endShape(CLOSE);
    
    // draw body
    beginShape(TRIANGLE_STRIP);
    texture(grade);
    for (int i = 0; i < sides + 1; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      xT=map(cos( radians( i * angle )),-1,1,0,1);
      yT=map(sin( radians( i * angle )),-1,1,0,1);
      vertex( x, y, halfHeight,xT,yT);
      vertex( x, y, -halfHeight,xT,yT);
    }
    endShape(CLOSE);
    popMatrix();
}

void drawCylinder( int pX, int pY, int pZ, int sides, float r, float h, float rX, float rY, float rZ)
{
    pushMatrix();
    translate(pX,pY,pZ);
    rotateX(rX*QUARTER_PI);
    rotateY(rY*QUARTER_PI);
    rotateZ(rZ*QUARTER_PI);
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // draw top shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight); //<>// //<>//
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

void desenhaOlhosEMoca() {
  // Desenha olhos e boca baseados no estado do rádio
  if (ligado ) { // Se estiver ligado e sintonizado
    if ((AM || FM) && player != null) {
      if(player.getMetaData().fileName()=="radio_noise.mp3"){
        desenhaOlhosAbertos();
        desenhaBocaTriste();
      }else{
        desenhaOlhosFelizes();
        desenhaBocaFeliz();
      }
    }
    if(!AM && !FM){
      desenhaOlhosAbertos();
      desenhaBocaFechada();
    }
  } else {
    desenhaOlhosFechados();
    desenhaBocaFechada();
  }
}

void desenhaOlhosFechados() {
  // Olhos fechados estilo Mario
  fill(255);
  stroke(0);
  strokeWeight(5);
  line(150, 135, 210, 135);
  line(290, 135, 350, 135);
  //ellipse(180, 150, 60, 30); // Olho esquerdo
  //ellipse(320, 150, 60, 30); // Olho direito
  fill(0);
  //ellipse(180, 155, 30, 10); // Pupila olho esquerdo
  //ellipse(320, 155, 30, 10); // Pupila olho direito
}

void desenhaOlhosAbertos(){
  fill(255);
  stroke(0);
  strokeWeight(5);
  ellipse(180, 150, 80, 80);//Olho esquerdo
  ellipse(320, 150, 80, 80);//Olho direito
  fill(0);
  ellipse(180, 160, 40, 40);//Pupila olho esquerdo
  ellipse(320, 160, 40, 40);//Pupila olho direito
  fill(255);
  ellipse(186, 169, 20, 20);//Brilho olho esquerdo
  ellipse(314, 169, 20, 20);//Brilho olho direito
}

void desenhaOlhosFelizes(){
  fill(255);
  stroke(0);
  strokeWeight(5);
  ellipse(180, 150, 80, 80);//Olho esquerdo
  ellipse(320, 150, 80, 80);//Olho direito
  fill(0);
  ellipse(180, 150, 40, 40);//Pupila olho esquerdo
  ellipse(320, 150, 40, 40);//Pupila olho direito
  fill(255);
  ellipse(169, 144, 20, 20);//Brilho olho esquerdo
  ellipse(309, 144, 20, 20);//Brilho olho direito
}

void desenhaBocaFechada(){
  // Boca fechada estilo Mario
  stroke(0);
  strokeWeight(5);
  noFill();
  line(200, 250, 300, 250);
  //arc(250, 300, 100, 50, 0, PI); //Boca fechada
}

void desenhaBocaTriste(){
  // Boca triste estilo Mario
  fill(corpo);
  stroke(0);
  strokeWeight(5);
  arc(boca_width, boca_hight, 130, 60, PI, 2*PI); //Boca triste
  line(boca_width - 65, boca_hight, boca_width + 65, boca_hight); //Linha da boca triste
}

void desenhaBocaFeliz(){
  // Boca feliz estilo Mario
  fill(neon);
  stroke(0);
  strokeWeight(5);
  arc(boca_width, boca_hight, 130, 60, 0, PI); //Boca feliz
  line(boca_width - 65, boca_hight, boca_width + 65, boca_hight); //Linha da boca feliz
}
