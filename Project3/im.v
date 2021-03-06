module im_1k(addr,dout);   //1kb,addr is pc
input [12:0] addr;
output [31:0] dout;
reg [7:0] im[8191:0];

initial 
begin
//assign dout=32'h00000000;  
//$readmemh("code.txt",im);
$readmemh("main.txt",im,);
$readmemh("sub.txt",im,'h180);
end

wire [9:0]index;
assign index=addr;
assign dout={im[index],im[index+1],im[index+2],im[index+3]};

endmodule

