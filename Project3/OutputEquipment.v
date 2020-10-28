module OutputEquipment(clk,we,addr,datain,dsout);
  input clk;
	input we;
	input [3:2]addr;
	input [31:0] datain;
  output [31:0] dsout;
  
  reg [31:0]d1,d2;
  
  always@(posedge clk)
  begin
    if(we)
      begin
        if(addr==0)
          d1 = datain;
        else if(addr==1)
          d2 = datain;
      end
  end
  
  assign dsout =(addr==0)?d1:(addr==1)?d2:32'h0000_0000;
  
endmodule