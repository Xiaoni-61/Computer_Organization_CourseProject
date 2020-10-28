
module mach_test;
  reg clk,rst;
  reg [31:0]inputt;
  
  mach ma(clk,rst,inputt);
  
  initial
  begin
    `ifdef DEBUG
    $display("\t\t\t\t DEBUG");
    `else
    $display("\t\t\t\t lzl");
    `endif
    $display("\t\t\t\t 18061225");
    
    
    clk=0;rst=0;inputt=32'd5;
    #5 rst=1;
    #5 rst=0;
  
    
    #12000 inputt=32'd80;
    
  end  
  
  always
    #25 clk=~clk;
    
 endmodule   


