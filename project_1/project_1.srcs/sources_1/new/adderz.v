`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2019 04:08:31 PM
// Design Name: 
// Module Name: adderz
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


module adderz#(parameter n=32) (input  [n-1:0]a,
input  [n-1:0]b,output  [n-1:0]num);

assign num=a+b;

endmodule
