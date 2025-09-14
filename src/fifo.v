module fifo(clk,rst,wr,en,data_in,data_out,full,empty);
input wr,en,clk,rst;
input [7:0]data_in;
output reg [7:0]data_out;
output full;
output empty;



reg[7:0]mem[0:15];
reg[4:0]en_ptr,wr_ptr;

assign full = (wr_ptr[4] != en_ptr[4]) && (wr_ptr[3:0] == en_ptr[3:0]);
assign empty = (wr_ptr == en_ptr);

always@(posedge clk)
begin
	if(rst)
	begin
		wr_ptr <= 0;
		en_ptr <= 0;
		data_out <= 0;
		end
		else if(wr && !full)
	begin
		mem[wr_ptr [3:0]] <= data_in;
		wr_ptr <= wr_ptr + 1;
	end
	else if(en && !empty)
	begin
		data_out <= mem[en_ptr];
	        en_ptr <= en_ptr + 1;
	end
	else
		data_out <= 8'bz;
	end

endmodule
	


