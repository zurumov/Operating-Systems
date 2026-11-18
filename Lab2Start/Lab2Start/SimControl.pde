public class Simulator{
  PrintWriter output;

  private int speed;
  private boolean isRunning;  
  
  String explanation;  
  
  Graphics graphics;
  
  Simulator(){
    speed = 20;
    graphics = new Graphics();
    isRunning = false;  
    output = createWriter("Simulation.log");
    addToLog("=============== New Simulation ===============");
    addToLog("==============================================\n");
  }
  
  //PUBLIC METHODS///////////////////////////////
  ///////////////////////////////////////////////
    
  public void increaseSpeed(){
    speed -=5;
    speed = constrain(speed, 1, graphics.maxFrameRate);
  }
  
  public void decreaseSpeed(){
    speed +=5;
    speed = constrain(speed, 1, graphics.maxFrameRate);
  }
  
  public void addToLog(String message){
    println(message);  
    output.println(message);
    explanation += message+"\n";
  }
  
  public void step(){
    //increment the pc.clk
    pc.clk++;
    addToLog("\n============== SIMULATION TIME "+(pc.clk)+" ==============");
    
    if(pc.cpu.inFetchCycle){
      pc.cpu.fetch();
      addToLog("pc> fetched "+pc.cpu.IR);
      pc.cpu.inFetchCycle = false;
    }else{ 
      pc.cpu.execute();
      addToLog("pc> executed "+pc.cpu.IR);
      //call os.call(cpu.IR) if the hardware has executed an instruction
      os.call(pc.cpu.IR); 
      pc.cpu.inFetchCycle = true;
    }
    graphics.renderVisuals();
    graphics.renderAnimations();
  }
  
  public void update(){
    explanation = "";
    if(frameCount % speed == 0  && isRunning && frameCount>1){
      graphics.renderVisuals();
      step();
    }if(isRunning){
      graphics.renderAnimations();
    }
  }
  
  public void startSimulation(){
    //power the hardware on
    addToLog("pc> Computer booting...");
    pc.powerOn(); 
    addToLog("pc> RAM checked. Total RAM available "+pc.ram.size);
    addToLog("pc> HDD found. Looking for OS");
    //load the OS
    addToLog("pc> Operating system found. Booting OS");
    os.boot();
    
  }
  
  public void endSimulation(){
    addToLog("=".repeat(30));
    addToLog("Simulation ended on Time "+pc.clk);
    addToLog("Simulation Statistics:");
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    exit();  
  }
  
}
