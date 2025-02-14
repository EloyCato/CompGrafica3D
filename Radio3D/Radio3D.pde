/*  Projeto final da disciplina de Computação Grafica;

    Estudantes: Eloy Carlos & Matheus Batista;
    
    Legenda:
              H e K - Movimento horizontal da camera em torno de y;
              U e J - Movimento em z;
              
              Ctrl e Espaço- Movimento em torno de y;
              
              RIGHT-> e <-LEFT - Sintonização;
*/

import ddf.minim.*;      
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
String currentStation = "";
AudioMetaData ProcuraRuido;

String ruido = "radio_noise.mp3";
String startSong = "Pikachu.mp3";

// Lista de URLs de rádios online
String[] AMStations = {
  "nd","nd",
  "http://stream.whus.org:8000/whusfm", // Exemplo de estação AM
  "nd","nd","nd",                                 //Estacao nao definida
  "http://ice1.somafm.com/groovesalad-128-mp3", // Exemplo de estação AM
  "nd","nd","nd"
};
String[] FMStations = {
  "nd","nd","nd",
  "http://stream.radioparadise.com/mp3-128", // Exemplo de estação FM
  "nd","nd","nd",
  "http://ice1.somafm.com/groovesalad-128-mp3", // Exemplo de estação FM
  "nd","nd"
};

void setup(){
   size(800, 600, P3D); 
   minim = new Minim(this);
}
float s = 0.0;
int sensibilidade = 3;
int[] controle = {0,0,0};
color neon = color(51, 232, 254);

float maxHeight = 60;

boolean movingRight = true;
int boca_width = 250;
int boca_hight = 255;
int Cursor = 0;
boolean AM = false, FM = false, ligado = false;
int volumeLevel = 1;
float[] volumeValues = {0.0, 0.25, 0.5, 0.75, 1.0};
// Variáveis globais para a rotação e a posição do cursor da barra de seleção
float anguloRotacao = 0;

PFont fonte;
float time = 0; // Controla o tempo para a função sin()
float frequency = 2; // Controla a frequência da pulsação

void draw(){
  
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
        circle(81+ 35*i,130+35*j,12);
        circle(478+ 35*i,130+35*j,12);
      }  
    }
  }
  popMatrix();
  fill(255,0,0);
  drawCylinder(150,200, 290, 15,93,92,0,0,0);
  drawCylinder(550,200, 290, 15,93,92,0,0,0);
  //botão de frequência
  botaoFreq(s);
  botaoVol(volumeLevel);
  pushMatrix();
  translate(-51,-11,284);
  rotateX(1.3*QUARTER_PI);
  
  fonte = createFont("Arial", 15, true);
  textFont(fonte);
  text("ON|OF", 115, 0);
  popMatrix();
  
  pushMatrix();
  translate(435,328,331);
  fill(236, 223, 172, 198);
  fonte = createFont("Georgia Negrito Itálico", 18, true);
  textFont(fonte);
  text("RadioChu", 115, 10);
  popMatrix();
  
  //botão de ligar
  fill(255,0,0);
  rampa(115,0, 250, 55,32,51,0.0,4.0,0.0);
  fill(0,255,0);
  rampa(590,0, 250, 55,32,51,0.0,4.0,0.0);
  fill(0,0,255);
  rampa(645,0, 250, 55,32,51,0.0,4.0,0.0);
  beginShape();
  
  pushMatrix();
  CursorControl();
  desenhaFreqControl();
  popMatrix();
  
  antenaRaio();
  
  if (ligado ) { // Se estiver ligado e sintonizado
    if ((AM || FM) && player != null) {
      if(player.getMetaData().fileName() != "radio_noise.mp3"){
        raioEfect();
        raioEfect2();
      }
    }
  }
  
  // Rosto criativo nas coordenadas (50, 50, -30)
  pushMatrix();
  translate(109, -33, 336);
  //desenhaRosto();
  desenhaFace();
  popMatrix();
  
  if (ligado == true) {
    stroke(0);
    strokeWeight(2);
    fill(neon);
    rampa(115,0, 250, 55,32,51,0.0,4.0,0.0); // botão de ligar
    rampa(590,0, 250, 55,32,51,0.0,4.0,0.0); // botão AM
    rampa(645,0, 250, 55,32,51,0.0,4.0,0.0); // botão FM
    
    if (AM == true) {
      fill(255,255,0);
      rampa(590,0, 250, 55,32,51,0.0,4.0,0.0); // botão AM
    }
    if (FM == true) {
      fill(255,255,0);
      rampa(645,0, 250, 55,32,51,0.0,4.0,0.0); // botão FM
    }
  }
    if (ligado == true) {
      if (key == 'a' || key == 'A') {
        AM = true;
        FM = false;
        s = 0;
        Cursor = 0;
        selectorPosX = 1;
        tuneRadio();
      } else if (key == 'f' || key == 'F') {
        FM = true;
        AM = false;
        s = 0;
        Cursor = 0;
        selectorPosX = 1;
        tuneRadio();
      }
    }
  popMatrix();
}

