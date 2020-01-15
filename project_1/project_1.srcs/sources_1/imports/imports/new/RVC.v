module compressed_ctrl(input [15:0] compressed_Inst ,output reg [31:0] Inst);

always @ (*) begin
case (compressed_Inst[1:0]) 

 2'b00: 
    case (compressed_Inst[15:13])
        3'b010: Inst = 
                    {5'b00000,compressed_Inst[5],compressed_Inst[12:10],
                    compressed_Inst[6],2'b00,2'b00,compressed_Inst[9:7],
                    3'b010,2'b00,
                    compressed_Inst[4:2],
                    5'b00_000,2'b11}; //lw
        3'b110: Inst =  
                   {5'b00000,compressed_Inst[5],compressed_Inst[12],2'b00
                   ,compressed_Inst[4:2],2'b00,compressed_Inst[9:7],3'b010
                   ,compressed_Inst[11:10]
                   ,compressed_Inst[6],2'b00,
                   5'b01_000,2'b11};//Sw
    endcase

 2'b01:
    case (compressed_Inst[15:13])
       3'b000: 
              Inst = {6'b000000,compressed_Inst[12],compressed_Inst[6:2],
                      compressed_Inst[11:7],3'b000,compressed_Inst[11:7]
                     ,5'b00_100,2'b11}; //Addi
       3'b001:
              Inst =  
                        {compressed_Inst[12],compressed_Inst[8],compressed_Inst[10:9]
                         ,compressed_Inst[6],compressed_Inst[7],
                        compressed_Inst[2],compressed_Inst[11],compressed_Inst[5:3],
                        compressed_Inst[12],8'b00000000,5'b00001,5'b11_011,2'b11};//Jal
       3'b011: 
              Inst = 
                     {14'b00000000000000,compressed_Inst[12],compressed_Inst[6:2]
                     ,compressed_Inst[11:7],5'b01_101,2'b11};//Lui
      
       3'b100:
              case (compressed_Inst[11:10])
                  2'b00: 
                        Inst =
                               {7'b0000000,compressed_Inst[6:2],2'b00,compressed_Inst[9:7],3'b101,2'b00,
                               compressed_Inst[9:7],5'b00_100,2'b11};//Srli
                  2'b01:
                        Inst = 
                               {7'b0100000,compressed_Inst[6:2],2'b00,compressed_Inst[9:7],3'b101,2'b00,
                               compressed_Inst[9:7],5'b00_100,2'b11};//Srai
                  2'b10:
                        Inst = 
                                {7'b0000000,compressed_Inst[12],compressed_Inst[6:2],2'b00,
                                 compressed_Inst[9:7], 3'b111,2'b00,compressed_Inst[9:7],
                                 5'b00_100,2'b11};//Andi
  
                  2'b11:
                        case (compressed_Inst[6:5])
                            2'b00:
                                  Inst = {7'b0100000,2'b00,compressed_Inst[4:2],2'b00
                                         ,compressed_Inst[9:7],3'b000,
                                          2'b00,compressed_Inst[9:7],5'b01_100,2'b11}; //Sub
                            2'b01:
                                  Inst = {7'b0000000,2'b00,compressed_Inst[4:2],2'b00,compressed_Inst[9:7],
                                          3'b100,2'b00,compressed_Inst[9:7],5'b01_100,2'b11};//Xor
                            2'b10:
                                  Inst = {7'b0000000,2'b00,compressed_Inst[4:2],2'b00
                                          ,compressed_Inst[9:7],3'b110,
                                          2'b00,compressed_Inst[9:7],5'b01_100,2'b11};//Or
                            2'b11: 
                                  Inst = 
                                          {7'b0000000,2'b00,compressed_Inst[4:2],2'b00,
                                          compressed_Inst[9:7],3'b111,2'b00,
                                           compressed_Inst[9:7],5'b01_100,2'b11};//And

                                  
                        endcase
                        
              endcase
              
    endcase
    
2'b10: 
      case (compressed_Inst[15:13])
        3'b000: 
                Inst =
                        {7'b0000000, compressed_Inst[12], compressed_Inst[6:2],
                        compressed_Inst[11:7],3'b001, compressed_Inst[11:7],
                        5'b00_100,2'b11};//Slli
      
        3'b100: 
                case (compressed_Inst[6:2])
                    5'b00000: 
                      case (compressed_Inst[11:7])
          
                          5'b00000:
                                Inst= 
                                      {{11{0}},1'b1,{13{0}},5'b11_100,2'b11};  //Ebreak
          
                          default://rs1!=zero
                                Inst = 
                                      {{12{0}},compressed_Inst[11:7],3'b000,
                                       5'b00001,5'b11_001, 2'b11}; //Jalr
                      endcase
       
                    default: //rs2!=0
              
                    Inst =
                          {7'b0000000,2'b00,compressed_Inst[4:2],2'b00,
                          compressed_Inst[9:7],3'b000,2'b00,compressed_Inst[9:7]
                          ,5'b01_100,2'b11}; //Add  
                    
                endcase


      endcase
      
endcase

end

endmodule
