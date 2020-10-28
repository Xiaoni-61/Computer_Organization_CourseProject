module sb(BOut,addr,sb,SBOut,DMOut);
  input [31:0]DMOut;
  input [31:0]BOut;
  input [9:0]addr;
  input sb;
  output [31:0]SBOut;
  
  wire [31:0]temp;
  wire [1:0]addr2;
  assign addr2=addr%(3'b100);

  
  assign temp=(addr2==2'b00)?{DMOut[31:8],BOut[7:0]}:
              (addr2==2'b01)?{DMOut[31:16],BOut[7:0],DMOut[7:0]}:
              (addr2==2'b10)?{DMOut[31:24],BOut[7:0],DMOut[15:0]}:
              (addr2==2'b11)?{BOut[7:0],DMOut[23:0]}:32'h00000000;
              
  assign SBOut=(sb)?temp:BOut;
  
endmodule