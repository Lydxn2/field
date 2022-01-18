final int W = 2000;
final int SPEED = 4;
final int SCALE = 200;

boolean keyW, keyA, keyS, keyD;

float eyeX, eyeY, eyeZ;
float focusX, focusY, focusZ;
float tiltX, tiltY, tiltZ;
float angX, angY;

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
  
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  
  drawFloor();
  drawFocalPoint();
  controlCamera();
}

void controlCamera() {  
  if (keyW) {
    eyeX += cos(angX) * SCALE * SPEED / frameRate;
    eyeZ += sin(angX) * SCALE * SPEED / frameRate;
  }
  if (keyA) {
    eyeX -= cos(angX + PI/2) * SCALE * SPEED / frameRate;
    eyeZ -= sin(angX + PI/2) * SCALE * SPEED / frameRate;
  }
  if (keyS) {
    eyeX -= cos(angX) * SCALE * SPEED / frameRate;
    eyeZ -= sin(angX) * SCALE * SPEED / frameRate;
  }
  if (keyD) {
    eyeX -= cos(angX - PI/2) * SCALE * SPEED / frameRate;
    eyeZ -= sin(angX - PI/2) * SCALE * SPEED / frameRate;
  }
  
  angX += (mouseX - pmouseX) * 0.004;
  angY += (mouseY - pmouseY) * 0.004;
  
  focusX = eyeX + cos(angX) * 5;
  focusY = eyeY + tan(angY) * 5;
  focusZ = eyeZ + sin(angX) * 5;
}

void drawFloor() {
  stroke(255);
  for (int x = -W; x < W; x += SCALE) {
    line(x, height, -W, x, height, W);
    line(-W, height, x, W, height, x);
  }
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  
  fill(255);
  sphere(3);
  
  popMatrix();
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
