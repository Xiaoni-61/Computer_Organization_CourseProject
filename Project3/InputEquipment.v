module InputEquipment(inn,addr,keyout);
  input [31:0]inn;
  input [3:2]addr;
  output [31:0]keyout;
  
  assign keyout=inn;
  
  
endmodule
