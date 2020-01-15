    
    
    module CI_mux(       
                  input wire [1:0] selectionlines,
                   input[31:0] A , B, 
                   output [31:0]C );


                    assign C= (selectionlines==2'b11)?A:B;
    















endmodule