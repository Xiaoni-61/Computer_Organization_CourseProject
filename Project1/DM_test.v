module DM_test;
  reg clk;
  reg we;
  
  reg [9:0]addr;
  reg [31:0]din;
  wire [31:0] dout;
  
  
  dm_1k i1(addr,din,we,clk,dout);
  initial
  begin
    clk=1;
    
    addr=10'b00000_00100;
    din=32'h1234_5678;
    #150  we=0;
    #150  we=1;
  end  
  
  always
    #25 clk=~clk;
    
 endmodule   


