module shift#(parameter n=4)(input [n-1:0]A,output [n-1:0]C);
assign C[0]=1'b0;
genvar i;
  generate
	for (i = n-1; i > 0; i = i - 1) begin
      	assign C[i]=A[i-1];
	end
  endgenerate
endmodule
