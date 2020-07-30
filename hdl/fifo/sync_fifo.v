`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dmitry Matyunin (https://github.com/mcjtag)
// 
// Create Date: 25.05.2020 20:13:33
// Design Name: 
// Module Name: sync_fifo
// Project Name: sync_fifo
// Target Devices:
// Tool Versions:
// Description: Synchronous FIFO
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// License: MIT
//  Copyright (c) 2020 Dmitry Matyunin
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
// 
//////////////////////////////////////////////////////////////////////////////////

module sync_fifo #(
	parameter DATA_WIDTH = 4,
	parameter DATA_DEPTH = 8,
	parameter MODE = "std"				/* "std", "fwft" */
)
(
	input wire clk,
	input wire rst,
	input wire [DATA_WIDTH-1:0]din,
	input wire wr_en,
	output wire full,
	output wire [DATA_WIDTH-1:0]dout,
	input wire rd_en,
	output wire empty,
	output wire valid
);

localparam ADDR_WIDTH = $clog2(DATA_DEPTH);

/* RAM */
reg [DATA_WIDTH-1:0]ram[2**ADDR_WIDTH-1:0];
wire [DATA_WIDTH-1:0]ram_dina;
wire [ADDR_WIDTH-1:0]ram_addra;
wire [ADDR_WIDTH-1:0]ram_addrb;
wire ram_wea;
wire ram_reb;
reg [DATA_WIDTH-1:0]ram_doutb;
integer i;

/* FIFO */
reg [ADDR_WIDTH-1:0]wr_ptr;
reg [ADDR_WIDTH-1:0]rd_ptr;
reg [ADDR_WIDTH:0]count;
reg flag_full;
reg flag_empty;
reg dout_valid;
wire wr_valid;
wire rd_valid;
wire tmp_rd_en;

/* RAM */
assign ram_dina = din;
assign ram_addra = wr_ptr;
assign ram_addrb = rd_ptr;
assign ram_wea = wr_valid;
assign ram_reb = rd_valid;
assign dout = ram_doutb;

/* FIFO */
assign wr_valid = wr_en & ~flag_full;
assign rd_valid = tmp_rd_en & ~flag_empty;
assign full = flag_full;
assign valid = dout_valid;

/* SDPRAM */
initial begin
	for (i = 0; i < 2**ADDR_WIDTH; i = i + 1) begin
		ram[i] = 0;
	end
end

always @(posedge clk) begin
	if (ram_wea) begin
		ram[ram_addra] <= ram_dina;
	end
	if (ram_reb) begin
		ram_doutb <= ram[ram_addrb];
	end
end

/* FIFO */
always @(posedge clk) begin
	if (rst == 1'b1) begin
		wr_ptr <= 0;
		rd_ptr <= 0;
		count <= 0;
	end else begin
		if (wr_valid == 1'b1) begin
			if (wr_ptr == (DATA_DEPTH - 1)) begin
				wr_ptr <= 0;
			end else begin
				wr_ptr <= wr_ptr + 1;
			end
		end
		if (rd_valid == 1'b1) begin
			if (rd_ptr == (DATA_DEPTH - 1)) begin
				rd_ptr <= 0;
			end else begin
				rd_ptr <= rd_ptr + 1;
			end
		end
		case ({wr_valid,rd_valid})
		2'b01: count <= count - 1;
		2'b10: count <= count + 1;
		endcase
	end
end

always @(*) begin
	if (rst == 1'b1) begin
		flag_full = 1'b1;
		flag_empty = 1'b1;
	end else begin
		flag_full = (count == DATA_DEPTH) ? 1'b1 : 1'b0;
		flag_empty = (count == 0) ? 1'b1 : 1'b0;
	end
end

/* STD & FWFT Read Control */
generate if (MODE == "std") begin
	assign empty = flag_empty;
	assign tmp_rd_en = rd_en;
	
	always @(posedge clk) begin
		dout_valid <= rd_valid; 
	end
end else if (MODE == "fwft") begin
	assign empty = !dout_valid;
	assign tmp_rd_en = !flag_empty && (!dout_valid || rd_en);

	always @(posedge clk) begin
		if (rst == 1'b1) begin
			dout_valid <= 1'b0;
		end else begin
			if (tmp_rd_en == 1'b1) begin
				dout_valid <= 1'b1;
			end else if (rd_en == 1'b1) begin
				dout_valid <= 1'b0;
			end
		end
	end
end endgenerate

endmodule
