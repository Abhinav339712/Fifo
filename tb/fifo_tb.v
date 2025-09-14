module fifo_tb();
reg clk,rst,wr,en;
reg [7:0] data_in;
wire [7:0] data_out;
wire full;
wire empty;

integer i;

parameter CYCLE = 10;

fifo FIFO(.clk(clk),.rst(rst),.wr(wr),.en(en),.data_in(data_in),.data_out(data_out),.full(full),.empty(empty));

always
begin
	#(CYCLE/2)
	clk = 1'b0;
	#(CYCLE/2)
	clk = ~clk;
end

task initialize();
	begin
		{wr,en,data_in} = 1'b0;
	end
endtask

task reset();
	begin
		@(negedge clk)
		rst = 1'b1;
		@(negedge clk)
		rst = 1'b0;
	end
endtask

task write(input [7:0] in);
	begin
	@(negedge clk)
	wr = 1;
	data_in=in;
	@(negedge clk)
	wr=0;
	end
endtask


task read();
	begin
	@(negedge clk)
	en = 1;
	@(negedge clk)
	wr=0;
	end
endtask


initial
begin
	reset();
	write(8'hAA);
	write(8'hCC);
	write(8'h55);
	read();
	read();
	read();
	
	
	

end

initial
begin 
#400;
$finish;
end

initial
$monitor("Input data_in = %d,data_out=%d",data_in,data_out);

endmodule























