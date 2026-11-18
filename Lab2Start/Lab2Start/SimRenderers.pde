public abstract class Drawable{
  protected float x, y, w, h;
  
  public void initialise(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public Drawable resize(float w, float h){
    this.w = w;
    this.h = h;
    return this;
  }
  
  public Drawable placeNextTo(Drawable other, float d){
    this.x = other.getX() + other.getW() + d;
    this.y = other.getY();
    return this;
  }
    
  public float getX(){return x;}
  public float getY(){return y;}
  public float getW(){return w;}
  public float getH(){return h;}
 
  public abstract void render();
}
//////////////////////////////////////////
public class ProcessorRenderer extends Drawable{

  @Override
  public void render() {
    pushMatrix();
    translate(x, y);
    rectMode(CORNER);
    textFont(sim.graphics.courierBold);
    stroke(0);
    strokeWeight(5);
    //outer rect of top CPU
    fill(sim.graphics.CPUoutColor);
    rect(0, 0, w, w);
    strokeWeight(1);
    fill(sim.graphics.CPUinColor);
    //inner rect of top CPU
    rect(w*0.16, w*0.16, w*0.68, w*0.68, 7);
    fill(sim.graphics.black);
    pushStyle();
    textSize(50);
    textAlign(CENTER, CENTER);
    text(pc.cpu.IR, w*0.5, w*0.5);
    popStyle();
    triangle(w*0.05, w*0.85, w*0.05, w*0.95, w*0.15, w*0.95);
    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(10);
    strokeWeight(1);
    //Base Address Register
    drawRegister("BAR", pc.cpu.PCR, 0, 1.4*w);
    //counter register
    drawRegister("PCR", pc.cpu.PCR, 0, 1.6*w);
    //MAR
    drawRegister("MAR", pc.cpu.MAR, 0, 1.8*w);
    popStyle();
    popMatrix();
  }  
    
  void drawRegister(String name, int value, float x, float y){
    pushStyle();
    textSize(16);
    fill(sim.graphics.white);
    rectMode(CORNER);
    rect(x, y, w, w*0.20);
    fill(sim.graphics.black);
    textAlign(LEFT, CENTER);
    text(name+": "+value, x+10, y+0.1*w);
    popStyle();
  }
  
}
/////////////////////////////////////////
public class ClockRenderer extends Drawable{ 
  
  public void render() {
    fill(sim.graphics.aqua);
    circle(x,y,w);
    fill(sim.graphics.fetchExecute);
    float inc = (frameCount % sim.speed)*TWO_PI/sim.speed;
    noStroke();
    arc(x, y, w, w, -HALF_PI, -HALF_PI+inc, PIE);
    pushStyle();
    textFont(sim.graphics.courierBold);
    textSize(w*0.4);
    fill(sim.graphics.black);
    textAlign(CENTER, CENTER);
    text(pc.clk, x, y);
    popStyle();
  }
  
}

//////////////////////////////////////////
public class RAMRenderer extends Drawable{
  
  float sqSize;
  
  public void render() {
    sqSize = w / pc.ram.maxSizeInBank;
    pushMatrix();
    translate(x, y);
    textFont(sim.graphics.courier);
    
    for (int i=0; i<pc.ram.banks; i++) {
      drawRAMBank(i, false);
    }
    for (int i=pc.ram.banks; i<pc.ram.maxBanks; i++) {
      drawRAMBank(i, true);
    }
    popMatrix();
  }
  
  private void drawRAMBank(int bank, boolean empty) {
    int squares = pc.ram.sizeInBank;
    stroke(0);
    pushMatrix();
    translate(0, 45*bank);
    textAlign(CENTER, CENTER);
    if (!empty) {
      //draw the BUS lines
      for (int i=0; i<pc.ram.maxSizeInBank; i++) {
        drawBus(i, sqSize, sim.graphics.darkgray);
      }
      for (int i=0; i<pc.ram.maxSizeInBank; i++) {
        if(i<squares){
        //Draw the partition         
          //draw the ram
          if (pc.cpu.MAR == i+bank*pc.ram.sizeInBank) {
            fill(sim.graphics.fetchExecute);
            drawBus(i, sqSize, sim.graphics.busColor);
          } else if (pc.ram.memory[bank][i]== ' '){
            fill(sim.graphics.white);
          //}else if (bank == 0 && i<partitionTable.get(0).size){
            //fill(sim.graphics.lightgray);
          }else{
            fill(sim.graphics.pink);
          }
          stroke(sim.graphics.black);
          
          square(i*sqSize, 0, sqSize);
          fill(0);
          text(pc.ram.memory[bank][i], i*sqSize+sqSize/2, sqSize/2);
        }else{
          fill(sim.graphics.gray);
          stroke(sim.graphics.black);
          rect(i*sqSize, -0.15*sqSize, sqSize, sqSize*1.3);
        }
      }
    } else {
      for (int i=0; i<pc.ram.maxSizeInBank; i++) {
        fill(sim.graphics.gray);
        stroke(sim.graphics.black);
        rect(i*sqSize, -0.15*sqSize, sqSize, sqSize*1.3);
        drawBus(i, sqSize, sim.graphics.gray);
      }
    }
    popMatrix();
  }
  
  private void drawBus(int i, float sqSize, color c){
    stroke(c);
    strokeWeight(2);
    strokeCap(ROUND);
    line(i*sqSize+0.5*sqSize, sqSize, i*sqSize+0.5*sqSize, 1.5*sqSize);
    line(i*sqSize+0.5*sqSize, 1.5*sqSize, -2*sqSize, 1.5*sqSize);
    strokeWeight(1);
    stroke(sim.graphics.black);
  }  
  
}


///////////////////////////////
public class ScreenRenderer extends Drawable{

  void render() {
    textFont(sim.graphics.courierBold);
    fill(sim.graphics.black);
    textAlign(LEFT, TOP);
    text(sim.explanation, x, y);
  }
}
