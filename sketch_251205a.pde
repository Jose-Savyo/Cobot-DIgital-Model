import peasy.*;
PeasyCam cam;
import controlP5.*;
ControlP5 cp5;

PShape base, junta_1, junta_2, joelho, junta_5;

// Posições dos eixos
float j1 = 0;
float j2 = 0;
float j3 = 0;
float j4 = 0;

void setup() {
  size(800, 600, P3D);

  // Câmera
  cam = new PeasyCam(this, 100); // Distância inicial
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(500);
  
  // Carrega modelos
  base = loadShape("data/Base.obj");
  junta_1 = loadShape("data/Junta_1.obj");
  junta_2 = loadShape("data/Junta_2.obj");
  joelho = loadShape("data/Joelho.obj");
  junta_5 = loadShape("data/Junta_5.obj");
}

void draw() {
  lerPosicao();  // Atualiza posição dos eixos
  
  background(220);
  lights();
  
  pushMatrix(); // Inicia o robô
  scale(1, -1, 1); // EScala global

  // ---------- Base ----------
  shape(base);
  
  // ---------- Junta 1 -------
  rotateZ(j1); // Move a junta 1
  shape(junta_1);

  // ------ Junta 2 + Elo ------
  translate(0, 0, 0);
  rotateY(j2);
  translate(0, 0, 0);
  shape(junta_2);
  
  // ---- Joelho + Junta 4 -----
  shape(joelho);

  // ---- Junta 5 + Suporte do Atuador -----
  shape(junta_5);
  
  popMatrix(); // Finaliza o robô
}


void lerPosicao() {
  try {
    String[] linha = loadStrings("control/control.txt");
    if (linha != null && linha.length > 0) {
      String[] valores = split(linha[0], ',');
      if (valores.length == 4) {
        j1 = float(valores[0]);
        j2 = float(valores[1]);
        j3 = float(valores[2]);
        j4 = float(valores[3]);
      }
    }
  } catch(Exception e) {
    println("Erro ao ler control.txt: " + e.getMessage());
  }
}
