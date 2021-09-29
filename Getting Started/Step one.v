/*
 * module - endmodule 
 * is the frame of the module in a verilog files. module is followed by the name of the module.
 * 
 * top_module
 * is the name of the module. The name should be telling, what the module does. continuous_one would be more meaningful.
 * 
 * ();
 * The brackets contain the ports of your module. They are followed by a semi.
 *
 * output
 * is the direction of the port.
 * 
 * one
 * is the name of the port.
 * 
 * assign
 * is the keyword that assigns some value or logic expression to the chosen signal. Here it is the output port named one followed by an equal sign.
 *
 * 1'b1
 * is the assignment to the port. First the number of bits are written down. The tick is followed by the numbering system you're in and the 
 * If you pronounce it: one bit binary 1. So 2'b01 would be two bits binary zero one. This will not fit signal although it is also one.
 * 1'h1 would also work. It is one bit hexadecimal 1.
 */

module top_module ( output one );

    assign one = 1'b1;

endmodule
