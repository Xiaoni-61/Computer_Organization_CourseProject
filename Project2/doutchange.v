module doutchange(addr,dout,doutt,lb);
  input [9:0]addr;
  input [31:0]dout;
  output [31:0]doutt;
  input lb;
  
  wire [1:0]t1;
  wire [31:0]temp1;
  //wire [9:0]a,b;
  
  //assign a=addr/(3'b100);
  //assign b=a*(3'b100);
  //assign t1=addr-b;
  //assign t1=addr%(3'b100);
  assign t1=addr%(3'b100);
  
  assign temp1=(t1==2'b00)?{{24{dout[7]}},dout[7:0]}:
               (t1==2'b01)?{{24{dout[15]}},dout[15:8]}:
               (t1==2'b10)?{{24{dout[23]}},dout[23:16]}:
               (t1==2'b11)?{{24{dout[31]}},dout[31:24]}:32'h00000000;
  assign doutt=(lb)?temp1:dout;
  
endmodule 
