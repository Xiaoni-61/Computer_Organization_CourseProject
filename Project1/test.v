module test;
  reg clk,reset,npc_sel,zero;
  wire [31:0] insout;
  ifu i1(clk,reset,npc_sel,zero,insout);
  initial
  begin
    clk=1;reset=0;npc_sel=0;zero=0;
    #5 reset=1;
    #5 reset=0;
    
    $readmemh("code.txt",i1.im);
    #50 npc_sel=1;zero=1;
    #50 npc_sel=0;zero=0;
  end  
  
  always
    #30 clk=~clk;
    
 endmodule   
