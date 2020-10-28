module mach(clk,rst,inputt);
  input clk;
  input rst;
  input [31:0]inputt;
  
  wire [5:0]imout;
  
  
  wire [31:0]prRd,prWd,prAddr,dev_Wd,dev_addr;
  wire devwe,irq,we0,we2;
  
  wire [31:0]dout,keyout,dsout;
  
  mips cpu(.clk(clk),.rst(rst),.imout(imout),.prRd(prRd),.prWd(prWd),.prAddr(prAddr),.devwe(devwe));
  bridge bridge(.prAddr(prAddr),.prRd(prRd),.prWd(prWd),.dev0_Rd(dout),.dev1_Rd(keyout),.dev2_Rd(dsout),
                .dev_Wd(dev_Wd),.dev_addr(dev_addr),.irqin0(irq),.imout(imout),.wein(devwe),.weout0(we0),.weout2(we2));
  tc clock1(.clk(clk),.rst(rst),.addr(dev_addr[3:2]),.we(we0),.din(dev_Wd),.dout(dout),.irq(irq));
  InputEquipment in(.inn(inputt),.addr(dev_addr[3:2]),.keyout(keyout));
  OutputEquipment out(.clk(clk),.we(we2),.addr(dev_addr[3:2]),.datain(dev_Wd),.dsout(dsout));
  
endmodule 