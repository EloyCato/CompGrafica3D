int numBars = 20;
float[] barHeights = new float[numBars];
color[] barColors = new color[numBars];
float maxHeight = 60;
float barWidth = 500.0 / numBars;
float selectorPosX = 0;
boolean movingRight = true;

void setup() {
  size(1000, 600, P3D);
  for (int i = 0; i < numBars; i++) {
    float intensity = map(abs(i - numBars/2), 0, numBars/2, 255, 30); // Degradê mais forte nas extremidades
    barColors[i] = color(intensity, 255, intensity);  // Efeito fluorescente
    barHeights[i] = random(maxHeight / 4); // Inicializa as alturas
  }
  noStroke();
}

void draw() {
  background(20);
  lights();
  ambientLight(50, 50, 50);
  
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
  
  fill(255);
  textSize(12);
  textAlign(CENTER, CENTER);
  text("Multimídia Display", width/2, height/2 + 100);
}
