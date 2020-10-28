module GPR(clk,ReadR1,ReadR2,WrR,WrData,GPRWr,A,B,of);
  
  input clk;
  input GPRWr;
  input of;
  input [31:0]ReadR1,ReadR2,WrR;
  input [31:0]WrData;
  output wire[31:0]A,B;
  
  reg [31:0] gpr1[31:0];       //????
  
  integer i;
	initial begin

		for (i = 0; i < 32; i = i + 1) begin
			gpr1[i] = 0;
		end
	end
  
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
        
      end
    if(of)
      gpr1[5'b11110]=32'h0000_0001;
    
  end
  assign A=gpr1[ReadR1];
  assign  B=gpr1[ReadR2];
  
endmodule
