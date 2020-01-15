

module ImmGen (input [31:0] inst,output reg [31:0] gen_out);
always@(*)
begin
case(inst[6:2])
5'b11000://sb
begin
gen_out[3:0]=inst[11:8];
gen_out[9:4]=inst[30:25];
gen_out[10]=inst[7];
gen_out[11]=inst[31];
if(gen_out[11]==1)
gen_out[31:12]=20'hfffff;
end
5'b00000://load
begin
gen_out=inst[31:20];
if(gen_out[11]==1)
gen_out[31:12]=20'hfffff;
end

5'b00100://i arthmatic
begin
gen_out=inst[31:20];
if(gen_out[11]==1)
gen_out[31:12]=20'hfffff;
end


5'b01000://s
begin
gen_out[4:0]=inst[11:7];
gen_out[11:5]=inst[31:25];
if(gen_out[11]==1)
gen_out[31:12]=20'hfffff;
end

5'b01101://LUI
begin
gen_out[31:12]=inst[31:12];
gen_out[11:0]=12'h000;
end

5'b00101://AUIPC
begin
gen_out[30:11]=inst[31:12];
gen_out[10:0]=11'b0000000000;
gen_out[31]=1'b0;
end

5'b11011://JAL
begin
gen_out[9:0]=inst[30:21];
gen_out[10]=inst[20];
gen_out[18:11]=inst[19:12];
gen_out[19]=inst[31];
if(gen_out[19]==1)
gen_out[31:20]=12'hfff;
else
gen_out[31:20]=12'h000;
end

5'b11001://JALR
begin
gen_out=inst[31:20];
if(gen_out[11]==1)
gen_out[31:12]=20'hfffff;
end

default:gen_out=0;
endcase
end
endmodule
