module dm_1k(addr,din,we,clk,dout);
  
  
  input [13:0]addr;
  input [31:0]din;
  input we;
  input clk;
  output [31:0] dout;
  
  reg [7:0] dm[12287:0];
  
  integer i;
	initial begin
		for (i = 0; i < 1024; i =i + 1) begin
			
			dm[i] = 0;
	
		end
	end
  
  wire [3:0]t1;
  wire [13:0]tureaddr;
  assign t1=addr/(3'b100);
  assign tureaddr=t1*(3'b100);
  
  
  wire [7:0] temp;
  wire [31:0] temp1;
  assign temp=dm[tureaddr[13:0]];
  assign temp1={dm[tureaddr[13:0]+3], dm[tureaddr[13:0]+2], dm[tureaddr[13:0]+1], dm[tureaddr[13:0]]};    //!!attention  Maybe need modeify
  //assign dout=(lb)?{{24{temp[7]}},temp}:temp1;
  assign dout=temp1;
  
  always@(posedge clk)
  begin
    if(we)
      {dm[tureaddr[13:0]+3], dm[tureaddr[13:0]+2], dm[tureaddr[13:0]+1], dm[tureaddr[13:0]]}=din;      //same as the front
    
  end
  
  
endmodule



