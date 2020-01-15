module multiplexer #(parameter n=32) (input [n-1:0]A,input [n-1:0]B, input s,output [n-1:0]C);
  genvar i;
  generate
	for (i = 0; i < n; i = i + 1) begin
      	assign C[i]=(s==0)? A[i]:B[i];
	end
  endgenerate
endmodule
