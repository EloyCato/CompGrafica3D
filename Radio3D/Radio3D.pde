import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
String currentStation = "";
AudioMetaData ProcuraRuido;

int numBars = 20;
float[] barHeights = new float[numBars];
color[] barColors = new color[numBars];
float maxHeight = 30;
float barWidth = 400.0 / numBars;
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
  camera(9, -77, 874, 274, 199, 239, 0.0, 0.6, 0.0);
  rotateX(0.06*PI);
  rotateY(-0.09*PI);
  rotateZ(0.02*PI);
  
  pg = createGraphics(880, 600);
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
  
  
  desenhaOlhosEMoca();
  translate(-23, -70, -287);
  
  // Desenhar a régua de frequências AM (acima) como traços
  stroke(255);
  strokeWeight(2);
  for (int i = 0; i <= numBars; i++){
    float x = i * barWidth - 503 / 2 + barWidth/2;
    line(width/2 + x, height/2 + 80, width/2 + x, height/2 + 70);
  }
  
  //Desenhar a régua de frequências FM (abaixo) como traços
  for (int i = 0; i <= numBars; i++) {
    float x = i * barWidth - 508 / 2 + barWidth / 2;
    line(width/2 + x, height/2 , width/2 + x, height/2 + 10);
  }
  
  // Desenhar a barra de seleção
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(width/2 + selectorPosX, height/2 + 40, 5, 80);
  
  // Movimentação da barra de seleção
  if (movingRight) {
    selectorPosX += 2;
    if (selectorPosX > 200) movingRight = false;
  } else {
    selectorPosX -= 2;
    if (selectorPosX < -200) movingRight = true;
  }
  popMatrix();  // Finaliza a orientação da rampa
  //cubo(50,50, -30, 500,300,360,0.0,0.0,0.0);// corpo frente/atras //Entre 50 e 550 em x ; Entre 50 e 350 em y
  translate(0, 0, 331);
  fill(corpo);
  rect(424, 131, 224, 41, 40); // controle de volume
  noFill();
  fill(128);
  rect(325+volumeLevel*33, 131, 53, 30, 24); // botão de volume
  rect(171, 198, 222, 254, 27); // saída de som maior
  line(333, 130, 513, 130);
  fill(255);
  stroke(0);
  for (int i = 0; i < 5; i++) { // Barras de indicação do volume
  rect(442 + 16 * i, 105 - (i * 5), 10, 9 * i);
  }
  
  fill(corpo2);
  rect(519, 191, 25, 25, 10); // botão AM
  rect(519, 224, 25, 25, 10); // botão FM
  fill(corpo);
  ellipse(428, 256, 100, 100); // controle de frequencia do rádio
  strokeWeight(4);
  stroke(0);
  line(469, 258, 387, 258); // botão de frequência
  line(430, 301, 429, 214); // botão de frequência
  fill(0);
  textSize(16);
  text("volume", 324, 81);
  textSize(12);
  fill(corpo2);
  noStroke();
  rect(338, 96, 14, -14, 2);
  rect(366, 96, 14, -14, 2);
  fill(0);
  text("-  |  +", 334, 100);
  //text("195.8Mhz", 393, 177);
  //text("188.5Mhz", 509, 377);
  text("FM", 511, 250);
  text("AM", 511, 175);
  text("ON/OFF", 150, -18);
  triangle(361+volumeLevel*14, 135, 470+volumeLevel*-131, 148, 358+volumeLevel*-18, 116); // seta de volume
  fill(250);
  stroke(neon);
  
  pg.beginDraw();
  pg.noFill();
  pg.stroke(neon);
  pg.rect(55, 66, 231, 261, 30); // contorno saída de som maior
  pg.line(825, 76, 734, 76);
  pg.strokeWeight(2);
  pg.fill(neon);
  pg.filter(BLUR, 0.7);
  pg.endDraw();
  image(pg, 0, 0);
  
  
  //New
  if (ligado == true) {
    stroke(0);
    strokeWeight(3);
    fill(neon);
    rect(104, 1, 41, 19, 28, 34, 0, 0); // botão de ligar
    rect(754, 147, 25, 25, 10); // botão AM
    rect(754, 184, 25, 25, 10); // botão FM
    
    if (AM == true) {
      fill(255,255,0);
      rect(754, 147, 25, 25, 10); // botão AM
    }
    if (FM == true) {
      fill(255,255,0);
      rect(754, 184, 25, 25, 10); // botão FM
    }
  }
  if (keyPressed == true) {
    if (ligado == true) {
      if (key == 'a' || key == 'A') {
        AM = true;
        FM = false;
        Cursor = 0;
        tuneRadio();
      } else if (key == 'f' || key == 'F') {
        FM = true;
        AM = false;
        Cursor = 0;
        tuneRadio();
      }
    }
  }
  sensibilidade=3;//mude o valor para cursor para aumentar a velocidade, apenas valores inteiros, preferência para valores que dividem 45 sem resto(1, 3, 5, 7, 9, etc...) para não gerar incosistência
  if (keyPressed == true) {
     if (AM == true) {
       if ((key== '4' || keyCode == LEFT) &&  Cursor > -45) {
         Cursor = Cursor - sensibilidade;
         tuneRadio();
       }
       if ((key== '6' || keyCode == RIGHT) && Cursor < 0) {
         Cursor = Cursor + sensibilidade;
         tuneRadio();
       }
     }
     if (FM == true) {
       if ((key== '6' || keyCode == RIGHT) && Cursor < 45) {
         Cursor = Cursor + sensibilidade;
         tuneRadio();
       }
       if ((key== '4' || keyCode == LEFT) && Cursor > 0) {
         Cursor = Cursor - sensibilidade;
         tuneRadio();
       }
     }
  }
  translate(567, 270);
  rotate(PI * Cursor / 45);
  fill(0);
  stroke(0);
  triangle(-10, -68, 0, -84, 10, -69); // seta que indica frequência
  line(0, -75, 0, 75); // botão de frequência
  line(-75, 0, 75, 0); // botão de frequência
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
  translate(0, 0, 331);
  
  fill(255);
  stroke(0);
  strokeWeight(5);
  line(80, 135, 120, 135);
  line(199, 135, 240, 135);
  //ellipse(180, 150, 60, 30); // Olho esquerdo
  //ellipse(320, 150, 60, 30); // Olho direito
  fill(0);
  //ellipse(180, 155, 30, 10); // Pupila olho esquerdo
  //ellipse(320, 155, 30, 10); // Pupila olho direito
}

void desenhaOlhosAbertos(){
  translate(0, 0, 331);
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
  translate(0, 0, 331);
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
  translate(0, 0, 335);
  stroke(0);
  strokeWeight(5);
  noFill();
  line(303, 176, 277, 176);
  //arc(250, 300, 100, 50, 0, PI); //Boca fechada
}

void desenhaBocaTriste(){
  translate(0, 0, 331);
  fill(corpo);
  stroke(0);
  strokeWeight(5);
  arc(boca_width, boca_hight, 130, 60, PI, 2*PI); //Boca triste
  line(boca_width - 65, boca_hight, boca_width + 65, boca_hight); //Linha da boca triste
}

void desenhaBocaFeliz(){
  translate(0, 0, 331);
  fill(neon);
  stroke(0);
  strokeWeight(5);
  arc(boca_width, boca_hight, 130, 60, 0, PI); //Boca feliz
  line(boca_width - 65, boca_hight, boca_width + 65, boca_hight); //Linha da boca feliz
}
