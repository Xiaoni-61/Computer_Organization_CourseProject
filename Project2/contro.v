module contro(clk,code,Zero,ALU_OP,WDSel,GPRSel,ExtOp,GPRWr,BSel,DMWr,jsome,npc_sel,jr,jal,sb,lb,enpc);
  

input clk;
input [31:0] code;
input Zero;
output wire [2:0] ALU_OP;
output wire GPRWr,BSel,DMWr,jsome,jr,npc_sel,jal,sb,lb,enpc;    //jsome is about j/jal decite and so on,   npc_sel is for beq 
//output reg IrWr;
output wire [1:0] WDSel,GPRSel,ExtOp;
wire addu1,subu1,slt1,jr1,ori1,lw1,sw1,beq1,lui1,addi1,addiu1,lb1,sb1,j1,jal1;
wire s0, s1, s2, s3, s4, s5, s6, s7, s8, s9;
	reg [3:0] fsm, nextfsm;
	assign s0 = ~fsm[3] & ~fsm[2] & ~fsm[1] & ~fsm[0];
	assign s1 = ~fsm[3] & ~fsm[2] & ~fsm[1] & fsm[0];
	assign s2 = ~fsm[3] & ~fsm[2] & fsm[1] & ~fsm[0];
	assign s3 = ~fsm[3] & ~fsm[2] & fsm[1] & fsm[0];
	assign s4 = ~fsm[3] & fsm[2] & ~fsm[1] & ~fsm[0];
	assign s5 = ~fsm[3] & fsm[2] & ~fsm[1] & fsm[0];
	assign s6 = ~fsm[3] & fsm[2] & fsm[1] & ~fsm[0];
	assign s7 = ~fsm[3] & fsm[2] & fsm[1] & fsm[0];
	assign s8 = fsm[3] & ~fsm[2] & ~fsm[1] & ~fsm[0];
	assign s9 = fsm[3] & ~fsm[2] & ~fsm[1] & fsm[0];
	
  
  assign addu1=!code[31]&!code[30]&!code[29]&!code[28]&!code[27]&!code[26]&code[5]&!code[4]&!code[3]&!code[2]&!code[1]&code[0];   //000000 100001
  assign subu1=!code[31]&!code[30]&!code[29]&!code[28]&!code[27]&!code[26]&code[5]&!code[4]&!code[3]&!code[2]&code[1]&code[0];    //000000 100011
  assign slt1=!code[31]&!code[30]&!code[29]&!code[28]&!code[27]&!code[26]&code[5]&!code[4]&code[3]&!code[2]&code[1]&!code[0];     //000000 101010
  assign jr1=!code[31]&!code[30]&!code[29]&!code[28]&!code[27]&!code[26]&!code[5]&!code[4]&code[3]&!code[2]&!code[1]&!code[0];    //000000 001000
    
  assign ori1=!code[31]&!code[30]&code[29]&code[28]&!code[27]&code[26];   //001101
  assign lw1=code[31]&!code[30]&!code[29]&!code[28]&code[27]&code[26];    //100011
  assign sw1=code[31]&!code[30]&code[29]&!code[28]&code[27]&code[26];     //101011
  assign beq1=!code[31]&!code[30]&!code[29]&code[28]&!code[27]&!code[26];      //000100
  assign lui1=!code[31]&!code[30]&code[29]&code[28]&code[27]&code[26];      //001111
  assign addi1=!code[31]&!code[30]&code[29]&!code[28]&!code[27]&!code[26];     //001000
  assign addiu1=!code[31]&!code[30]&code[29]&!code[28]&!code[27]&code[26];    //001001
  assign lb1=code[31]&!code[30]&!code[29]&!code[28]&!code[27]&!code[26];       //100000
  assign sb1=code[31]&!code[30]&code[29]&!code[28]&!code[27]&!code[26];       //101000
  
  //assign bgez1=!code[31]&!code[30]&!code[29]&!code[28]&!code[27]&code[26];    //000001
  
  assign j1=!code[31]&!code[30]&!code[29]&!code[28]&code[27]&!code[26];        //000010
  assign jal1=!code[31]&!code[30]&!code[29]&!code[28]&code[27]&code[26];      //000011

  assign GPRWr= s4 | s7 | (jal1&s9);
  assign BSel= ori1 | lw1 | sw1 | lb1 | sb1 | lui1 | addi1 | addiu1;
  assign DMWr= s5 & (sw1|sb1);
  assign jsome = (j1 | jal1) & s9;
  assign jr = jr1 | s9;
  assign npc_sel = beq1 & s8;
  assign jal =  jal1;
  assign sb = sb1;
  assign lb = lb1 & s4;
  assign enpc = s0 | s8 | ((jr1 | jal1 | j1) & s9) ;
  
  
  assign ALU_OP=(addu1 | lw1 | sw1 | lb1 | sb1 | addiu1)?3'b000: (subu1 | beq1)?3'b001: (ori1 | lui1)?3'b011: (addi1)?3'b110: (slt1)?3'b101:3'b111; 
  
  assign WDSel=(addu1 | subu1 | ori1 | lui1 | addi1 | addiu1 | slt1)?2'b00: (lw1 | lb1)?2'b01: (jal1)?2'b10:2'b11;
  assign GPRSel=(ori1 | lw1 | lb1 | lui1 | addi1 | addiu1)?2'b00: (addu1 | subu1 | slt1)?2'b01: (jal1)?2'b10:2'b11;
  assign ExtOp=(ori1)?2'b00: (lw1 | sw1 | lb1 | sb1 | addi1 | addiu1 )?2'b01: (lui1)?2'b10:2'b11;
 
  initial
  begin
    fsm=1;
  end
  
    always @(posedge clk) 
		 begin
			case (fsm)
				0: nextfsm = 1;	
				1: begin 
					if (lb1 || sb1 || lw1 || sw1) begin 
						nextfsm = 2;
					end else if (addu1 || subu1 || slt1 || ori1 || lui1 || addi1 || addiu1) begin 
						nextfsm = 6;
					end else if (beq1) begin
						nextfsm = 8;
					end else if (jal1 || jr1 || j1) begin 
						nextfsm = 9;
					
					end
				end
				2: begin 
					if (lw1 || lb1) begin 
						nextfsm = 3;
					end else 
						nextfsm = 5;
				end
				3: begin
					nextfsm = 4;
				end
				4: nextfsm = 0;
				5: nextfsm = 0;
				6: nextfsm = 7;
				7: nextfsm = 0;
				8: nextfsm = 1;
				9: nextfsm = 1;
				
				default : nextfsm = 0;
			endcase
		
		fsm <= nextfsm;
	end
endmodule