int[] controleCamera(int X, int Y, int Z){
  int S=10;//sensibilidade do movimento;
    if (keyPressed){
      if(key ==' '){
        Y=Y-S; 
      }
      if(key =='u'){
          Z=Z-S;
      }
      if(key == 'j'){
          Z=Z+S;
      }
      if(key == 'h'){
        X=X-S;
      }
      if(key== 'k'){
        X=X+S;
      }
      if(key == CODED){
        if(keyCode==CONTROL){
          Y=Y+S;
        }
      }
 
    }
  return new int[]{X, Y,Z};
}
int numBars = 19;
float barWidth = 235.0 / numBars;
float[] barHeights = new float[numBars];
color[] barColors = new color[numBars];
float selectorPosX = 1;
void desenhaFreqControl(){
  
  pushMatrix();

  translate(22, -292, 245);
  rotateX(0.4 * QUARTER_PI);
  
  // Definir o ponto central manualmente (substituindo width/2 e height/2)
  float centroX = 320; // Substituto para width/2 (ajuste conforme o tamanho real da tela)
  float centroY = 240; // Substituto para height/2 (ajuste conforme o tamanho real da tela)
  
  // Desenhar a régua de frequências AM (acima) como traços
  stroke(255);
  strokeWeight(2);
  
  beginShape();
  for (int i = 0; i <= numBars; i++){
    float x = i * barWidth - 110;
    line(centroX + x, centroY + 40, centroX + x, centroY + 50);
  }
  
  // Desenhar a régua de frequências FM (abaixo) como traços
  for (int i = 0; i <= numBars; i++) {
    float x = i * barWidth - 110;
    line(centroX + x, centroY, centroX + x, centroY + 10);
  }
  
  // Desenhar a barra de seleção
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(centroX + selectorPosX, centroY + 25, 6, 50);
  
  endShape();
  popMatrix();
}
float selectorMin = -120; // Limite mínimo para o movimento do cursor
float selectorMax = 120;  // Limite máximo para o movimento do cursor
// Função que detecta teclas pressionadas e movimenta o botão e o cursor da barra de seleção                         
void CursorControl() {  
  if (ligado == true) { 
    if(keyPressed){
      if(FM == true){ 
         if ( (key == CODED && keyCode == RIGHT) || key == '6') {  
           if (selectorPosX < 118) {   
              s += sensibilidade;  // Gira para a direita  
              selectorPosX += 2;  // Move o cursor para a direita  
              tuneRadio();  
            }  
          } else if (keyCode == LEFT || key == '4') {  
            if (selectorPosX > 1){  // Verifica se o cursor não atingiu o limite mínimo  
              s -= sensibilidade;  // Gira para a esquerda  
              selectorPosX -= 2;  // Move o cursor para a esquerda  
              tuneRadio();  
            }  
          } 
      } 
      if(AM == true){  
        if (keyCode == RIGHT || key == '6') {  
          if (selectorPosX < 1) {  // Verifica se o cursor não atingiu o limite máximo  
            s += sensibilidade;  // Gira para a direita  
            selectorPosX += 2;  // Move o cursor para a direita  
            tuneRadio();  
          }  
        } else if (keyCode == LEFT || key == '4') {  
          if (selectorPosX > -103) {  // Verifica se o cursor não atingiu o limite mínimo 
            s -= sensibilidade;  // Gira para a esquerda 
            selectorPosX -= 2;  // Move o cursor para a esquerda 
            tuneRadio(); 
          } 
        } 
      } 
    }  
  }
}
void antenaRaio(){
  pushMatrix();
  rotateZ(1.8*PI/10);    
  rotateY(-0.5*PI/10);    
  translate(181,-772,31);    
  stroke(1);    
  strokeWeight(3);    
  fill(210, 172, 22);    
  beginShape();    
  vertex (835, 151);    
  vertex(489, 285);    
  vertex(498, 409);        
  vertex(618, 489);    
  vertex(501, 550);                    
  vertex(570, 575);    
  vertex(472, 625);    
  vertex(510, 619);    
  vertex(639, 582);    
  vertex(607, 545);    
  vertex(724, 494);    
  vertex(630, 392);    
  vertex(802, 342);    
  vertex(835, 151);    
  endShape();    
  noStroke();    
  translate(0, 0, 0.5);    
  fill(178, 95, 39);    
  beginShape();    
  vertex(615, 556);    
  vertex(613, 562);    
  vertex(592, 548);    
  vertex(598, 566);    
  vertex(581, 556);    
  vertex(589, 570);    
  vertex(581, 570);    
  vertex(561, 583);    
  vertex(539, 610);    
  vertex(636, 582);    
  vertex(614, 556);  
  endShape();  
 
  popMatrix();  
} 
 
