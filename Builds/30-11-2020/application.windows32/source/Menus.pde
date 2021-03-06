//all code that has to do with the Main Menu of the game
//code credit Ole Neuman

class MainMenu {

  MenuBox[] boxArray = new MenuBox[MENUBOX_AMOUNT];

  int boxSelected;
  int moveCooldown;

  PImage logo;
  TextureAssets sprites;

  int xKeyXPos = 1405;
  int xKeyYPosStart = 640;
  int xKeyYPosSettings = 820;
  int xKeyYPosQuit = 1000;

  MainMenu(TextureAssets textureLoader) {

    for (int i = 0; i < MENUBOX_AMOUNT; i++) {
      boxArray[i] = new MenuBox(width / 4, height / 2 + i* (height / 6), width / 2, height / 8, 20);
    }
    boxArray[0].boxText = "Start";
    //boxArray[1].boxText = "Settings";
    boxArray[1].boxText = "Quit";

    boxSelected = 0;

    moveCooldown = 0;

    logo = loadImage("data/text/logo_highres.png");
    logo.resize(200, 0);
    this.sprites = textureLoader;
  }

  void draw() {
    background(MENU_BACKGROUND_COLOUR);
    image(logo, 20, height - logo.height - 20);
    for (MenuBox menuBox : boxArray) {
      menuBox.draw();
    }
    image(sprites.getKeyCap(2, 7), xKeyXPos, xKeyYPosStart);
    image(sprites.getKeyCap(2, 7), xKeyXPos, xKeyYPosSettings);
    //image(sprites.getKeyCap(2, 7), xKeyXPos, xKeyYPosQuit);
  }

  void update() {
    for (MenuBox menuBox : boxArray) {
      menuBox.selected = false;
    }
    boxArray[boxSelected].selected = true;


    if (input.upDown() && moveCooldown == 0) {
      if (boxSelected == 0) boxSelected = MENUBOX_AMOUNT - 1;
      else boxSelected--;
      moveCooldown = MENU_MOVE_COOLDOWN;
    }

    if (input.downDown() && moveCooldown == 0) {
      if (boxSelected == MENUBOX_AMOUNT - 1) boxSelected = 0;
      else boxSelected++;
      moveCooldown = MENU_MOVE_COOLDOWN;
    }
    if (moveCooldown > 0) moveCooldown--;

    if (input.xDown()) {
      switch(boxSelected) {
      case 0:
        gameState = 1;
        break;
      //case 1:
      //  gameState = 2;
      //  break;
      case 1:
        exit();
        return;

      default:
        gameState = 1;
      }
    }
  }
}

class MenuBox {

  float posX, posY;
  int boxWidth, boxHeight;

  color boxOuterColour;
  color boxInteriorColour;
  color textColour;

  String boxText;
  int textSize;

  boolean selected;

  MenuBox(float positionX, float positionY, int Width, int Height, int size) {
    posX = positionX;
    posY = positionY;
    boxWidth = Width;
    boxHeight = Height;
    boxOuterColour = BOX_BASIC_OUTER_COLOUR;
    boxInteriorColour = BOX_BASIC_INNER_COLOUR;
    textColour = BOX_TEXT_COLOUR;
    boxText = "";
    textSize = size;
    selected = false;
  }

  void draw() {
    update();
    stroke(boxOuterColour);
    fill(boxInteriorColour);
    strokeWeight(5);
    rect(posX, posY, boxWidth, boxHeight);
    strokeWeight(1);
    fill(textColour);
    textSize(textSize);
    text(boxText, posX + boxWidth / 2, posY + boxHeight / 2);
  }

  void update() {
    if (selected) {
      boxOuterColour = BOX_HIGHLIGHTED_OUTER_COLOUR;
      boxInteriorColour = BOX_HIGHLIGHTED_INNER_COLOUR;
    } else {
      boxOuterColour = BOX_BASIC_OUTER_COLOUR;
      boxInteriorColour = BOX_BASIC_INNER_COLOUR;
    }
  }
}

//code credit Jordy
//gameOver scherm
class GameOver {
  PImage logo;
  Highscore highscore;

  GameOver() {
    logo = loadImage("data/text/logo_highres.png");
  }

  void update(Highscore highscore) {
    this.highscore = highscore;
    if (input.escapeDown()) {
      toMainMenu();
    }
  }

  void draw() {
    background(MENU_BACKGROUND_COLOUR);
    image(logo, 20, height - logo.height - 20);
    logo.resize(200, 0);
    fill(0);
    textSize(50);
    text("GAME OVER", width / 2 -150, height / 4);
    textSize(40);
    text("SCORE: " + highscore.score, width / 2 -125, height / 4 + 100);
  }
}
