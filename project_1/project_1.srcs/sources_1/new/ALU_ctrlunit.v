
module ALU_ctrlunit(input opcode5,input [1:0]op,[2:0]inst, input inst1,output reg[3:0]selection);
always @(*)
begin
case (op)
	2'b00:
	selection=4'b00_00; //add
	2'b01:
	selection=4'b00_01; //sub
	
	2'b10:
    	begin
    	case (inst)
           3'b000:
                case(opcode5)
                    1'b0:
                 	       selection=4'b00_00; //add
                    1'b1:
                           case(inst1)
                               1'b1:
                                    selection=4'b00_01;
                               1'b0:
                                    selection=4'b00_00;
                           endcase
                 endcase
                                
                                

        	3'b111:
        	       selection=4'b01_01; //AND
        	3'b110:
        	       selection=4'b01_00; //OR
        	3'b011:
                    selection=4'b11_11; //compare sltiu
            3'b010:
                    selection=4'b11_01; //compare slti
        	3'b100:
                    selection=4'b01_11; //xor 
            3'b001:
                    selection=4'b10_01; //SLL 
            3'b101: begin
            case(inst1)
            0:
            selection=4'b10_00; //SRL
            1:
            selection=4'b10_10; //SRA
            endcase
            end
        	endcase
        	end
       
endcase
end
endmodule




