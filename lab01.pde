//Some colors to use
final color darkBlue = #1E0BD6;
final color green = #0BD631;
final color pink = #F739EE;
final color yellow = #F0DE16;

Hardware myPC;
int simSpeed;

void setup(){
  size(850, 300);
  frameRate(30);
  simSpeed = 15;
  myPC = new Hardware(50);
  myPC.boot();
}

void draw(){
  background(darkBlue);
  drawRAM();
  if(frameCount % simSpeed == 0){
    step();
  }
}

void step(){
// code for doing 1 step of the simulation (either fetch or execute
  if(myPC.clock %  2 == 0){
    myPC.fetch();
  } else {
    myPC.execute();  
  }
  myPC.clock++;
}

//helper function that draws the RAM on screen
void drawRAM(){
  int squares = myPC.RAM.length;
  float sqSize = width / squares;
  stroke(0);
  
  textAlign(CENTER, CENTER);
  for(int i=0; i<squares; i++){
    if(myPC.RAM[i]==' ') fill(255);
    else{
      if(myPC.PC == i) fill(pink);
      else fill(green);
    }
    rect(i*sqSize, 0, sqSize, sqSize);
    fill(0);
    text(myPC.RAM[i], i*sqSize+sqSize/2, sqSize/2);
  }
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      simSpeed +=5;
    }else if (keyCode == RIGHT){
      simSpeed -=5;
    }
    simSpeed = constrain(simSpeed, 1, 30);
  }else{ if(key == '1'){
      loadProgram("program1.exe");  
    }else if(key == '2'){
      loadProgram("program2.exe");  
    }else if(key == '3'){
      loadProgram("program3.exe");  
    }
  }
}

void loadProgram(String filename){
  //code that reads a program from the HDD and loads it to RAM
  //starting from address 0
  //1. Erase the RAM
  myPC.RAMinit();
  //2.Get the code (String) from the HDD of the file filename
  String code = myPC.HDD.get(filename);
  //3. Copy the code (String) to the RAM[] (char[]) starting at 0
  for(int i = 0; i < code.length(); i++) {
    myPC.RAM[i] = code.charAt(i);
  }
  //4. Set the PC to 0
  myPC.PC = 0;
}
