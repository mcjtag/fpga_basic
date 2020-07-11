`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dmitry Matyunin (https://github.com/mcjtag)
// 
// Create Date: 25.05.2020 22:37:43
// Design Name: 
// Module Name: majority
// Project Name: majority
// Target Devices:
// Tool Versions:
// Description: Majority Function
// Dependencies:
// Revision:
// Revision 0.01 - File Created
// Additional Comments: based on sorting network
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

module majority #(
	parameter DATA_WIDTH = 8
)
(
	input wire [DATA_WIDTH-1:0]din,
	output wire do
);

localparam AC = 2**$clog2(DATA_WIDTH);
localparam AD = AC-DATA_WIDTH;
localparam SS = $clog2(AC);

wire [AC-1:0]sd[SS:0];
wire [AC-1:0]tdo;
wire [DATA_WIDTH-1:0]td;

genvar ss, b, bs, n, c;

assign sd[0] = {din,{AD{1'b0}}};
assign tdo = sd[SS];
assign td = tdo[AC-1-:DATA_WIDTH];
assign do = td[DATA_WIDTH/2];

generate for (ss = 0; ss < SS; ss = ss + 1) begin
	localparam BN = AC/2**(ss+1);
	localparam BO = ss;
	wire [AC-1:0]sdi;
	wire [AC-1:0]sdo;
	assign sdi = sd[ss];
	assign sd[ss+1] = sdo;
	
	for (b = 0; b < BN; b = b + 1) begin
		localparam BDW = 2**(BO+1);
		localparam BP = b&1;
		localparam BS = BO+1;
		localparam BSDW = 2**(BO+1);
		wire [BDW-1:0]bdi;
		wire [BDW-1:0]bdo;
		wire [2**(BO+1)-1:0]bsd[BS:0];
		assign bdi = sdi[BDW*(b+1)-1-:BDW];
		assign sdo[BDW*(b+1)-1-:BDW] = bdo;
		assign bsd[0] = bdi;
		assign bdo = bsd[BS];

		for (bs = 0; bs < BS; bs = bs + 1) begin
			localparam NC = 2**bs;
			localparam NO = BS-bs-1;
			wire [BSDW-1:0]bsdi;
			wire [BSDW-1:0]bsdo;
			assign bsdi = bsd[bs];
			assign bsd[bs+1] = bsdo;
				
			for (n = 0; n < NC; n = n + 1) begin
				localparam NDW = 2**(NO+1);
				localparam CN = 2**NO;
				wire [NDW-1:0]ndi;
				wire [NDW-1:0]ndo;
				assign ndi = bsdi[NDW*(n+1)-1-:NDW];
				assign bsdo[NDW*(n+1)-1-:NDW] = ndo;
				
				for (c = 0; c < CN; c = c + 1) begin
					wire a, b;
					assign a = ndi[c+CN*0];
					assign b = ndi[c+CN*1];
					assign ndo[c+CN*0-:1] = (~BP&a&b)|(BP&~a&b)|(BP&a&~b)|(BP&a&b);
					assign ndo[c+CN*1-:1] = (~BP&a&b)|(~BP&a&~b)|(~BP&~a&b)|(BP&a&b);
				end
			end
		end
	end
end endgenerate

endmodule
