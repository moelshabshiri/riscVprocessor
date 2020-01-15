 	`timescale 1ns / 1ps

//`define     ALU_SRL         4'b10_00
//`define     ALU_SRA         4'b10_10
//`define     ALU_SLL         4'b10_01

module shifter(input wire [31:0] a, input wire [4:0] shamt, input wire [1:0] type,  output reg [31:0]r);

always@(*) begin
case(type)
00: begin //srl
r=a>>shamt;

end
10: begin //sra
r=a>>>shamt;

end
01: begin //sll
r=a<<shamt;

end

endcase
end
endmodule
