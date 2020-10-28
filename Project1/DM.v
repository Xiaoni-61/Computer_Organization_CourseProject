module dm_1k(addr,din,we,clk,dout,sb,lb);
  
  input sb,lb;
  input [9:0]addr;
  input [31:0]din;
  input we;
  input clk;
  output [31:0] dout;
  
  reg [7:0] dm[1023:0];
  
  //wire [7:0] dm1[1023:0];
  
  //dai ding
  //generate
  //genvar i;
  //for(i=0;i<=1023;i=i+1) begin : BLOCK0
  //assign dm1[i] = dm[i];
  //end
  //endgenerate
  
  
  
  
  wire [7:0] temp;
  wire [31:0] temp1;
  assign temp=dm[addr[9:0]];
  assign temp1={dm[addr[9:0]+3], dm[addr[9:0]+2], dm[addr[9:0]+1], dm[addr[9:0]]};    //!!attention  Maybe need modeify
  //assign dout=(lb)?{{24{temp[7]}},temp}:temp1;
  assign dout=temp1;
  
  always@(posedge clk)
  begin
    if(we)
      {dm[addr[9:0]+3], dm[addr[9:0]+2], dm[addr[9:0]+1], dm[addr[9:0]]}=din;      //same as the front
    if(sb)
       dm[addr[9:0]]=din[7:0]; 
  end
  
  
endmodule

