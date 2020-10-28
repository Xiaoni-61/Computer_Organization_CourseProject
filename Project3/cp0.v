module CP0 (epcin, din, hwint, sel, wen, exlset, exlclr, clk, rst, intreq, epcstr, dout);
	input [31:0] epcin;
	input [31:0] din;
	input [5:0] hwint;
	input [4:0] sel;
	input wen, exlset, exlclr, clk, rst;
	wire [31:0] cause, sr, prid;
	output [31:0] epcstr, dout;
	output intreq;
	
	reg [31:0] data [31:0];
	
	integer i;
	initial begin
		for (i = 0; i < 32; i = i + 1) begin
			data[i] = 0;
		end
		data[15] = 32'h18061225;
	end
	
	assign sr = data[12];
	assign cause = data[13];
	assign epcstr = data[14];
	assign prid = data[15];
	
	assign intreq = |(hwint[5:0] & sr[15:10]) & sr[0] & ~sr[1];
	assign dout = data[sel];
	
	
	 always@(*) 
	 data[14]=(intreq==1)?epcin:data[14];
	
	always @(posedge clk) begin
		if (rst)begin 
			for (i = 0; i < 32; i = i + 1) begin 
				if ((i != 15 )||(i!=14)) begin
					data[i] <= 0;
				end
				
			end
		end else begin
			if (wen) begin 
				data[sel] <= din;
			end
			if (exlset) begin 
				data[12][1] <= 1;
			end
			if (exlclr) begin 
				data[12][1] <= 0;
			end
		end
	end

endmodule

