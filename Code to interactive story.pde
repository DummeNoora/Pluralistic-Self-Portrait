PFont font;
int lineIndex;
int charIndex;
int indexCount, indexCount2, indexCount3, indexCount4, indexCount5;
String[] lines;
int timer, switch1;
int resetTimer, reset = 0;
String nextCharLine;
int bootFlag = 0;


void setup() {
  fullScreen();
  lines = loadStrings("text.txt");
  indexCount = lines.length-1;
  indexCount2 = lines.length-2;
  indexCount3 = lines.length-3;
  indexCount4 = lines.length-4;
  indexCount4 = lines.length-5;
}


void draw() {
  background(0);
  font = createFont("Courier New", height/45);
  textFont(font);
  fill(255);
  reset = millis();

  String toDisplay = lines[lineIndex].substring(0, charIndex);
  if (timer == 50) {
    timer = 0;
    switch1 = (switch1 + 1) % 2;
  }
  if (switch1 == 1) nextCharLine = " ";
  if (switch1 == 0) nextCharLine = "|";

  text(toDisplay+nextCharLine, width/10, height/10*5);

  if (reset - resetTimer > 120000) {
    text("tryg på tastaturet", width/7*3, height/2);
  }

  //String toDisplay2 = (indexCount < lines.length) ?  lines[indexCount] : lines[indexCount++];
  String toDisplay2 = (indexCount == lines.length) ?  lines[0] : lines[indexCount];
  String toDisplay3 = (indexCount2 == lines.length) ?  lines[0] : lines[indexCount2];
  String toDisplay4 = (indexCount3 == lines.length) ?  lines[0] : lines[indexCount3];
  String toDisplay5 = (indexCount4 == lines.length) ?  lines[0] : lines[indexCount4];
  String toDisplay6 = (indexCount5 == lines.length) ?  lines[0] : lines[indexCount5];
  if (bootFlag == 0) fill(0);
  text(toDisplay2, width/10, height/10*4);
  if (bootFlag == 1) fill(0);
  text(toDisplay3, width/10, height/10*3);
  if (bootFlag == 2) fill(0);
  text(toDisplay4, width/10, height/10*2);
  if (bootFlag == 3) fill(0);
  text(toDisplay5, width/10, height/10);
  if (bootFlag == 4) fill(0);
  text(toDisplay6, width/10, 1);
  if (bootFlag == 5) fill(0);
  timer++;
  println(reset - resetTimer);

  if (lineIndex < 16 && reset - resetTimer > 60000) {
    charIndex = 0;
    lineIndex = 0;
    indexCount = lines.length-1;
    indexCount2 = lines.length-2;
    indexCount3 = lines.length-3;
    indexCount4 = lines.length-4;
    indexCount5 = lines.length-5;
    bootFlag = 0;
  }
  if (lineIndex > 17 && lineIndex < 51 && reset - resetTimer > 60000) {
    charIndex = 0;
    lineIndex = 17;
    indexCount = lineIndex-1;
    indexCount2 = lineIndex-2;
    indexCount3 = lineIndex-3;
    indexCount4 = lineIndex-4;
    indexCount5 = lineIndex-5;
    bootFlag = 0;
  }
  if (lineIndex > 51 && reset - resetTimer > 60000) {
    charIndex = 0;
    lineIndex = 51;
    indexCount = lineIndex-1;
    indexCount2 = lineIndex-2;
    indexCount3 = lineIndex-3;
    indexCount4 = lineIndex-4;
    indexCount5 = lineIndex-5;
    bootFlag = 0;

  }
}
// text(lines[min((lineIndex + lines.length) % lines.length, lines[lineIndex].length())],50,200);


void keyPressed() {
  if (keyCode == BACKSPACE) {
    if (charIndex > 0) {
      resetTimer = reset;
      charIndex = max(charIndex - 2, 0);
    } else if (lineIndex > 0 || lineIndex == 0) { //fjern eventuelt lineIndex == 0, hvis ikke man skal kunne slette fra starten
      lineIndex = wrapSubtract(lineIndex, 1, lines.length);
      charIndex = lines[lineIndex].length();
      indexCount = wrapSubtract(indexCount, 1, lines.length);
      indexCount2 =  wrapSubtract(indexCount2, 1, lines.length);
      indexCount3 =  wrapSubtract(indexCount3, 1, lines.length);
      indexCount4 =  wrapSubtract(indexCount4, 1, lines.length);
      indexCount5 =  wrapSubtract(indexCount5, 1, lines.length);
    }
    return;
  }
  if (charIndex < lines[lineIndex].length()) {
    resetTimer = reset;
    charIndex = min(charIndex + int(random(1, 3)), lines[lineIndex].length());  // Reveal the next character in the current line
  } else if (lineIndex < lines.length) {
    lineIndex = (lineIndex + 1) % lines.length;  // Move to the next line
    if (bootFlag < 6)bootFlag++;
    charIndex = 0;  // Reset character index for the new line
    indexCount = (indexCount + 1) % lines.length;
    indexCount2 = (indexCount2 + 1) % lines.length;
    indexCount3 = (indexCount3 + 1) % lines.length;
    indexCount4 = (indexCount4 + 1) % lines.length;
    indexCount5 = (indexCount5 + 1) % lines.length;
  }
}

int wrapSubtract(int value, int amount, int max) {
  value -= amount;
  if (value < 0) {
    value = max + value;  // Wrap around to the end
  }
  return value;
}
