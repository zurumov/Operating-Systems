public class PCB {
  
  int pid;             // who am I?
  STATE state;         // STATE
  int baseAddress;     // where in RAM am I?
  int programCounter;  // how far have I progressed
  String filename;     // which program it is for
  boolean isSystemProcess;  // true if running kernel code
  
  int loadTime;        // time the process was first admitted
  int blockTime;       // last time it was blocked
  int startTime;       // time the process run its first instruction
  int finishTime;      // time the process run its last instruction
  int priority;        // random  number from 0 to 5
  int codeSize;        // number of instructions in the code
  int processSize;     // text + data + heap + stack

  PCB(int ba, String file) {
    //Initialise all attributes
    pid = os.getNewPID();
    state = STATE.NEW;
    baseAddress = ba;
    programCounter = 0;
    filename = file;
    isSystemProcess = false;
    
    loadTime = -1;
    blockTime = -1;
    startTime = -1;
    finishTime = -1;
    priority = int(random(6));
    String fileContents = pc.hdd.read(file);
    codeSize = 0;
    for(int i = 0; i < fileContents.length(); i++) {
      if(fileContents.charAt(i) == '*') {
        codeSize++;  // count the * characters
       }  else break; // run out of * :-(
    }
    codeSize++; // there is also a $
    processSize = fileContents.length()+ os.processTail.length();
  }  
  
  //ADMIT [NEW -> READY]
  public void admit(){
    this.state = STATE.READY; 
    sim.addToLog("os> process "+pid+" is admitted");
  }
  
  //START / RESUME execution [READY -> RUN]
  public void start(){
    //complete the code here. How is the PCB changing?
    this.state = STATE.RUNNING;
    pc.cpu.PCR = this.programCounter;
    pc.cpu.BAR = this.baseAddress;
    if(startTime == -1) startTime = pc.clk;
    sim.addToLog("os> process "+pid+" is running");
  }  
  
  //PAUSE execution [RUN -> READY]
  public void pause(){
    //complete the code here. How is the PCB changing?
    this.state = STATE.READY;
    this.programCounter = pc.cpu.PCR;
    this.baseAddress = pc.cpu.BAR;
    sim.addToLog("os> process "+pid+" is paused");
  }
  
  //BLOCK [RUN -> BLOCK]
  public void block(){
    //complete the code here. How is the PCB changing?
    this.state = STATE.BLOCKED;
    this.programCounter = pc.cpu.PCR;
    this.baseAddress = pc.cpu.BAR;
    blockTime = pc.clk;
    sim.addToLog("os> process "+pid+" is blocked");
  }
  
  //COMPLETE [RUN -> TERMINATED]
  public void finish(){
     //complete the code here. How is the PCB changing?
     this.state = STATE.EXITTING;
     sim.addToLog("os> process "+pid+" is exiting");
  }

  public String toString() {
    String result= int2String(pid, 4)
                   +" :"+int2String(baseAddress, 3)
                   +" :"+int2String(programCounter, 3)
                   +" : ";
    result += state.toString()+" ".repeat(7-state.toString().length())+" : "+filename;
    return result;
  }
  
}
