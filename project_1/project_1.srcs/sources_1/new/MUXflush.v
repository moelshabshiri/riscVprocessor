`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 05:02:54 PM
// Design Name: 
// Module Name: MUXflush
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


module MUXflush( input andout, input [6:0]opcode,
input [31:0] data_out, input memtoreg ,Regwrite,branch,memread,memwrite, alu_src, input[1:0]ALUop, input ex_memtoreg,ex_Regwrite,ex_branch,ex_memread,ex_memwrite, 
output reg [31:0] data_outF, output reg memtoregF ,RegwriteF,branchF,memreadF,memwriteF, alu_srcF, output reg [1:0]ALUopF, output reg ex_memtoregF,ex_RegwriteF,ex_branchF,ex_memreadF,ex_memwriteF
    );
    always@(*) begin
    if(andout||(opcode==7'b1101111)||(opcode==7'b1100111))
     begin 
    data_outF=32'b0000000_00000_00000_000_00000_0110011;
    memtoregF=1'b0;
    RegwriteF=1'b0;
    branchF=1'b0;
    memreadF=1'b0;
    memwriteF=1'b0;
    alu_srcF=1'b0;
    ALUopF=2'b00;
    ex_memtoregF=1'b0;
    ex_RegwriteF=1'b0;
    ex_branchF=1'b0;
    ex_memreadF=1'b0;
    ex_memwriteF=1'b0;
    end
    else
      begin 
     data_outF=data_out;
     memtoregF=memtoreg;
     RegwriteF=Regwrite;
     branchF=branch;
     memreadF=memread;
     memwriteF=memwrite;
     alu_srcF=alu_src;
     ALUopF=ALUop;
     ex_memtoregF=ex_memtoreg;
         ex_RegwriteF=ex_Regwrite;
         ex_branchF=ex_branch;
         ex_memreadF=ex_memread;
         ex_memwriteF=ex_memwrite;
    end
    

    end
endmodule



