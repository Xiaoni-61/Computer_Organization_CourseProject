module M2(clk,WDSel,inn0,inn1,inn2,WrData);
  input clk;
  input [1:0]WDSel;
  input [31:0]inn1,inn2,inn0;
  output [31:0]WrData;
  
  assign WrData=
  (WDSel==2'b00)?inn0:
  ((WDSel==2'b01)?inn1:
  (WDSel==2'b10)?inn2:
  32'h00000000);  
  
   
    
endmodule