void raioEfect(){     
  // Calcula o valor de brilho baseado na função sin           
  float brightness = map(sin(TWO_PI * frequency * millis() / 1000.0), -1, 1, 100, 255);           
             
  pushMatrix();           
  rotateZ(1.5*PI/10);            
  translate(475,-264,331);           
  scale(0.15);               
  fill(210, 172, brightness); // Aplicando variação no brilho da cor                
  beginShape();                
  vertex (835, 151);                
  vertex(489, 285);                
  vertex(498, 409);                
  vertex(618, 489);                
  vertex(501, 550);                
  vertex(570, 575);                
  vertex(472, 625);                
  vertex(510, 619);                
  vertex(639, 582);                
  vertex(607, 545);                
  vertex(724, 494);                
  vertex(630, 392);                
  vertex(802, 342);                
  vertex(835, 151);                     
  endShape();                     
                         
  popMatrix();                       
}                 
                
void raioEfect2(){            
  // Calcula o valor de brilho baseado na função sin           
  float brightness = map(sin(TWO_PI * frequency * millis() / 1000.0), -1, 1, 100, 255);           
             
  pushMatrix();                     
  rotateZ(-13.6*PI/100);                     
  rotateY(0.1*PI/100);                     
  translate(151,57,333);                     
  scale(0.15);                     
  scale(-1, 1);                      
  fill(210, 172, brightness);                     
  beginShape();                     
  vertex (835, 151);                     
  vertex(489, 285);                     
  vertex(498, 409);                     
  vertex(618, 489);                     
  vertex(501, 550);                     
  vertex(570, 575);                     
  vertex(472, 625);                     
  vertex(510, 619);                     
  vertex(639, 582);                     
  vertex(607, 545);                     
  vertex(724, 494);                     
  vertex(630, 392);                     
  vertex(802, 342);                     
  vertex(835, 151);                     
  endShape();                     
                         
  popMatrix();                       
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
                       
void drawCylinder( int pX, int pY, int pZ, int sides, float r, float h, float rX, float rY, float rZ){                       
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
        vertex( x, y, -halfHeight);         
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
  fill(210, 172, 22);    
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
  rotate(QUARTER_PI * s/45);      
  triangle(-10,-7,0,-16,10,-7);      
  popMatrix();      
  fill(152,149,142);      
  drawCylinder(573,40, 290, 8,18,92,0.7,0.0,s);      
}      
      
void botaoVol(int volumeLevel){      
  pushMatrix();                     
  fill(27,62,110);                    
  translate(146,15,330);                    
  //rotateX(0.6);                  
  if(volumeLevel >= 0){                   
    rotateX(0.6);                     
    rotate(PI *20*(volumeLevel-1) /45);                     
  }                     
  triangle(-10,-7,0,-16,10,-7);                    
  popMatrix();                   
  fill(152,149,142);                        
  drawCylinder(146,40, 290, 8,18,92,0.7,0.0,s);    
} 
   
     
void keyReleased() {                     
  if (key == 'o' || key == 'O') {                     
    if (ligado == false) {                     
      ligado = true;                    
    } else {                     
      ligado = false;                  
      FM = false;                     
      AM = false;                     
      Cursor = 0;                    
      stopRadio();           
     }           
    player = minim.loadFile(startSong, 2048);           
    player.play();           
    setVolume(volumeLevel);           
  } else if (key == '=' || key == '+'){                  
    if (volumeLevel < 4){                    
      volumeLevel++;                       
      setVolume(volumeLevel);                       
    }                      
  } else if (key == '-' || key == '_'){                
    if (volumeLevel > 0) {                   
      volumeLevel--;                       
      setVolume(volumeLevel);                        
    }                       
  }                       
}                          
                         
// Função para sintonizar a rádio                
void tuneRadio() {                   
  if (FM) {                       
    int index = int(map(s, 0, 45, 0, FMStations.length - 1));                          
    if (index >= 0 && index < FMStations.length){                        
      currentStation = FMStations[index];             
    }   
  }
  else if (AM) { 
    int index = int(map(s, 0, -45, 0, AMStations.length - 1));
    if (index >= 0 && index < AMStations.length) {
      currentStation = AMStations[index];
    
    }
  }
  
  if (currentStation != null && !currentStation.isEmpty()) {
    if (player != null) {
      player.close();
    }
    player = minim.loadFile(currentStation, 2048);
    if (player != null) {
      player.play();
      setVolume(volumeLevel);
    } else {
        // Ruido em caso de erro
        
          player = minim.loadFile(ruido, 2048);
          player.play();
          player.loop();
          setVolume(volumeLevel);
    }
  } else {
      // Ruido se a URL não estiver definida
        player = minim.loadFile(ruido, 2048);
        player.play();
        player.loop();
        setVolume(volumeLevel);
  }
  
}

// Função para parar a rádio
void stopRadio() {
  if (player != null) {
    player.close();
  }
}

void setVolume(int level) {
  if (player != null) {
    player.setGain(-20.0 + 20.0 * volumeValues[level]);
  }
}

void desenhaFace() {
  // Desenha olhos e boca baseados no estado do rádio
  if (ligado ) { // Se estiver ligado e sintonizado
    if ((AM || FM) && player != null) {
      if(player.getMetaData().fileName()=="radio_noise.mp3"){
        desenhaOlhosTristes();
        desenhaBocaTriste();
        
      }else{
        desenhaOlhosAbertos();
        desenhaBocaFeliz();
      }
    }
    if(!AM && !FM){
      desenhaOlhosAbertos();
      desenhaBocaFechada();
    }
  } else {
    desenhaOlhosFechados();
    desenhaBocaNeutra();
  }
}
void desenhaOlhosAbertos(){
  fill(0);
  stroke(0);
  translate(4, -20, 0);
  ellipse (236, 178, 29, 15);
  ellipse (154, 150, 72, 74);
  translate(0, 0, 0.5);
  fill(255);
  ellipse(167, 136, 30, 30);
  translate(0, 0, 1);
  translate(-14, 0, 0);
  fill(0);
  stroke(0);
  ellipse (334, 150, 72, 74);
  translate(0, 0, 0.5);
  fill(255);
  ellipse(320, 136, 30, 30);
  translate(0, 0, 1);
}

void desenhaBocaFechada(){
  translate(0, 0, 0);
  stroke(0);
  strokeWeight(5);
  noFill();
  line(boca_width - 36, boca_hight, boca_width + 51, boca_hight);
}

void desenhaBocaNeutra(){
  translate(41, 14, 0);
  stroke(0);
  strokeWeight(5);
  noFill();
  line(boca_width - 36, boca_hight, boca_width + 51, boca_hight);
}

void desenhaBocaFeliz(){
  
  translate(-129, -179, 0);
  //boca.
  strokeWeight(2);
  fill(219, 4, 69);
  beginShape();
  curveVertex(345, 406);
  curveVertex(345, 406);
  curveVertex(430, 406);
  curveVertex(388, 473);
  curveVertex(345, 406);
  curveVertex(345, 406);
  endShape();
}

void desenhaBocaTriste(){
 
  translate(-123, -154, 0);
  strokeWeight(2);
  fill(219, 4, 69);
  beginShape();
  curveVertex(-114, 334);
  curveVertex(320, 404);
  curveVertex(424, 409);
  curveVertex(372, 386);
  curveVertex(319, 404);
  curveVertex(340, 422);
  endShape();
}

void desenhaOlhosFechados() {
  
  fill(255);
  stroke(0);
  strokeWeight(5);
  translate(-38, -40, 0);
  line(180, 190, 260, 190);
  translate(-14, 0, 0);
  line(320, 190, 400, 190);
}

void desenhaOlhosTristes(){
  fill(0);
  stroke(0);
  translate(4, -20, 0);
  ellipse (236, 178, 29, 15);
  ellipse (154, 150, 72, 74);
  translate(0, 0, 0.5);
  fill(255);
  ellipse(167, 163, 30, 30);
  translate(0, 0, 1);
  translate(-14, 0, 0);
  fill(0);
  stroke(0);
  ellipse (334, 150, 72, 74);
  translate(0, 3, 0.5);
  fill(255);
  ellipse(320, 159, 30, 30);
  translate(0, 0, 1);
}




  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
