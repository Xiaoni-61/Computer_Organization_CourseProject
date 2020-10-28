module M2(clk,WDSel,inn0,inn1,inn2,inn3,inn4,WrData);
  input clk;
  input [2:0]WDSel;
  input [31:0]inn1,inn2,inn0,inn3,inn4;
  output [31:0]WrData;
  
  assign WrData=
  (WDSel==3'b000)?inn0:
  (WDSel==3'b001)?inn1:
  (WDSel==3'b010)?inn2:
  (WDSel==3'b011)?inn3:
  (WDSel==3'b100)?inn4:
  32'h00000000;  
  
   
    
endmodule


