  /*Instruction set
   * = any instruction
   @ = block for a time
   $ = an exit instruction
   d = data like static variables / constants
   A program will look like this:
   *******$dddd
   */ 
   
class Component{
  Hardware bus;
  
  void install(Hardware bus){
    this.bus = bus;  
  }
}

//////////////////////////////////////////
class PrimaryMemory extends Component{ 
  char[][] memory;
  int banks; // between 1 to 4 banks
  final int maxSizeInBank = 80;
  final int minSizeInBank = 40;
  final int maxBanks = 4;
  int sizeInBank;   // between 40 to 360 chars
  int size;
  
  PrimaryMemory(int b, int bankSize){
    banks = constrain(b, 1, maxBanks);
    sizeInBank = constrain(bankSize, minSizeInBank, maxSizeInBank);
    memory = new char[banks][sizeInBank]; 
  }
  
  void initialise(){
    //calculate how much RAM is available and store it at size
    size = banks * sizeInBank;
    //initialise the RAM by writting the ' ' in every position
    for (int i=0; i<banks; i++) {
      for (int j=0; j<sizeInBank; j++) {
        memory[i][j] = ' ';
      }
    }
  }
  
  void write(char c, int address){
    memory[address/sizeInBank][address%sizeInBank] = c;
  }
  
  char read(int address){
    return memory[address/sizeInBank][address%sizeInBank];  
  }
}

//////////////////////////////////////////////////////
class SecondaryMemory extends Component{
  HashMap<String, String>HDD;
  
  SecondaryMemory(){
    HDD = new HashMap<String, String>();
  }
  
  public void write(String filename, String contents){
    HDD.put(filename, contents);
  }
  
  public String read(String filename) {
    return HDD.getOrDefault(filename, "");
  }
  
  void initialise() {
    HDD.put("program1.exe", "****$ddd");
    HDD.put("program2.exe", "*********$ddddd");
    HDD.put("program3.exe", "****************$dddddddd");
  }
}


//////////////////////////////////////////////////////
class Processor extends Component{
  //Registers
  char IR;  //Instruction register
  int PCR;  //Program Counter Register
  int MAR;  //Memory Address Register
  int BAR;  //Base Address Register  
  //flags
  boolean inFetchCycle;      //fetch or execute?
  
  Processor(){
    inFetchCycle = true;
  }
   
  public void fetch() {
    MAR = BAR + PCR;
    IR = bus.ram.read(MAR);    
  }
  
  public void execute() {
    PCR++;
  }
}

//////////////////////////////////////////////////////
class Keyboard extends Component{
 
  public void userInput(int k) {
    bus.ram.initialise();
    String processImage = bus.hdd.read("program"+k+".exe");
    processImage += os.processTail;
    for(int i=0; i<processImage.length(); i++){
      bus.ram.write(processImage.charAt(i), i);
    }
  }
}
///////////////////////////////////////////////////////
class Hardware{
  int                 clk;
  PrimaryMemory       ram;
  SecondaryMemory     hdd;
  Processor           cpu;
  Keyboard            kbd;
  
  Hardware(int RAMchips, int chipSize){
    clk = 0;
    ram = new PrimaryMemory(RAMchips,chipSize);
    hdd = new SecondaryMemory();
    cpu = new Processor();
    kbd = new Keyboard();
  }
  
  void installComponents(){
     ram.install(this); 
     hdd.install(this); 
     cpu.install(this); 
     kbd.install(this); 
  }
  
  void powerOn(){
    ram.initialise();
    hdd.initialise();
    cpu.inFetchCycle = true;
  }
}
