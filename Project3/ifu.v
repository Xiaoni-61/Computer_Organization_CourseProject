module ifu(clk,reset,jsome,jr,npc_sel,zero,pcc,AOut,code,enpc,intctr,eret,epc,pc1);      //pcc is for jal, AOut is for jr
  input enpc;
  input clk,reset,npc_sel,zero,intctr,eret;
  
  input [31:0] epc;   //from cp0(epc)
  input jsome;
  input jr;
  input [31:0] AOut;
  output [31:0] code;
  
  output reg [31:0]pcc;
  output reg [31:0]pc1;
  
  wire [31:0] t1,t0,extout,temp;              //wire?????
  reg [31:0] pcnew,pc;
  wire [15:0] imm;
  
  
  
  im_1k im1(.addr(pc[12:0]),.dout(code));
  
  //assign insout={im[pc[9:0]],im[pc[9:0]+1],im[pc[9:0]+2],im[pc[9:0]+3]};    //for getting imm16
  assign imm=code[15:0];
  assign temp={{16{imm[15]}},imm};
  assign extout=temp<<2;
  
  //assign pcc=pc+4;
  
  always@(posedge clk)
  begin
    if(jsome)
      pcnew={pc[31:28],code[25:0],{2{1'b0}}};
    else if (eret)
      pcnew=epc;
    else if(npc_sel&&zero)
      pcnew=t1;
    else if(jr)
      pcnew=AOut;
    else if(intctr)
      pcnew= 32'h00004180;
    
    else
      pcnew=t0;
      
      pcc=pc+4;
      pc1=pc;
  end
  
  always@(posedge clk,posedge reset)
  begin
    if(reset) pc=32'h0000_3000;
    else
      if(enpc)
      pc=pcnew;
  end
  
  
  assign t0=pc+4;
  assign t1=t0+extout;
 
endmodule
