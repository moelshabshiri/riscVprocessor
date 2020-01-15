module regs#(parameter n=32)(input clk,input rst,input [4:0]r1,
input [4:0]r2, input [n-1:0] datainp, input [4:0]w,input regwrite, output [31:0]data1,data2);
wire [31:0]loadline;
assign loadline = (regwrite==0) ? 0:1 <<w; 
wire [31:0]q[31:0];

nbit  #(32)registers(clk,rst, 0,0,q[0]);
genvar i;
generate
for (i=1;i<32;i=i+1)
begin
nbit  #(32)registers(clk,rst, loadline[i],datainp,q[i]);
end
endgenerate
assign data1=(r1==0)? 0:q[r1];
assign data2=(r2==0)? 0:q[r2];
//assign data2=q[r2];
endmodule
