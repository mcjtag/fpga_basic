`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dmitry Matyunin (https://github.com/mcjtag)
// 
// Create Date: 18.05.2020 22:39:21
// Design Name: 
// Module Name: encoder
// Project Name: encoder
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

module encoder #(
	parameter DATA_WIDTH = 4
)
(
	input wire [DATA_WIDTH-1:0]din,
	output wire [$clog2(DATA_WIDTH)-1:0]dout,
	output wire err
);

reg [$clog2(DATA_WIDTH)-1:0]enc;
integer i;

assign dout = enc;
assign err = (2**enc == din) ? 1'b0 : 1'b1;

always @(*) begin
	if (din != 0) begin
		for (i = 0; i < DATA_WIDTH; i = i + 1) begin
			if (2**i == (din & 2**i)) begin
				enc = i;
			end
		end
	end else begin
		enc = 0;
	end
end

endmodule
