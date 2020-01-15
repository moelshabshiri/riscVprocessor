module ctrlunit(input inst20 ,input inst25,input [4:0]inst, 
                output reg branch, output reg memread,output reg memtoreg,
                output reg  [1:0]ALUop,output reg memwrite, output 
                reg alu_src,output reg Regwrite,output reg mul);
                
                
             
                
always @(*)
begin
case (inst[4:0])
5'b00100: //ADDI/ SLTI/ ANDI/  ORI/ XORI
begin
    branch=1'b0;
    memread=1'b0;
    memtoreg=1'b0;
    ALUop=2'b10;  //////////
    memwrite=1'b0;
    alu_src=1'b1;
    Regwrite=1'b1;
//JALRcontrol=1'b0;
end


5'b01100: //arthR
   begin
    case(inst25)
        1'b0:
            begin
                branch=1'b0;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b10;
                memwrite=1'b0;
                alu_src=1'b0;
                Regwrite=1'b1;
                mul=1'b0;
              end
        1'b1:
            begin
                branch=1'b0;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b10;
                memwrite=1'b0;
                alu_src=1'b0;
                Regwrite=1'b1;
                mul=1'b1;
//JALRcontrol=1'b0;
            end
        endcase
  end
5'b00000: //load
        begin
                branch=1'b0;
                memread=1'b1;
                memtoreg=1'b1;
                ALUop=2'b00;
                memwrite=1'b0;
                alu_src=1'b1;
                Regwrite=1'b1;
                mul=1'b0;
//JALRcontrol=1'b0;
       end
5'b01000: //store
        begin
                branch=1'b0;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b00;
                memwrite=1'b1;
                alu_src=1'b1;
                Regwrite=1'b0;
                mul=1'b0;
//JALRcontrol=1'b0;
        end
5'b11000: //branch
        begin
                branch=1'b1;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b01;
                memwrite=1'b0;
                alu_src=1'b0;
                Regwrite=1'b0;
                mul=1'b0;
//JALRcontrol=1'b0;
        end

5'b01101://lui
        begin
                branch=1'b0;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b00;
                memwrite=1'b0;
                alu_src=1'b1;
                Regwrite=1'b1;
                mul=1'b0;
//JALRcontrol=1'b0;
        end

5'b00101://AUIPC
        begin
                branch=1'b0;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b00;
                memwrite=1'b0;
                alu_src=1'b1;
                Regwrite=1'b1;
                mul=1'b0;
//JALRcontrol=1'b0;
        end

5'b11011://JAL
        begin
                branch=1'b1;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b01;
                memwrite=1'b0;
                alu_src=1'b1;
                Regwrite=1'b1;
                mul=1'b0;
//JALRcontrol=1'b0;
        end

5'b11001://JALR
        begin
                branch=1'b1;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b00;
                memwrite=1'b0;
                alu_src=1'b1;
                Regwrite=1'b1;
                mul=1'b0;
        //JALRcontrol=1'b1;
        end
5'b11_100: //Ebreak

    case(inst20) //instruction[20]
        1'b1:
            $stop;
        default:  //others nop
          begin
                branch=1'b0;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b00;
                memwrite=1'b0;
                alu_src=1'b0;
                Regwrite=1'b0;
                mul=1'b0;
            end
      endcase

default:
        begin
                branch=1'b0;
                memread=1'b0;
                memtoreg=1'b0;
                ALUop=2'b00;
                memwrite=1'b0;
                alu_src=1'b0;
                Regwrite=1'b0;
                mul=1'b0;
        end 
endcase
end
endmodule

