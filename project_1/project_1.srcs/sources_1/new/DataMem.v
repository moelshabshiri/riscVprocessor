module DataMem
 (input clk, input MemRead, input MemWrite,
 input [5:0] addr, input [31:0] data_in, output reg  [31:0] data_out,input [2:0] func3);
 
//                                    module DataMem(input clk, input MemRead, input MemWrite, input [5:0] addr,
//                                      input [31:0] data_in, output [31:0] data_out);
//                                      reg [31:0] mem [0:63];
                                     
//                                      always @(posedge clk)
//                                      begin
//                                      if (MemWrite)
//                                      mem[addr] = data_in;
//                                      end
                                     
//                                      assign data_out = MemRead?mem[addr]:0;
//                                      initial begin
//                                      mem[0]=32'd17;
//                                      mem[1]=32'd9;
//                                      mem[2]=32'd25;
//                                      end
//                                     endmodule
 
 
 reg [7:0] mem [0:255];
 always @(posedge clk)
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
 //mem[addr] <= data_in;
 end
 always@(*) begin
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
 mem[0]=8'b00010001;
 mem[1]=8'b00000000;
 mem[2]=8'b00000000;
 mem[3]=8'b00000000;
 
 mem[4]=8'b00001001;
 mem[5]=8'b00000000;
 mem[6]=8'b00000000;
 mem[7]=8'b00000000;
 
  
 mem[8]=8'b00011001;
 mem[9]=8'b00000000;
 mem[10]=8'b00000000;
 mem[11]=8'b00000000;
 
//  {mem[3],mem[2],mem[1],mem[0]}=32'b00000000000000000000000000010001;
//  {mem[7],mem[6],mem[5],mem[4]}=32'b00000000000000000000000000001001;
//  {mem[11],mem[10],mem[9],mem[8]}=32'b00000000000000000000000000011001;
  end
 
endmodule