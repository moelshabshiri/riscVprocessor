`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 07:34:08 AM
// Design Name: 
// Module Name: Mul_unit
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


module Mul_unit(input [31:0]input1, input2,input [2:0] func3, output reg  [31:0]  result );

always@(*)
begin
    case(func3)
         3'b000:
               result=(input1*input2);
           3'b001:
               result=($signed(input1)*$signed(input2))>>32;
           3'b010:
               result=($signed(input1)*input2)>>32;
           3'b011:
               result=(input1*input2)>>32;
           3'b100:
               result=$signed(input1)/$signed(input2);   
           3'b101:
               result=input1/input2;
           3'b110:
               result=$signed(input1)%$signed(input2);
           3'b111:
               result=input1%input2;
    endcase
 end   
endmodule
