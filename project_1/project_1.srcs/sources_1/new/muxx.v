`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 07:30:10 PM
// Design Name: 
// Module Name: muxx
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



module MUX #(parameter n=5) (input [n-1:0]A,input [n-1:0]B, input s,output [n-1:0]C );
  genvar i;
  generate 
    for (i = 0; i < n; i = i + 1) begin
          assign C[i]=(s==0)? A[i]:B[i];
    end
  endgenerate

endmodule
