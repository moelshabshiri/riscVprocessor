`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2019 12:07:41 AM
// Design Name: 
// Module Name: mux3to1
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

module mux3to1(input[31:0]rs,input[31:0]rd1,input[31:0]rd2,input[1:0]selection, output reg [31:0]rsOut);

always@(*)
begin
case(selection)
    2'b00:  rsOut=rs;
    2'b10:  rsOut=rd1;
    2'b01:  rsOut=rd2;
    default:rsOut=rs;
endcase
end
endmodule