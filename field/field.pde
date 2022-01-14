final int W = 2000;
final int S = 10;

boolean keyW, keyA, keyS, keyD;

float eyeX, eyeY, eyeZ;
float focusX, focusY, focusZ;
float tiltX, tiltY, tiltZ;

void setup() {
  size(800, 800, P3D);
  textureMode(NORMAL);
  
  keyW = keyA = keyS = keyD = false;
  
  eyeX = width / 2.0;
  eyeY = height / 2.0;
  eyeZ = 0;
  
  focusX = width / 2.0;
  focusY = width / 2.0;
  focusZ = 10;
  
  tiltX = 0;
  tiltY = 1;
  tiltZ = 0;
}

void draw() {
  background(0);
  
  controlCamera();
  drawFloor();
}

void controlCamera() {
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  
  if (keyW) eyeZ += S;
  if (keyA) eyeX += S;
  if (keyS) eyeZ -= S;
  if (keyD) eyeX -= S;
  
  focusX = eyeX;
  focusY = eyeY;
  focusZ = eyeZ + 10;
}

void drawFloor() {
  stroke(255);
  for (int x = -W; x < W; x += 100) {
    line(x, height, -W, x, height, W);
    line(-W, height, x, W, height, x);
  }
}

void keyPressed() {
  if (key == 'w') keyW = true;
  if (key == 'a') keyA = true;
  if (key == 's') keyS = true;
  if (key == 'd') keyD = true;
}

void keyReleased() {
  if (key == 'w') keyW = false;
  if (key == 'a') keyA = false;
  if (key == 's') keyS = false;
  if (key == 'd') keyD = false;
}
