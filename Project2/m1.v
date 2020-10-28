module M1(clk,GPRSel,in0,in1,in2,WrReg);
  input clk;
  input [1:0]GPRSel;
  input [31:0]in0,in1,in2;
  output [31:0]WrReg;
  
  
  wire zz=32'h0000_0000;
  
  
  assign WrReg=(GPRSel==2'b00)?in0:((GPRSel==2'b01)?in1:(GPRSel==2'b10)?in2:zz);
   
    
endmodule

