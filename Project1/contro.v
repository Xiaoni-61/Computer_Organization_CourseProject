module contro(clk,code,Zero,ALU_OP,WDSel,GPRSel,ExtOp,GPRWr,BSel,DMWr,jsome,npc_sel,jr,jal,sb,lb);
  
input clk;
input [31:0] code;
input Zero;
output reg [2:0] ALU_OP;
output reg GPRWr,BSel,DMWr,jsome,jr,npc_sel,jal,sb,lb;    //jsome is about j/jal decite and so on,   npc_sel is for beq 
//output reg IrWr;
output reg [1:0] WDSel,GPRSel,ExtOp;
reg [4:0] r0,r1,r2;
reg [15:0] imm;
reg [25:0] address;

always@(*)
begin
 if(code[31:26]==6'b000000) //?????R?
    begin
      r0=code[25:21];       //rs
      r1=code[20:16];       //rt
      r2=code[15:11];       //rd
      
      DMWr=1'b0;
      jsome=1'b0;
      npc_sel=1'b0;
      BSel=1'b0;
      case(code[5:0])   
         6'b100001:begin ALU_OP=3'B000; GPRSel=2'b01; WDSel=2'b00;GPRWr=1'b1;jr=1'b0;end    //addu
         6'b100011:begin ALU_OP=3'B001; GPRSel=2'b01; WDSel=2'b00;GPRWr=1'b1;jr=1'b0;end    //subu
         6'b101010:begin ALU_OP=3'B101; GPRSel=2'b01; WDSel=2'b00;GPRWr=1'b1;jr=1'b0;end    //slt
         6'b001000:begin ALU_OP=3'B011; jr=1'b1;GPRWr=1'b0;end                              //jr
         
        endcase
     end
     
     
     
  if(code[31:29]==3'b001)         //I? return GPR
    begin
      imm=code[15:0];
      
      r0=code[25:21];       //rs
      r1=code[20:16];       //rt
      
      DMWr=1'b0;
      GPRSel=2'b00;
      GPRWr=1'b1;
      WDSel=2'b00;
      BSel=1'b1;
      jr=1'b0;
      jsome=1'b0;
      case(code[31:26])
      6'b001101: begin ALU_OP=3'B011;ExtOp=2'b00;npc_sel=0;WDSel=2'b00;sb=0;end      //ori
      6'b001000: begin ALU_OP=3'B110;ExtOp=2'b01;npc_sel=0;WDSel=2'b00;end      //addi
      6'b001001: begin ALU_OP=3'B000;ExtOp=2'b01;npc_sel=0;WDSel=2'b00;end      //addiu
      6'b001111: begin ALU_OP=3'B011;ExtOp=2'b10;npc_sel=0;WDSel=2'b00;end      //lui
      endcase
    end
    
    

  if(code[31:30]==2'b10)     //??I???/????
    begin
      imm=code[15:0];
      
      r0=code[25:21];       //rs
      r1=code[20:16];       //rt
      
      BSel=1'b1;
      jr=1'b0;
      jsome=1'b0;
      ALU_OP=3'b000;
      ExtOp=2'b01;
      npc_sel=0;
      
      case(code[31:26])
      6'b100011: begin GPRWr=1;GPRSel=2'b00;WDSel=2'b01;DMWr=1'b0;end   //lw
      6'b101011: begin GPRWr=0;DMWr=1'b1;end    //sw
      6'b101000: begin GPRWr=0;sb=1;DMWr=0;end      //sb
      6'b100000: begin GPRWr=1;lb=1'b1;GPRSel=2'b00;WDSel=2'b01;DMWr=1'b0;end //lb
      endcase
    end


  if(code[31:27]==5'b00010)             //I?????
    begin
      imm=code[15:0];
      r0=code[25:21];       //rs
      r1=code[20:16];       //rt
      
      jr=1'b0;
      jsome=1'b0;
     case(code[31:26])
       
     6'b000100:begin ALU_OP=3'b001;GPRWr=1'b0;npc_sel=1'b1;DMWr=1'b0;BSel=1'b0; end         //beq
     
     endcase
     end
     
     
  if(code[31:27]==5'b00001)
    begin
     address=code[25:0];
     
     jsome=1'b1;
   
     DMWr=1'b0;
     npc_sel=1'b0;
     jr=1'b0;
     
    case(code[31:26])
     6'b000010:begin GPRWr=1'b0; end   //j
     6'b000011:begin jal=1'b1;GPRWr=1'b1;GPRSel=2'b10; WDSel=2'b10;end    //jal
    endcase
    end 
     
end
endmodule




