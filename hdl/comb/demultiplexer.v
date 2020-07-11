`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dmitry Matyunin (https://github.com/mcjtag)
// 
// Create Date: 17.05.2020 22:38:05
// Design Name: 
// Module Name: demultiplexer
// Project Name: demultiplexer
// Target Devices:
// Tool Versions:
// Description: 
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

module demultiplexer #(
	parameter DATA_WIDTH = 8,
	parameter CHAN_NUM = 4,
	parameter SEL_WIDTH = $clog2(CHAN_NUM)
)
(
	input wire [DATA_WIDTH-1:0]din,
	input wire [SEL_WIDTH-1:0]sel,
	output wire [DATA_WIDTH*CHAN_NUM-1:0]dout
);

reg [DATA_WIDTH*CHAN_NUM-1:0]demux_data;
integer i;

assign dout = demux_data;

always @(*) begin
	for (i = 0; i < CHAN_NUM; i = i + 1) begin
		if (i == sel) begin
			demux_data[DATA_WIDTH*(i+1)-1-:DATA_WIDTH] = din;
		end else begin
			demux_data[DATA_WIDTH*(i+1)-1-:DATA_WIDTH] <= 0;
		end
	end
end

endmodule
