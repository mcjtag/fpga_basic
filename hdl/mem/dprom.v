`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dmitry Matyunin (https://github.com/mcjtag)
// 
// Create Date: 29.07.2020 19:31:33
// Design Name: 
// Module Name: dprom
// Project Name: dprom
// Target Devices:
// Tool Versions:
// Description: Dual Port ROM
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

module dprom #(
	parameter MEMORY_TYPE = "block", // "block" or "distributed" 
	parameter DATA_WIDTH = 8,
	parameter ADDR_WIDTH = 5,
	parameter INIT_FILE = "rom.mem"
)
(
	input wire clk,
	input wire ena,
	input wire enb,
	input wire [ADDR_WIDTH-1:0]addra,
	input wire [ADDR_WIDTH-1:0]addrb,
	output wire [DATA_WIDTH-1:0]douta,
	output wire [DATA_WIDTH-1:0]doutb
);

(* rom_style = MEMORY_TYPE *) reg [DATA_WIDTH-1:0]rom[2**ADDR_WIDTH-1:0];
reg [DATA_WIDTH-1:0]rdouta; 
reg [DATA_WIDTH-1:0]rdoutb;
integer i;

assign douta = rdouta;
assign doutb = rdoutb;

initial begin
	$readmemh(INIT_FILE, rom); 
end

always @(posedge clk) begin
	if (ena == 1'b1) begin
		rdouta <= rom[addra];
	end
	if (enb == 1'b1) begin 
		rdoutb <= rom[addrb];
	end
end
	
endmodule      
