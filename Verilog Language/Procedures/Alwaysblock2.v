/*
 *  Here's another demonstration of the always block. Both blocks contain a register at 
 *  the output but additional the <= will used a clocked flip flop. This is indicated with
 *  the ( posedge clk ). I co not know what is the difference of the outcome when you change
 *  the <= and the = of the two outputs. They will both succeed.
 *
 // synthesis verilog_input_version verilog_2001
module top_module (
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );
    
    assign out_assign = a ^ b;
    
    always @(*) begin
    	out_always_comb = a ^ b;
    end
    
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end
    

endmodule
