`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2019 04:32:39 PM
// Design Name: 
// Module Name: RD_mux
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


module RD_mux(
input [6:0]opcode,
input [31:0] AUIPC,
input [31:0] JAL_R,
input [31:0] LUIimm,
input [31:0] dataout,
output reg [31:0]rd);
always@(*) begin
case(opcode)
7'b0010111: begin
rd=AUIPC;
end
7'b1101111: begin //jal
rd=JAL_R;
end
7'b1100111: begin //jalr
rd=JAL_R;
end
7'b1100111: begin //lui
rd=LUIimm;
end
default:rd=dataout;

endcase
end
endmodule
