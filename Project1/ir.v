module ir(irin,imm,rs,rt,rd,jadd);
  
  
  //input IrWr;
  input [31:0]irin;
  output [15:0]imm;
  
  output [31:0]rs,rt,rd;
  output [25:0]jadd;            //????
  
  wire [31:0]temp;
  
 
 
  assign temp=irin;
    
  
  
  
  assign imm={temp[15:0]};
  
  assign rs={{27{1'b0}},temp[25:21]};
  assign rt={{27{1'b0}},temp[20:16]};
  assign rd={{27{1'b0}},temp[15:11]};
  assign jadd={temp[25:0]};
  
endmodule
