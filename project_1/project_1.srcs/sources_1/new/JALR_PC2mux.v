`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2019 10:31:47 AM
// Design Name: 
// Module Name: JALR_PC2mux
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


module JALR_PC2mux(input [31:0] ALUres,input [31:0]PC4, input [31:0]shiftedPC, input andgateoutput,input [6:0]opcode,output reg [31:0]PC2);
always@(*) begin
if(opcode==7'b1100111)
PC2=ALUres;
else 
if(opcode==7'b1101111)
PC2=shiftedPC;
else if(andgateoutput)
PC2=shiftedPC;
else
PC2=PC4;
end
endmodule
