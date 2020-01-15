
module DataPath(input clk,input clk2, input rst, input [1:0]ledSel,input [3:0]ssdSel, output reg[15:0] instuctout,output  [3:0] Anode,
output  [6:0] LED_out);
        wire [31:0] PC;
        wire [31:0] PC2;
        wire [31:0] data_out;
        wire branch;
        wire memread;
        wire memtoreg;
        wire [1:0]ALUop;
        wire memwrite;
        wire alu_src;
        wire Regwrite;
        wire [31:0]datainp;
        wire [31:0]datainp2;
        wire [31:0]readData1;
        wire [31:0]readData2;
        wire [31:0] gen_out;
        wire [31:0]data2;
        wire[3:0]ALUselection;
        wire zero;
        wire [31:0]ALUres;
        wire [31:0] readdatamem;
        wire [31:0]shifted;
        wire [31:0]add2out;
        wire andout;
        reg [12:0] instuctout2;
        wire [31:0] addout;
        wire [31:0] loadline;
        wire [31:0] id_pc;
        wire [31:0] id_inst;
        wire stall;
        wire [31:0] ex_pc;
        wire [31:0] ex_readdata1;
        wire [31:0]ex_readdata2;
        wire [31:0] ex_genout;
        wire ex_instruction1;
        wire [2:0]ex_instruction2;//funct3
        wire [4:0]ex_instruction11to7;
        wire [4:0]mem_instruction11_7;
        wire ex_branch;
        wire ex_memwrite;
        wire ex_alu_src;
        wire ex_Regwrite;
        wire ex_memtoreg;
        wire ex_memread;
        wire[1:0]ex_ALUop;
        wire mem_memtoreg,mem_branch,mem_memread,mem_memwrite,mem_regwrite,mem_zero;
        wire [31:0] mem_ALUres,mem_readdata2,mem_addout;
        wire [4:0] mem_instruction11to7;
        wire wb_memtoreg,wb_regwrite;
        wire [31:0]wb_readdatamem;
        wire [31:0] wb_ALUres;
        wire [4:0]wb_instruction11to7;
        wire cf,zf,vf,sf,flag,mem_flag;
        wire [4:0]ex_rs1,ex_rs2;
        wire [1:0] FA,FB;
        wire [31:0] aluinput1,aluinput2;
        
        wire [6:0]ex_opcode;
        wire [6:0]mem_opcode;
        wire [31:0]mem_genout;
        wire [2:0]mem_instruction2;
        
        
        wire [6:0]wb_opcode;  
        wire [31:0]wb_addout;
         wire [31:0]wb_genout;
        wire [7:0]meminp;
        
        ///////////////////
        
        wire [31:0] data_outF; 
        wire memtoregF; 
        wire RegwriteF; 
        wire branchF; 
        wire memreadF; 
        wire memwriteF; 
        wire alu_srcF; 
        wire [1:0]ALUopF; 
        wire ex_memtoregF;
        wire ex_RegwriteF;
        wire ex_branchF;
        wire ex_memreadF;
        wire ex_memwriteF;
        wire mulsignal,ex_mulsignal;
        wire [31:0] ex_memresult;
        ////////////////////
        wire [31:0] mul_result; 
        wire [31:0]  add2outEX;
        wire[31:0] mem_pc;
        wire[31:0] wb_pc;
        wire [31:0] extended_instruction;
        wire [31:0] instruction;
        wire opcode5;

nbit#(32) Pcc (
                .clk(clk), .rst(rst), 
                .loadline(1),.d(PC2)
                ,.q(PC)
                );
                 
compressed_ctrl CC(
                  (data_outF[15:0]), 
                  (extended_instruction)
                  );
                  
CI_mux cimux       (
                    data_outF[1:0],data_outF,
                    extended_instruction,instruction
                    );

nbit#(64) IFID (~clk, rst, 1,{instruction,PC[31:0]},{id_inst, id_pc}); ///

ctrlunit cu(id_inst[20],id_inst[25],id_inst[6:2], branch,  memread, memtoreg,ALUop, memwrite,alu_src, Regwrite,mulsignal);
ImmGen ig (id_inst[31:0],gen_out);
regs#(32) regi (~clk,rst, id_inst[19:15],id_inst[24:20],datainp, wb_instruction11to7, wb_regwrite, readData1,readData2);

 MUXflush mxflush(  andout, mem_opcode,
 data_out,  memtoreg ,Regwrite,branch,memread,memwrite, alu_src, ALUop,  ex_memtoreg,ex_Regwrite,ex_branch,ex_memread,ex_memwrite, 
 data_outF,  memtoregF ,RegwriteF,branchF,memreadF,memwriteF, alu_srcF, ALUopF,  ex_memtoregF,ex_RegwriteF,ex_branchF,ex_memreadF,ex_memwriteF
   );
   
   
