`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2019 01:27:51 PM
// Design Name: 
// Module Name: clockdiv
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


module clockdiv (clk,out_clk);
output reg out_clk;
input clk ;

always @(posedge clk)
begin

     out_clk <= ~out_clk;	
end
endmodule
