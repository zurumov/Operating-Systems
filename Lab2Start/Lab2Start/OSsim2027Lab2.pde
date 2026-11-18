Hardware pc;
OperatingSystem os;
enum STATE {NEW, READY, RUNNING, BLOCKED, EXITNG}

//Simulator
Simulator sim;

public void setup(){
  size(1200, 800);
  //setup the hardware. Arguments: Number of RAM Chips, Size of each chip (in chars) 
  pc = new Hardware(1, 60);
  pc.installComponents();
  //setup the OS.
  os = new OperatingSystem();
  //setup Sim
  sim = new Simulator();
  sim.startSimulation();
}

void draw(){
  sim.update();
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      sim.decreaseSpeed();
    }else if(keyCode == RIGHT){
      sim.increaseSpeed();
    }
  }else{
    if(key == '1'){
      pc.kbd.userInput(1);  
    }else if(key == '2'){
      pc.kbd.userInput(2);  
    }else if(key == '3'){
      pc.kbd.userInput(3);  
    }else if(key == 'p' || key == 'P'){
      sim.isRunning = !sim.isRunning;  
    }else if(key == 'q' || key == 'Q'){
      sim.endSimulation();  
    }else if(key == 's' || key == 'S'){
      if(sim.isRunning) sim.isRunning = false;
      sim.step();
    }
  }
}

String int2String(int num, int stringSize) {
  String intAsString = String.valueOf(num);
  String space="";
  int intSize = intAsString.length();
  if(stringSize>intSize){
    int d = stringSize - intSize;
    for(int i=0; i<d; i++){
        space += " ";  
    }
    intAsString = space+intAsString;
  }
  return intAsString;
}
