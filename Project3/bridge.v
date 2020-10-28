module bridge (prAddr, prRd, prWd, dev0_Rd, dev1_Rd, dev2_Rd, dev_Wd, dev_addr, irqin0, imout, wein, weout0, weout2);
	input [31:0] prAddr;
	input [31:0] prWd, dev0_Rd, dev1_Rd, dev2_Rd;
	input irqin0, wein;
	output weout0, weout2;
	output [5:0] imout;
	output [31:0] prRd, dev_Wd, dev_addr;
	wire HitDev0, HitDev1, HitDev2;
	
	
	assign HitDev0 = (prAddr >= 32'h00007f00 && prAddr < 32'h00007f10) ? 1 : 0;
	assign HitDev1 = prAddr >= 32'h00007f10 && prAddr < 32'h00007f20 ? 1 : 0;
	assign HitDev2 = prAddr >= 32'h00007f20 ? 1 : 0;
	
	assign weout0 = HitDev0 & wein;
	assign weout2 = HitDev2 & wein;
	assign prRd = HitDev0 ? dev0_Rd : HitDev1 ? dev1_Rd : dev2_Rd;
	assign dev_addr = prAddr;
	assign dev_Wd = prWd;
	assign imout = {5'b00000, irqin0};
	
endmodule
