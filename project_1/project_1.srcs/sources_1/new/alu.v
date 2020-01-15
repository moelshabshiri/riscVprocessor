module fulladd(a, b, cin, sum, cout);
input a;
input b;
input cin;
output sum;
output cout;
assign sum=(a^b^cin);
assign cout=((a&b)|(b&cin)|(a&cin));
endmodule

module adder#(parameter n=32) (input  [n-1:0]a,input  [n-1:0]b,output reg [n:0]num);
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
num[n]=cout[n];
end

endmodule



module alu #(parameter n=4)(input [n-1:0]a,input  [n-1:0]b, input [3:0]select,input[4:0]rd,output reg [n:0]c, output reg z);
reg [n-1:0]b2;
wire [n:0]add;
adder #(n) addmod(a,b2,add);

always @(*)begin
if(rd==0)
c=0;
else
case(select)
4'b0010 :begin //add
b2=b;
c=add;
end
4'b0110:begin //sub
b2=~b+1;
c=add;
end
4'b0000:begin
c=a&b;
end
4'b0001:begin
c=a|b;
end
default :
begin
c=0;
end
endcase

if(c[n-1:0]==0)
z=1;
else
z=0;

end
endmodule