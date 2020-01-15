module nbit#(parameter n=32)(
                             input clk,input rst,input loadline
                             ,input [n-1:0] d,output [n-1:0]q);



                                        wire [n-1:0]m;
                                        genvar i;
                                        generate
                                            for (i=0;i<n;i=i+1)
                                                    begin
                                                         dflipflop f(clk,rst,m[i],q[i]);
                                                         mux k (loadline,q[i],d  [i],m[i]);
                                                     end
                                                     
                                        endgenerate
                                        
 endmodule 
