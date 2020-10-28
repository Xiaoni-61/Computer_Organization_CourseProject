module GPR(clk,ReadR1,ReadR2,WrR,WrData,GPRWr,A,B,of);
  
  input clk;
  input GPRWr;
  input of;
  input [31:0]ReadR1,ReadR2,WrR;
  input [31:0]WrData;
  output wire[31:0]A,B;
  
  reg [31:0] gpr1[31:0];       //????
  
  always@(negedge clk)
  begin
    gpr1[0]=0;
  end
  
  always@(posedge clk  )
  begin
    
    gpr1[0]=0;
    if(GPRWr)
      begin
      gpr1[WrR]=WrData;
        `ifdef DEBUG
            $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,
            %8X", 0, rf[1], rf[2], rf[3], rf[4], rf[5],
            rf[6], rf[7]);
            $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,
            %8X", rf[8], rf[9], rf[10], rf[11], rf[12],
            rf[13], rf[14], rf[15]);
            $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,
            %8X", rf[16], rf[17], rf[18], rf[19], rf[20],
          	 rf[21], rf[22], rf[23]);
            $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X,
            %8X", rf[24], rf[25], rf[26], rf[27], rf[28],
            rf[29], rf[30], rf[31]);
        `endif

      end
    if(of)
      gpr1[5'b11110]=32'h0000_0001;
    
  end
  assign A=gpr1[ReadR1];
  assign  B=gpr1[ReadR2];
  
endmodule