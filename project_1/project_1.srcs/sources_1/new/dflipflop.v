`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2019 03:52:33 PM
// Design Name: 
// Module Name: dflipflop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dflipflop
(input clk, input rst, input D, output reg Q);
 always @ (posedge clk or posedge rst)
 if (rst) begin
 Q <= 1'b0;
 end else begin
 Q <= D;
 end
endmodule

