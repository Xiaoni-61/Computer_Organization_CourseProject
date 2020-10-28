module ALUtoDM_addr(ALUout,addr);
  input [31:0] ALUout;
  output [13:0] addr;
  
  assign addr={ALUout[13:0]};
  
endmodule

