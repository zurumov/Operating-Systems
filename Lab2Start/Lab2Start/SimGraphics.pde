public class Graphics{
    //Graphics related
  final color lightgreen = #28F741;
  final color green = #28AD1F;
  final color darkgreen = #075D32;
  final color pink = #FFC4F5;
  final color red = #F22735;
  final color maroon =#A00606;
  final color aqua = #62C1FA;
  final color blue = #4C55EA;
  final color darkblue = #0A05A7;
  final color yellow = #FAF026;
  final color orange = #FC8F00;
  final color white = #FFFFFF;
  final color black = #000000;
  final color lightgray =#CCCCCC;
  final color gray = #777777;
  final color darkgray = #333333;

  final int maxFrameRate = 40;

  private PFont courierBold;
  private PFont courier;

  private color CPUoutColor;
  private color CPUinColor;
  private color busColor;
  private color fetchExecute;  
  
  //ArrayList<Drawable> visuals;
  //ArrayList<Drawable> animations;
  
  private ProcessorRenderer cpuVisual;
  private RAMRenderer ramVisual;
  private ScreenRenderer screenVisual;
  private ClockRenderer clockVisual;
  
  private float firstcolX, firstrowY, secondrowY;

  Graphics(){
    courierBold = createFont("courbd.ttf", 18);
    courier = createFont("cour.ttf", 18);
    frameRate(maxFrameRate);
    firstcolX = 10;
    firstrowY = 10;
    secondrowY = 230;  
    
    cpuVisual = new ProcessorRenderer();
    cpuVisual.initialise(firstcolX, firstrowY, 100, 0);
    
    ramVisual = new RAMRenderer();
    ramVisual.placeNextTo(cpuVisual,30).resize(width-20-ramVisual.getX(), 0);
    
    clockVisual = new ClockRenderer();
    clockVisual.initialise(firstcolX+75, secondrowY+225, 150, 150);
    
    screenVisual = new ScreenRenderer();
    screenVisual.initialise(firstcolX, 550, 300, 0);
     
    
  }
  
  public void renderVisuals(){
    background(aqua);
    if (pc.cpu.inFetchCycle) {
      fetchExecute = lightgreen;
      CPUoutColor = white;
      CPUinColor = fetchExecute;
      busColor = lightgreen;
    } else {
      fetchExecute = blue;
      CPUoutColor = white;
      CPUinColor = fetchExecute;
      busColor = gray;
    }
    
    ramVisual.render();
    cpuVisual.render();    
    clockVisual.render();
    screenVisual.render(); 
  }
  
  public void renderAnimations(){
    clockVisual.render();
  }
}
