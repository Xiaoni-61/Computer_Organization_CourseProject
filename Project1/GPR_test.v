
module GPR_test;
  reg clk;
  
  reg GPRWr;
  reg [31:0]ReadR1,ReadR2,WrR;
  reg [31:0]WrData;
  wire [31:0]A,B;
  
  GPR i1(clk,ReadR1,ReadR2,WrR,WrData,GPRWr,A,B);
  
  
  initial
  begin
    clk=1;
    ReadR1=5'b00001;
    ReadR2=5'b00010;
    
    WrR=5'b00100;
    WrData=32'h12345678;
    #50 GPRWr=1;
    #50 GPRWr=0;
    #50 GPRWr=1;ReadR1=5'b00100;WrR=5'b01001;
    #50 GPRWr=0;ReadR2=5'b01001;
    
  end  
  
  always
    #25 clk=~clk;
    
 endmodule   

