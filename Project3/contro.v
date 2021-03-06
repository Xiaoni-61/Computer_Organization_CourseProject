module contro(intReq,clk,code,Zero,ALU_OP,WDSel,GPRSel,ExtOp,GPRWr,BSel,DMWr,jsome,npc_sel,jr,jal,sb,lb,enpc,eret,mfc0,mtc0,cp0Dst,cp0en,doutreg,exlset,exlclr,intctr,usedev,we);
  
input intReq;
input clk;
input [31:0] code;
input Zero;
input [31:0] doutreg;
output wire exlset,exlclr,intctr,usedev,we;
output wire [2:0] ALU_OP;
output wire GPRWr,BSel,DMWr,jsome,jr,npc_sel,jal,sb,lb,enpc,eret,mfc0,mtc0,cp0Dst,cp0en;    //jsome is about j/jal decite and so on,   npc_sel is for beq 
//output reg IrWr;
output wire [1:0] GPRSel,ExtOp;
output wire [2:0] WDSel;
wire addu1,subu1,slt1,jr1,ori1,lw1,sw1,beq1,lui1,addi1,addiu1,lb1,sb1,j1,jal1,eret1,mfc01,mtc01;
wire s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13;
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
	assign s10= fsm[3] & ~fsm[2] & fsm[1] & ~fsm[0];
	assign s11= fsm[3] & ~fsm[2] & fsm[1] & fsm[0];
	assign s12= fsm[3] & fsm[2] & ~fsm[1] & ~fsm[0];
	assign s13= fsm[3] & fsm[2] & ~fsm[1] & fsm[0];
  
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
  
  assign eret1 = !code[31]&code[30]&!code[29]&!code[28]&!code[27]&!code[26]&!code[5]&code[4]&code[3]&!code[2]&!code[1]&!code[0]; //010000 011000
	assign mtc01 = !code[31]&code[30]&!code[29]&!code[28]&!code[27]&!code[26]&!code[25]&!code[24]&code[23]&!code[22]&!code[21];    //01000000100
	assign mfc01 = !code[31]&code[30]&!code[29]&!code[28]&!code[27]&!code[26]&!code[25]&!code[24]&!code[23]&!code[22]&!code[21];   //01000000000
  //assign bgez1=!code[31]&!code[30]&!code[29]&!code[28]&!code[27]&code[26];    //000001
  
  assign j1=!code[31]&!code[30]&!code[29]&!code[28]&code[27]&!code[26];        //000010
  assign jal1=!code[31]&!code[30]&!code[29]&!code[28]&code[27]&code[26];      //000011

  assign GPRWr= s4 | s7 | (jal1&s9) | mfc01 & s12;
  assign BSel= ori1 | lw1 | sw1 | lb1 | sb1 | lui1 | addi1 | addiu1;
  assign DMWr= s5 & ((sw1|sb1)& ~usedev);
  assign jsome = (j1 | jal1) & s9;
  assign jr = jr1 | s9;
  assign npc_sel = beq1 & s8;
  assign jal =  jal1;
  assign sb = sb1;
  assign lb = lb1 & s4;
  assign enpc = s0 | s8 | ((jr1 | jal1 | j1 | eret1) & s9) | s10;
  
  assign eret= eret1 & s9;
  assign mtc0= mtc01 & s13;
  assign mfc0= mfc01 & s12;
  
  assign cp0Dst = intReq & s10;
  assign cp0en = mtc0 | (intReq & s10);
 
 
  
  assign exlset = s10;
  assign exlclr = eret1;
  assign intctr = intReq & s10;
  assign usedev = ( sw1 | lw1)? doutreg>=32'h00007f00 ?1:0:0;
  assign we = (sw1 & s5 & usedev);
  
  
  
  assign ALU_OP=(addu1 | lw1 | sw1 | lb1 | sb1 | addiu1)?3'b000: (subu1 | beq1)?3'b001: (ori1 | lui1)?3'b011: (addi1)?3'b110: (slt1)?3'b101:3'b111; 
  
  assign WDSel=(addu1 | subu1 | ori1 | lui1 | addi1 | addiu1 | slt1)?3'b000: ((lw1 &~usedev) | lb1)?3'b001: (jal1)?3'b010: (mfc01)?3'b011: (lw1 & usedev)?3'b100:3'b111;
  assign GPRSel=(ori1 | lw1 | lb1 | lui1 | addi1 | addiu1 | mfc01)?2'b00: (addu1 | subu1 | slt1 )?2'b01: (jal1)?2'b10:2'b11;
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
					end else if (jal1 || jr1 || j1 || eret1) begin 
						nextfsm = 9;
					
					end  else if (mtc01 || mfc01) begin 
						nextfsm = 11;
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
				4:begin
				    if(intReq)begin
				          nextfsm = 10;
				     end else begin
				          nextfsm = 0;
				     end
				  end
				5: begin
				    if(intReq)begin
				          nextfsm = 10;
				     end else begin
				          nextfsm = 0;
				     end
				  end
				
				6: nextfsm = 7;
				7: begin
				    if(intReq)begin
				          nextfsm = 10;
				     end else begin
				          nextfsm = 0;
				     end
				  end
				8: begin
				    if(intReq)begin
				          nextfsm = 10;
				     end else begin
				          nextfsm = 1;
				     end
				  end
				9: begin
				    if(intReq)begin
				          nextfsm = 10;
				     end else begin
				          nextfsm = 1;
				     end
				  end
				10:begin
				     if (jal1 || jr1 || j1 || eret1 ||beq1) begin 
						      nextfsm = 1;
					   end
					   else begin
					       nextfsm = 0;
					     end
				     end
				11:begin 
					if (mfc01) begin 
						nextfsm = 12;
					end else begin 
						nextfsm = 13;
					end
				end
				12:begin 
					if (intReq) begin 
						nextfsm = 10;
					end else begin 
						nextfsm = 0;
					end
				end
				13:begin 
					if (intReq) begin 
						nextfsm = 10;
					end else begin 
						nextfsm = 0;
					end
				end
				
				default : nextfsm = 0;
			endcase
		
		fsm <= nextfsm;
	end
endmodule
