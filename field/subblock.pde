class DiamondBlock extends Block {
  DiamondBlock(int x, int y, int z) {
    super(x, y, z);
    super.setTexture(
      loadImageFast("data/blocks/dia/dia.png"),
      loadImageFast("data/blocks/dia/dia.png"),
      loadImageFast("data/blocks/dia/dia.png"),
      loadImageFast("data/blocks/dia/dia.png"),
      loadImageFast("data/blocks/dia/dia.png"),
      loadImageFast("data/blocks/dia/dia.png")
    );
  }
}

class GrassBlock extends Block {
  GrassBlock(int x, int y, int z) {
    super(x, y, z);
    super.setTexture(
      loadImageFast("data/blocks/grass/grassU.png"),
      loadImageFast("data/blocks/grass/grassD.png"),
      loadImageFast("data/blocks/grass/grassS.png"),
      loadImageFast("data/blocks/grass/grassS.png"),
      loadImageFast("data/blocks/grass/grassS.png"),
      loadImageFast("data/blocks/grass/grassS.png")
    );
  }
}

class DirtBlock extends Block {
  DirtBlock(int x, int y, int z) {
    super(x, y, z);
    super.setTexture(
      loadImageFast("data/blocks/grass/grassD.png"),
      loadImageFast("data/blocks/grass/grassD.png"),
      loadImageFast("data/blocks/grass/grassD.png"),
      loadImageFast("data/blocks/grass/grassD.png"),
      loadImageFast("data/blocks/grass/grassD.png"),
      loadImageFast("data/blocks/grass/grassD.png")
    );
  }
}

PImage loadImageFast(String path) {
  if (!imgCache.containsKey(path))
    imgCache.put(path, loadImage(path));
  return imgCache.get(path);
}
