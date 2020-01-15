
module mux(input select_line, input a, input b, output y);
assign y=select_line?b:a;
endmodule
