
module M2_test;
  reg clk;
  
  reg [1:0]WDSel;
  reg [31:0]inn1,inn2,inn0;
  wire [31:0]WrData;
  
  M2 i1(clk,WDSel,inn0,inn1,inn2,WrData);
  
  
  
  
  initial
  begin
    clk=1;
    inn0=1;
    inn1=2;
    inn2=3;
    
    #50 WDSel=2'b00;
    #50 WDSel=3'b01;
    #50 WDSel=3'b10;
    
  end  
  
  always
    #25 clk=~clk;
    
 endmodule   

