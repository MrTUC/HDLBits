/*
 *  Here the always @ is introduced. It demonstrates, how the logic is assigned to the outputs.
 *  The combinational part inside an always block has a register at the output. You need to
 *  be aware of that.
 */

// synthesis verilog_input_version verilog_2001
module top_module (
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);
    
    assign out_assign = a & b;
  
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
