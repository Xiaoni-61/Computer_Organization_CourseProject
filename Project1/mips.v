module mips(clk, rst);
input clk;   // clock
input rst;   // reset

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
wire [1:0] WDSel,GPRSel,ExtOp;


wire [15:0]imm;
  
wire [31:0]rs,rt,rd;
wire [25:0]jadd;  //j/jal address

wire of;          //for addi order(record)
wire [31:0]out;    //m1 third port
wire [31:0]WrReg;  //m1 out
wire [31:0]WrDataa;//m2 out
wire [31:0]M3out; //m3 out

wire [31:0]ALUOut;
wire [31:0]DMOut;  

wire [31:0]A,B;   //gpr out
wire [31:0]imm32; //ext out


wire [9:0] addr;  //to dm addr
wire sb;          //sb odder
wire lb;          //lb odder

ifu pc(.clk(clk),.reset(rst),.jsome(jsome),.jr(jr),.npc_sel(npc_sel),.zero(zero),.pcc(pcc),.AOut(A),.code(code));

      //pcc is for jal



contro con(.clk(clk),.code(code),.Zero(zero),.ALU_OP(ALU_OP),.WDSel(WDSel),.GPRSel(GPRSel),.ExtOp(ExtOp),.GPRWr(GPRWr),.BSel(BSel),.DMWr(DMWr),.jsome(jsome),.npc_sel(npc_sel),.jr(jr),.jal(jal),.sb(sb),.lb(lb));
  
ALU alu1(.clk(clk),.ALU_OP(ALU_OP),.A(A),.B(M3out),.ALUOut(ALUOut),.Zero(zero),.OF(of));

ir ir1(.irin(code),.imm(imm),.rs(rs),.rt(rt),.rd(rd),.jadd(jadd));

IF if1(.clk(clk),.of(of),.jal(jal),.out(out));

M1 m1(.clk(clk),.GPRSel(GPRSel),.in0(rt),.in1(rd),.in2(out),.WrReg(WrReg));

M2 m2(.clk(clk),.WDSel(WDSel),.inn0(ALUOut),.inn1(DMOut),.inn2(pcc),.WrData(WrDataa));

GPR gpr1(.clk(clk),.ReadR1(rs),.ReadR2(rt),.WrR(WrReg),.WrData(WrDataa),.GPRWr(GPRWr),.A(A),.B(B),.of(of));

EXT ext1(.clk(clk),.imm16(imm),.imm32(imm32),.ExtOp(ExtOp));

M3 m3(.clk(clk),.B(B),.imm32(imm32),.BSel(BSel),.M3out(M3out));



ALUtoDM_addr oo(.ALUout(ALUOut),.addr(addr));

dm_1k dm(.addr(addr),.din(B),.we(DMWr),.clk(clk),.dout(DMOut),.sb(sb),.lb(lb));



endmodule