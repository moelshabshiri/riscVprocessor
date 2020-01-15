`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2019 12:07:23 AM
// Design Name: 
// Module Name: ForwardUnit
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


module ForwardUnit(input[4:0]rs1,input[4:0]rs2,input[4:0]ExMemRd,input RegWrite1,
input[4:0]MemWbRd,input RegWrite2,output reg [1:0]  c1,output reg [1:0]  c2);

always @(*)
begin
       if((ExMemRd !=0 &&  rs1==ExMemRd)&&(RegWrite1==1))
            c1=2'b01; //rd2
           else if(((MemWbRd!=0 &&  rs1==MemWbRd))&&(RegWrite2==1))
            c1=2'b10; //rd1
         else c1=2'b00;     //rs1


             if((ExMemRd !=0 && rs2==ExMemRd)&&(RegWrite1==1))
                    c2=2'b01; //rd2
        else if((MemWbRd !=0 && rs2==MemWbRd)&&(RegWrite2==1))
            c2=2'b10; //rd1
        else c2=2'b00; //rs2
end
endmodule




//module ForwardUnit(input[4:0]ex_rs1,input[4:0]ex_rs2,input [4:0] mem_rd,input mem_regwrite,input [4:0] wb_rd,input wb_regwrite,output [1:0]A,
//output [1:0]B);



// wire x,y,x2,y2, a,b,c,d,e,f,g,h;
// assign a=(mem_regwrite==1);
// assign b=(mem_rd!=0);
// assign c=(mem_rd==ex_rs1);
// assign d=(mem_rd==ex_rs2);
// assign x=a&b&c;
// assign A[1]= x;
// assign y=a&b&c;
// assign B[1]= y;
// assign e=(wb_regwrite==1);
// assign f=(wb_rd!=0);
// assign g=(wb_regwrite==ex_rs1);
// assign h=(wb_regwrite==ex_rs2);
// assign x2=(e&f&g);
// assign y2=(e&f&h);
// assign A[0]=~(x) & x2;
// assign B[0]=~y &y2; 
//endmodule






