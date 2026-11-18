public class OperatingSystem {
  public String processTail;
  
  private int pidCounter;
  public ArrayList<PCB> processTable;

  public OperatingSystem() {
    this.processTail = "hhhhssss";
    pidCounter = 0;
    processTable = new ArrayList<PCB>();
  }
  
  public int getNewPID(){
    return pidCounter++;
  }
  
  public void call(char instruction) {
    // 1. Check for Software Traps (Special Instructions)
    if (instruction == '$') {
      pc.ram.initialise();
      pc.cpu.PCR = 0;
    }else if (instruction == ' '){
      pc.cpu.PCR = 0;
    }
  }
  
  public void boot() { 
    // 1. Initialize partitions 
    sim.addToLog("os> Boot completed. Idle Process (PID 0) initialized.");
  }
  
  private void setupFixedPartitions() {
    
  }
  

/////////////////////////////////////////

//Pass an integer that tells you how much memory you have, how much partition, put it into a table
