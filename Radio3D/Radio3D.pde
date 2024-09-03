int numBars = 20;
float[] barHeights = new float[numBars];
color[] barColors = new color[numBars];
float maxHeight = 60;
float barWidth = 500.0 / numBars;
float selectorPosX = 0;
boolean movingRight = true;
int sensibilidade;//sensibilidade da variação do cursor

void settings()
{
 System.setProperty("jogl.disable.openglcore","false");
 size(800, 600, P3D);
 for (int i = 0; i < numBars; i++) {
    float intensity = map(abs(i - numBars/2), 0, numBars/2, 255, 30); // Degradê mais forte nas extremidades
    barColors[i] = color(intensity, 255, intensity);  // Efeito fluorescente
    barHeights[i] = random(maxHeight / 4); // Inicializa as alturas
  }
} 

color neon = color(51, 232, 254);
color corpo = color(233, 31, 60);
color corpo2 = color(150, 10, 30);
PGraphics pg;
int boca_width = 250;
int boca_hight = 255;
int Cursor = 0;
boolean AM = false, FM = false, ligado = false;

// Variáveis de controle de volume
int volumeLevel = 1;
float[] volumeValues = {0.0, 0.25, 0.5, 0.75, 1.0};

void draw(){
  background(120);
  camera(9, -77, 839, 274, 199, 239, 0.0, 0.6, 0.0);
  rotateX(0.00*PI);
  rotateY(-0.01*PI);
  rotateZ(0.00*PI);
  fill(177,47,47);//vermelho
  cubo(0,0, 0, 600,400,300,0.0,0.0,0.0);// corpo principipal
  fill(59,47,177);//azul
  cubo(50,-30, 50, 500,400,200,0.0,0.0,0.0);// corpo topo
  fill(69,177,47);//verde
  cubo(50,50, -30, 500,300,360,0.0,0.0,0.0);// corpo frente/atras //Entre 50 e 550 em x ; Entre 50 e 350 em y
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
  
  pushMatrix();
  //background(20);
  lights();
  ambientLight(50, 50, 50);
  
  pushMatrix();// Posiciona e orienta a face da rampa
  translate(-113, -316, 224); // Posição da rampa
  rotateX(PI/6.4);          // Rotação em torno do eixo X
  rotateY(PI/37.8); 
  // Desenhar as barras do histograma
  for (int i = 0; i < numBars; i++) {
    float x = i * barWidth - 500 / 2 + barWidth / 2;
    float pulseFactor = map(abs(i-numBars/2), 0, numBars/2, 1, 1.5);  // Mais pulsação nas extremidades
    barHeights[i] = lerp(barHeights[i], random(maxHeight * pulseFactor), 0.1);
    
    pushMatrix();
    translate(width/2 + x, height/2 - 10 - barHeights[i] / 2);  // Somente pulsação para cima
    fill(barColors[i]);
    box(barWidth - 2, barHeights[i], 10);
    popMatrix();
  }
  popMatrix();
  // Desenhar a régua de frequências AM (acima) como traços
  stroke(255);
  strokeWeight(2);
  for (int i = 0; i <= numBars; i++) {
    float x = i * barWidth - 520 / 2 + barWidth/2;
    line(width/2 + x, height/2 + 80, width/2 + x, height/2 + 70);
  }
  
  // Desenhar a régua de frequências FM (abaixo) como traços
  for (int i = 0; i <= numBars; i++) {
    float x = i * barWidth - 520 / 2 + barWidth / 2;
    line(width/2 + x, height/2 , width/2 + x, height/2 + 10);
  }
  
  // Desenhar a barra de seleção
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(width/2 + selectorPosX, height/2 + 40, 5, 80);
  
  // Movimentação da barra de seleção
  if (movingRight) {
    selectorPosX += 2;
    if (selectorPosX > 250) movingRight = false;
  } else {
    selectorPosX -= 2;
    if (selectorPosX < -250) movingRight = true;
  }
  popMatrix();  // Finaliza a orientação da rampa
  //cubo(50,50, -30, 500,300,360,0.0,0.0,0.0);// corpo frente/atras //Entre 50 e 550 em x ; Entre 50 e 350 em y
  translate(0, 0, 331);
  fill(corpo);
  rect(400, 73, 510, 42, 40); // controle de volume
  noFill();
  line(410, 94, 500, 94);
  fill(100);
  rect(209+volumeLevel*33, 79, 53, 30, 13); // botão de volume
  fill(255);
  stroke(0);
  for (int i = 0; i < 5; i++) { // Barras de indicação do volume
  rect(552 + 16 * i, 65 - (i * 7), 10, 7 * i);
  }
  
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
