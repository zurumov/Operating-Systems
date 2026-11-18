public class Hardware{
/*Instruction set
  * = any instruction like add, load, sub, etc
  d = data like variables, objets, consts, etc
  $ = exit call
  so a PROGRAM will look like:
  *******$ddddd
*/

  //RAM
  char[] RAM;
  
  //CPU REGISTERS
  char IR; // Instruction Register
  int MAR; // Memory Address Register
  char MBR; // Memory Buffer Register
  int PC;  // Program Register
  
  //clock
  int clock;
  
  //HDD (filename , file contents)
  HashMap<String, String> HDD;
  
  Hardware(int RAMsize){
    RAM = new char[RAMsize];
    HDD = new HashMap<String, String>();
  }
  
  void boot(){
    //code that is run when the hardware is "powered up"
    //1. check RAM (initialisze it)
    RAMinit();
    //2. set the clock
    clock = 0;
    //3. set any register values
    PC = 0;
    MAR = 0;
    MBR = ' ';
    IR= ' ';
    //4. mount the HDD
  }
  
  void RAMinit(){
    for(int i=0; i<RAM.length; i++){
      RAM[i] = ' ';  
    }
  }
  
  void moundHDD(){
    HDD.put(new String("program1.exe"), new String("*****$ddd"));  
    HDD.put(new String("program2.exe"), new String("********$ddddd"));
    HDD.put(new String("program3.exe"), new String("**************$ddd"));
  }
  
  void execute(){
    // code that is executing the instruction in the IR 
    // for now just print a message to the console using println()
    // and update any registers
    println("At time " + clock + ", executed a " + IR);
    if(IR == '*') {
      PC++;
    } else if (IR == '$') {
        RAMinit();
        PC = 0;
      }
  }
  
  void fetch(){
    //does a fetch cycle
    //assuming theoretically all these steps take 1 clock 
    MAR = 0 + PC;
    MBR = RAM[MAR];
    IR = MBR;
    println("At time " + clock + ", fetched a " + IR);

  }
  
  
  
  
}
