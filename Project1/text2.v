
module text2;
  reg clk,rst;
  
  mips i(clk, rst);
  initial
  begin
    `ifdef DEBUG
    $display("\t\t\t\t DEBUG");
    `else
    $display("\t\t\t\t lzl");
    `endif
    $display("\t\t\t\t 18061225");
    
    
    clk=1;rst=0;
    #5 rst=1;
    #5 rst=0;
    //$readmemh("code.txt",i.im.im);
    //$readmemh("code.txt",i.pc.im);
    
    
    
    
  end  
  
  always
    #25 clk=~clk;
    
 endmodule   

