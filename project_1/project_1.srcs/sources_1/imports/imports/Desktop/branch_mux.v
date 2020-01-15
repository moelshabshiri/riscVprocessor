`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2019 10:05:10 PM
// Design Name: 
// Module Name: branch_mux
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

module branch_mux( input [2:0] fun3, input a,b,c,d,e,f , output reg flag);
always @(*)
begin
case (fun3)
3'b000:
flag=a;
3'b001:
flag=b;
3'b100:
flag=c;
3'b101:
flag=d;
3'b110:
flag=e;
3'b111:
flag=f;
endcase
end


endmodule
