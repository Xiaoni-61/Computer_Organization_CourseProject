


  
  
module ifu_test;
  reg clk,reset,npc_sel,zero,jsome,jr;
  reg [31:0]AOut;
  wire [31:0] code,pcc;
  
  ifu i2(clk,reset,jsome,jr,npc_sel,zero,pcc,AOut,code);
  
  initial
  begin
    clk=1;reset=0;npc_sel=0;zero=0;jsome=0;jr=0;
    #5 reset=1;
    #5 reset=0;
    
    
    #50 npc_sel=0;zero=1;
    #50 npc_sel=0;zero=0;
    #50 npc_sel=0;zero=0;//jsome=1;
    #50 npc_sel=0;zero=0;jsome=1;
    #50 npc_sel=0;jsome=0;
  end  
  
  always
    #25 clk=~clk;
    
 endmodule   
