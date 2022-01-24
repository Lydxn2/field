import com.jogamp.newt.opengl.GLWindow;

final int MIN_X = -10, MAX_X = 10;
final int MIN_Y = -10, MAX_Y = 10;
final int MIN_Z = -10, MAX_Z = 10;

final float HEIGHT = 2.7;
final float GRAVITY = 0.85;

final int SPEED = 5;
final int SCALE = 200;

HashMap<String, PImage> imgCache;

PFont monoFont;

GLWindow window;

boolean keyW, keyA, keyS, keyD, keyCtrl, keySpace, keyF3;

float eyeX, eyeY, eyeZ;
float centerX, centerY, centerZ;
float angX, angY;

float velY;
float zoom;

Block[][][] world;

void setup() {
  size(1000, 800, P3D);
  textureMode(NORMAL);
  
  
  monoFont = createFont("Consolas", 1);
  
  // set infinite render distance
  zoom = 20;
  
  imgCache = new HashMap<String, PImage>();
  
  window = (GLWindow) surface.getNative();
  noCursor();
  
  keyW = keyA = keyS = keyD = false;
  
  world = new Block[MAX_X - MIN_X + 1][MAX_Y - MIN_Y + 1][MAX_Z - MIN_Z + 1];
  
  // ground
  for (int x = MIN_X; x <= MAX_X; x++)
    for (int z = MIN_Z; z <= MAX_Z; z++)
      world[x - MIN_X][0][z - MIN_Z] = new GrassBlock(x, 0, z);
  // walls
  for (int x = MIN_X; x <= MAX_X; x++)
    for (int z = MIN_Z; z <= MAX_Z; z++)
      if (x == MIN_X || x == MAX_X || z == MIN_Z || z == MAX_Z)
        for (int y = MIN_Y; y <= 0; y++)
          world[x - MIN_X][y - MIN_Y][z - MIN_Z] = new DiamondBlock(x, y, z);

  angX = angY = 0;
  eyeX = eyeY = eyeZ = 0;
  centerX = centerY = centerZ = 0;
}

void draw() {
  background(0);
 
  camera(eyeX, eyeY - SCALE * HEIGHT, eyeZ, centerX, centerY - SCALE * HEIGHT, centerZ, 0, 1, 0);

  drawMap();
  controlCamera();
  drawF3();
}

void controlCamera() {
  float speed = keyCtrl ? SPEED * 2 : SPEED;
  if (keyW) {
    eyeX += cos(angX) * SCALE * speed / frameRate;
    eyeZ += sin(angX) * SCALE * speed / frameRate;
  }
  if (keyA) {
    eyeX -= cos(angX + PI/2) * SCALE * speed / frameRate;
    eyeZ -= sin(angX + PI/2) * SCALE * speed / frameRate;
  }
  if (keyS) {
    eyeX -= cos(angX) * SCALE * speed / frameRate;
    eyeZ -= sin(angX) * SCALE * speed / frameRate;
  }
  if (keyD) {
    eyeX -= cos(angX - PI/2) * SCALE * speed / frameRate;
    eyeZ -= sin(angX - PI/2) * SCALE * speed / frameRate;
  }
  
  // JUMP
  if (keySpace && eyeY == 0.0) velY = -15;
  velY += GRAVITY;
  eyeY = min(eyeY + velY, 0);
  
  centerX = eyeX + cos(angX) * 5;
  centerY = eyeY + tan(angY) * 5;
  centerZ = eyeZ + sin(angX) * 5;

  if (focused) {
    window.warpPointer(width / 2, height / 2);
    angX += (mouseX - width / 2) * 0.004;
    angY += (mouseY - height / 2) * 0.004;
  }
}

void drawMap() {
  for (int x = MIN_X; x <= MAX_X; x++)
    for (int y = MIN_Y; y <= MAX_Y; y++)
      for (int z = MIN_Z; z <= MAX_Z; z++)
        if (world[x - MIN_X][y - MIN_Y][z - MIN_Z] != null)
          world[x - MIN_X][y - MIN_Y][z - MIN_Z].render();
}

void drawF3() {
  textFont(monoFont, 100);
  text("FPS: " + frameRate, 20, 50);
  text("XYZ: " + eyeX + " / " + eyeY + " / " + eyeZ, 20, 80);
}

void keyPressed() {
  if (key == 'w') keyW = true;
  if (key == 'a') keyA = true;
  if (key == 's') keyS = true;
  if (key == 'd') keyD = true;
  if (key == ' ') keySpace = true;
  if (keyCode == 99) keyF3 = true;
  if (keyCode == CONTROL) keyCtrl = true;
}

void keyReleased() {
  if (key == 'w') keyW = false;
  if (key == 'a') keyA = false;
  if (key == 's') keyS = false;
  if (key == 'd') keyD = false;
  if (key == ' ') keySpace = false;
  if (keyCode == 99) keyF3 = false;
  if (keyCode == CONTROL) keyCtrl = false;
}

void mousePressed() {
  if (mouseButton == RIGHT)
    perspective(radians(20), 1.0 * width / height, 10, -1);
}

void mouseReleased() {
  if (mouseButton == RIGHT)
    perspective(radians(60), 1.0 * width / height, 10, -1);
}
