class Block {
  PImage texU, texD, texL, texR, texF, texB;
  int x, y, z;

  Block(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void render() {
    pushMatrix();
    noStroke();

    // UP
    _drawFace(texU, -1, -1, -1,  1, -1, -1,  1, -1,  1, -1, -1,  1);
    _drawFace(texD, -1,  1, -1,  1,  1, -1,  1,  1,  1, -1,  1,  1);
    _drawFace(texL, -1, -1, -1, -1, -1,  1, -1,  1,  1, -1,  1, -1);
    _drawFace(texR,  1, -1, -1,  1, -1,  1,  1,  1,  1,  1,  1, -1);
    _drawFace(texF, -1, -1, -1,  1, -1, -1,  1,  1, -1, -1,  1, -1);
    _drawFace(texB, -1, -1,  1,  1, -1,  1,  1,  1,  1, -1,  1,  1);
    
    popMatrix();
  }

  void setTexture(PImage texU,
                  PImage texD,
                  PImage texL,
                  PImage texR,
                  PImage texF,
                  PImage texB) {
    this.texU = texU;
    this.texD = texD;
    this.texL = texL;
    this.texR = texR;
    this.texF = texF;
    this.texB = texB;
  }
  
  void _drawFace(PImage texture,
                 float x0, float y0, float z0,
                 float x1, float y1, float z1,
                 float x2, float y2, float z2,
                 float x3, float y3, float z3) {
    beginShape(QUADS);
    texture(texture);
    vertex((this.x + x0 / 2.0) * SCALE, (this.y + y0 / 2.0) * SCALE, (this.z + z0 / 2.0) * SCALE, 0, 0);
    vertex((this.x + x1 / 2.0) * SCALE, (this.y + y1 / 2.0) * SCALE, (this.z + z1 / 2.0) * SCALE, 1, 0);
    vertex((this.x + x2 / 2.0) * SCALE, (this.y + y2 / 2.0) * SCALE, (this.z + z2 / 2.0) * SCALE, 1, 1);
    vertex((this.x + x3 / 2.0) * SCALE, (this.y + y3 / 2.0) * SCALE, (this.z + z3 / 2.0) * SCALE, 0, 1);
    endShape();
  }
}
