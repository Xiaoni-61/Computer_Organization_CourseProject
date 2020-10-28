module mips(clk, rst, imout, prRd, prWd, prAddr, devwe);
input clk;   // clock
input rst;   // reset
input [5:0]imout;
input [31:0] prRd;
output [31:0] prWd;
output [31:0] prAddr;
output devwe;


wire npc_sel;     //beq controller
wire zero;        //ALUOut is 0 or not
wire jsome;       //j/jal controller
wire jr;          //jr controller
wire [31:0]AOut;  //for jr order
 
wire [31:0]pcc;   //for jal order


wire [31:0] code; //code

wire [2:0] ALU_OP;
wire GPRWr,BSel,DMWr;    
wire jal;         //jal controller
wire [1:0] GPRSel,ExtOp;
wire [2:0] WDSel;


wire [15:0]imm;
  
wire [31:0]rs,rt,rd;
wire [25:0]jadd;  //j/jal address

wire of;          //for addi order(record)
wire [31:0]out;    //m1 third port
wire [31:0]WrReg;  //m1 out
wire [31:0]WrDataa;//m2 out
wire [31:0]M3out; //m3 out

wire [31:0]toALUOut;
wire [31:0]fromALUOut;
wire [31:0]DMOut,DMOutchange;  
wire [31:0]fromDR;

wire [31:0]toA,toB;   //gpr out
wire [31:0]fromA,fromB;//register A,B out
wire [31:0]imm32; //ext out


wire [9:0] addr;  //to dm addr
wire sb;          //sb odder
wire lb;          //lb odder

wire enpc;          //pc upgrade

wire [31:0]sbout;

wire intctr,eret,intreq,mfc0,mtc0,cp0Dst,cp0en,exlset,exlclr,usedev,devwe;
wire [31:0]epc,cp0out;
wire [4:0]sel;

wire [31:0]pc1;
ifu pc(.clk(clk),.reset(rst),.jsome(jsome),.jr(jr),.npc_sel(npc_sel),.zero(zero),.pcc(pcc),.AOut(fromA),.code(code),.enpc(enpc),.intctr(intctr),.eret(eret),.epc(epc),.pc1(pc1));

      //pcc is for jal

contro con(.intReq(intreq),.clk(clk),.code(code),.Zero(zero),.ALU_OP(ALU_OP),.WDSel(WDSel),.GPRSel(GPRSel),.ExtOp(ExtOp),.GPRWr(GPRWr),.BSel(BSel),.DMWr(DMWr),.jsome(jsome),
           .npc_sel(npc_sel),.jr(jr),.jal(jal),.sb(sb),.lb(lb),.enpc(enpc),.eret(eret),.mfc0(mfc0),.mtc0(mtc0),.cp0Dst(cp0Dst),.cp0en(cp0en),.doutreg(toALUOut),
           .exlset(exlset),.exlclr(exlclr),.intctr(intctr),.usedev(usedev),.we(devwe));

assign rd = {code[15:11]};
assign sel =  rd;
assign prAddr = toALUOut;
assign prWd = fromB;

CP0 cp0(.epcin(pc1),.din(fromB),.hwint(imout),.sel(sel),.wen(cp0en),.exlset(exlset),.exlclr(exlclr),.clk(clk),.rst(rst),.intreq(intreq),.epcstr(epc),.dout(cp0out));

ALU alu1(.clk(clk),.ALU_OP(ALU_OP),.A(fromA),.B(M3out),.ALUOut(toALUOut),.Zero(zero),.OF(of));

ir ir1(.irin(code),.imm(imm),.rs(rs),.rt(rt),.rd(rd),.jadd(jadd));

IF if1(.clk(clk),.of(of),.jal(jal),.out(out));

M1 m1(.clk(clk),.GPRSel(GPRSel),.in0(rt),.in1(rd),.in2(out),.WrReg(WrReg));

M2 m2(.clk(clk),.WDSel(WDSel),.inn0(fromALUOut),.inn1(fromDR),.inn2(pcc),.inn3(cp0out),.inn4(prRd),.WrData(WrDataa));

GPR gpr1(.clk(clk),.ReadR1(rs),.ReadR2(rt),.WrR(WrReg),.WrData(WrDataa),.GPRWr(GPRWr),.A(toA),.B(toB),.of(of));

EXT ext1(.clk(clk),.imm16(imm),.imm32(imm32),.ExtOp(ExtOp));

M3 m3(.clk(clk),.B(fromB),.imm32(imm32),.BSel(BSel),.M3out(M3out));

ALUtoDM_addr oo(.ALUout(fromALUOut),.addr(addr));

dm_1k dm(.addr(addr),.din(sbout),.we(DMWr),.clk(clk),.dout(DMOut));

sb sb1(.BOut(fromB),.addr(addr),.sb(sb),.SBOut(sbout),.DMOut(DMOut));

doutchange dc(.addr(addr),.dout(DMOut),.doutt(DMOutchange),.lb(lb));

register A(.clk(clk), .din(toA), .dout(fromA));

register B(.clk(clk), .din(toB), .dout(fromB));

register ALUOut(.clk(clk), .din(toALUOut), .dout(fromALUOut));

register DR(.clk(clk), .din(DMOutchange), .dout(fromDR));

endmodule
