`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2019 05:24:55 PM
// Design Name: 
// Module Name: memory
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


module memory(input sclk,input  MemRead, input MemWrite, 
             input [7:0] addr,input [31:0] data_in,input [2:0] func3,
              output reg [31:0] data_out);
              
              
               reg [7:0] mem [0:255];         
        
    
                                 always @(negedge sclk)
                                 begin
                                 if (MemWrite)
                                 begin
                                 case(func3)
                                            3'b000:begin //SB
                                            mem[addr] = data_in[7:0];
                                            end
                                            3'b001:begin //SH
                                            {mem[addr+1],mem[addr]} = data_in[15:0];
                                            end
                                            3'b010:begin //SW
                                            {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]} = data_in[31:0];
                                            end
                                             endcase
                                 end
                                 end
                                 always@(*) begin
                                  
                                         if(sclk==1)
                                         begin
                                          data_out={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
                                         end
                                 else
                                 
                                 if(MemRead)
                                     begin
                                         case(func3)
                                                3'b000:begin //LB
                                                 data_out[7:0]=mem[addr];
                                                if(data_out[7]==1)
                                                 data_out[31:8]=24'hffffff;
                                                else
                                                 data_out[31:8]=24'h000000;
                                                end
                                                3'b001:begin //LH
                                                data_out[15:0]={mem[addr+1],mem[addr]};
                                                if(data_out[15]==1)
                                                data_out[31:16]=16'hffff;
                                                else 
                                                data_out[31:16]=16'h0000;
                                                end
                                                3'b010:begin //LW
                                                data_out={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
                                                end
                                                3'b100:begin //LBU
                                                data_out[7:0]=mem[addr];
                                                data_out[31:8]=24'h000000;
                                                end
                                                3'b101:begin //LHU
                                                data_out[15:0]={mem[addr+1],mem[addr]};
                                                data_out[31:16]=16'h0000;
                                                end
                                        // assign data_out = MemRead?mem[addr]:0;
                                         endcase
                                     end
                                     else data_out=32'b00000000000000000000000000000000;  
                                end
                                 initial begin
                                 
                                 
                                 {mem[3],mem[2],mem[1],mem[0]}=32'h5dc00113;
                                 {mem[7],mem[6],mem[5],mem[4]}=32'h7ff00193;
                               {mem[11],mem[10],mem[9],mem[8]}=32'h40218233;
//                                 {mem[15],mem[14],mem[13],mem[12]}=32'h00310233;
                                 
//                                 {mem[19],mem[18],mem[17],mem[16]}=32'h021263b3;
//                                 {mem[23],mem[22],mem[21],mem[20]}=32'h02139433;
//                                 {mem[27],mem[26],mem[25],mem[24]}=32'h00219463;
                                 
                                 
                                 
                                   

                            






                                    
//                                             {mem[3],mem[2],mem[1],mem[0]}=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)  //0
//                                             {mem[7],mem[6],mem[5],mem[4]}=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)//4
//                                             {mem[11],mem[10],mem[9],mem[8]}= 32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)  //8
//                                             {mem[15],mem[14],mem[13],mem[12]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 //0 
                                          
//                                             {mem[19],mem[18],mem[17],mem[16]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   //25
//                                             {mem[23],mem[22],mem[21],mem[20]}=32'b0000000_00011_00000_010_01100_0100011; //sw x3, 12(x0)  //12
                                             
//                                             //{mem[27],mem[26],mem[25],mem[24]}=32'b0100000_00011_00100_000_01110_0110011 ; //sub x10, x4, x3  //0
                                             
//                                            {mem[27],mem[26],mem[25],mem[24]}=32'b0_000001_00011_00100_000_0000_0_1100011; //beq x4, x3, 16 //0
                                             
                                             
//                                             {mem[31],mem[30],mem[29],mem[28]}=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2 //26
                                             
//                                             {mem[35],mem[34],mem[33],mem[32]}=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2  //35
                                             
//                                             {mem[39],mem[38],mem[37],mem[36]}=32'b0100000_00011_00100_000_01010_0110011 ; //sub x10, x4, x3  //-1
//                                             {mem[43],mem[42],mem[41],mem[40]}=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)  //12
//                                             {mem[47],mem[46],mem[45],mem[44]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0   //0
//                                             {mem[51],mem[50],mem[49],mem[48]}=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1 //17
//                                             {mem[55],mem[54],mem[53],mem[52]}=32'b0000000_00110_00000_000_00100_0110011 ; //add x8, x6, x0  //25
//                                             {mem[59],mem[58],mem[57],mem[56]}=32'b0100000_00011_00100_000_01010_0110011 ; //sub x10, x4, x3  //0
                                                                                   
//                                             {mem[63],mem[62],mem[61],mem[60]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0  //0
//                                             {mem[67],mem[66],mem[65],mem[64]}=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)  //12
                                             
                                             
////                                             {mem[71],mem[70],mem[69],mem[68]}=32'b0_0000010000_0_00000000_00001_1101111 ; //JAL  x1, 16  //72, 84
                                             
                                             
                                             
                                             
                                             
                                             
                                             
////                                             {mem[71],mem[70],mem[69],mem[68]}=32'b000000001000_00110_000_00010_1100111; // JALR x2, x6, 8 //datainp=72, pc=20
////                                             {mem[75],mem[74],mem[73],mem[72]}=32'b000000001000_00000_000_00001_0010011 ; //addi x1,x0,12  //8
                                             
////                                             {mem[79],mem[78],mem[77],mem[76]}=32'b00000000000000000111_00111_0110111; //lui x5,5 //
                                             
                                             
//                                              //{mem[75],mem[74],mem[73],mem[72]}=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1 //17
                                             
////                                             {mem[75],mem[74],mem[73],mem[72]}=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1 //17
////                                             {mem[79],mem[78],mem[77],mem[76]}=32'b0000000_00110_00000_000_00100_0110011 ; //add x8, x6, x0  //25
                                             
////                                             {mem[83],mem[82],mem[81],mem[80]}=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2  //8
////                                             {mem[87],mem[86],mem[85],mem[84]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0  //0
////                                             {mem[91],mem[90],mem[89],mem[88]}=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2  //0
////                                             {mem[95],mem[94],mem[93],mem[92]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0  //0
////                                             {mem[99],mem[98],mem[97],mem[96]}=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1 //17
                                             
//                                             //fill ur instreuctions from 100
                               
         
                                             
                                             
//                                              {mem[203],mem[202],mem[201],mem[200]}=32'b00000000000000000000000000010001; //17 
//                                              {mem[207],mem[206],mem[205],mem[204]}=32'b00000000000000000000000000001001; //9
//                                              {mem[211],mem[210],mem[209],mem[208]}=32'b00000000000000000000000000011001; //25
                                  end

endmodule
