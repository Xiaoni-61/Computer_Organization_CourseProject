module im_1k(addr,dout);   //1kb,addr is pc
input [9:0] addr;
output [31:0] dout;
reg [7:0] im[1023:0];

initial $readmemh("code.txt",im);
wire [9:0]index;
assign index=addr;
assign dout={im[index],im[index+1],im[index+2],im[index+3]};

endmodule

