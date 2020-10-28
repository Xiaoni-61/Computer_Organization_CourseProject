module tc (clk, rst, addr, we, din, dout, irq);
	input clk, rst, we;
	input [3:2] addr;
	input [31:0] din;
	output [31:0] dout;
	output irq;                        //Interrupt request
	reg [31:0] count = 0, ctrl = 0, preset = 0;
	reg irq = 0;
	wire [31:0] nextcount;
	
	
	always @(posedge clk) begin
		if (rst) begin 
			count <= preset;
			ctrl <= 0;
			preset <= 0;
		end 
		else if(we) begin 
			if(addr == 0)begin 
				ctrl <= din;				              //control signal
				irq = 0;
			end 
			else if (addr == 1)begin 
				preset = din;
				//ctrl[0] = 1;				             //allow count
				count = preset;				          //count to preset
			end
		end 
		
		
		
	  else if(ctrl[0]) 
		begin 
			if (~ctrl[1]) begin				          //Method 0
				if (count == 0 ) begin 
					ctrl[0] = 0;
					if (ctrl[3]) begin
						irq = 1;
					end
				end 
				else begin
					count = nextcount;
				end
			end 
			else begin					                   //Method 1
				if (count == 0 ) begin 
					if (ctrl[3]) begin
						irq = 1;
					end
					count = preset;
				end 
				else begin
					count = nextcount;
				end
			end
		end
	end
	
	assign dout = (addr == 0) ? ctrl : (addr == 1) ? preset : count;
	assign nextcount = count - 1;
endmodule

