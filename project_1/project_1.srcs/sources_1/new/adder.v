
module adder#(parameter n=32) (input  [n-1:0]a,
input  [n-1:0]b,output reg [n-1:0]num);
wire  [n-1:0]sum;
wire  [n:0]cout;
integer k;
assign cout[0]=0;
 
generate
genvar i;
for( i=0; i<n;i=i+1)
fulladd myfa(a[i],b[i],cout[i],sum[i],cout[i+1]);
endgenerate
 
always @(*)
begin
for(k=0;k<n;k=k+1)
num[k]=sum[k];
end
 
endmodule