nbit#(164) IDEX (clk, rst, 1,{id_inst[5],mulsignal,id_inst[6:0], memtoregF ,RegwriteF,branchF,memreadF,memwriteF, alu_srcF, ALUopF, 
  id_pc, readData1,readData2,gen_out,id_inst[30],id_inst[14:12],id_inst[11:7], id_inst[19:15],id_inst [24:20]}////////////////////
  ,{opcode5,ex_mulsignal,ex_opcode,  ex_memtoreg,ex_Regwrite,ex_branch,ex_memread, ex_memwrite,  ex_alu_src, ex_ALUop,ex_pc, ex_readdata1,ex_readdata2,
    ex_genout,ex_instruction1,ex_instruction2,ex_instruction11to7,ex_rs1,ex_rs2});

MUX #(32) mux1 (aluinput2,ex_genout,ex_alu_src,data2);
ALU_ctrlunit aluc (opcode5,ex_ALUop,ex_instruction2, ex_instruction1,ALUselection);



Mul_unit MU(
             .
             input1(aluinput1),.input2(aluinput2)
             
            ,.func3(ex_instruction2),.result(mul_result)
            
            );
MUX #(32)alu_mul( ALUres, mul_result ,ex_mulsignal,ex_memresult);

ForwardUnit FU (ex_rs1,ex_rs2,mem_instruction11to7,mem_regwrite,wb_instruction11to7,wb_regwrite,FA,FB);
mux3to1 ALUmux1 (ex_readdata1,datainp,mem_ALUres,FA, aluinput1);
mux3to1 ALUmux23 (ex_readdata2,datainp,mem_ALUres,FB, aluinput2);

JALR_PC2mux mux3(mem_ALUres, add2out, mem_addout[31:0], andout,mem_opcode, PC2);

//MUX #(32) mux3 (add2out[31:0],mem_addout[31:0], andout,PC2);
RD_mux rdmux(wb_opcode, wb_addout[31:0], add2outEX,wb_genout,datainp2,datainp);
//auipc,   jal/jalr,    lui,          datinp
prv32_ALU al(aluinput1, data2, ex_rs2, ALUres, cf, zf, vf, sf, ALUselection,ex_instruction11to7);
shift#(32) shift (ex_genout,shifted);
adder #(32)adder2(shifted,ex_pc,addout);

branch_mux d(ex_instruction2,zf,~zf,(sf!=vf),(sf==vf),~cf,cf,flag);
nbit #(181)EXEM(~clk,rst,1,{ ex_pc, ex_opcode, ex_genout, ex_instruction2, 
ex_memtoregF,ex_RegwriteF,ex_branchF,ex_memreadF,ex_memwriteF, addout,flag, ex_memresult,aluinput2,ex_instruction11to7},
{mem_pc, mem_opcode,mem_genout,mem_instruction2, mem_memtoreg,mem_regwrite,mem_branch,mem_memread,mem_memwrite,
  mem_addout,mem_flag,mem_ALUres,mem_readdata2,mem_instruction11to7});

//DataMem dm ( clk, mem_memread, mem_memwrite, mem_ALUres[5:0] ,mem_readdata2, readdatamem,mem_instruction2); //

andgate andg (mem_branch, mem_flag, andout);

nbit #(174) MEMWB(clk,rst, 1,{mem_pc,mem_opcode,  mem_addout, mem_genout,  mem_regwrite,mem_memtoreg,data_out,mem_ALUres,mem_instruction11to7},
{wb_pc,wb_opcode,  wb_addout, wb_genout,wb_regwrite,wb_memtoreg,wb_readdatamem,wb_ALUres,wb_instruction11to7 });

MUX #(32) mux2 (wb_ALUres,wb_readdatamem, wb_memtoreg,datainp2);


adder#(32) add2 (PC, 4,add2out);
adder#(32) addJAL_JALR (wb_pc, 4,add2outEX);

MUX #(8) memoryMux ((mem_ALUres[7:0]+200), PC[7:0], clk,meminp);
memory mem(clk, mem_memread, mem_memwrite, meminp,mem_readdata2,mem_instruction2, data_out);



Four_Digit_Seven_Segment_Driver seg(clk2,instuctout2,Anode,LED_out);
always@(*)
begin
case(ledSel)
2'b00:
instuctout=data_out[15:0];
2'b01:
instuctout=data_out[31:16];
2'b11: begin
instuctout[1:0]=ALUop;
instuctout[5:2]=ALUselection;
instuctout[7]=zero;
instuctout[8]=andout;
instuctout[9]=memread;
instuctout[10]=memwrite;
instuctout[11]=memtoreg;
instuctout[12]=Regwrite;
instuctout[6]=alu_src;
instuctout[13]=0;
instuctout[14]=0;
instuctout[15]=0;
end
endcase
case(ssdSel)
4'b0000:
instuctout2=PC[12:0];
4'b0001:
instuctout2=add2out;
4'b0010:
instuctout2=aluinput1[12:0];
4'b0011:
instuctout2=PC2[12:0];
4'b0100:
instuctout2=readData1[12:0];//?
4'b0101:
instuctout2=readData2[12:0];//?
4'b0110:
instuctout2=datainp;//?
4'b0111:
instuctout2=gen_out[12:0];//?
4'b1000:
instuctout2=datainp;//?
4'b1001:
instuctout2=data2[12:0];//?
4'b1010:
instuctout2=ALUres;//?
4'b1011:
instuctout2=meminp;//?
endcase
end



//MUX #(32) mux3 (add2out[31:0],mem_addout[31:0], andout,PC2);
endmodule
