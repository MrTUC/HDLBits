module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2    
    parameter byte1=0, byte2=1, byte3=2, dones=3;
    
    reg [1:0] current_state, next_state;

    // State transition logic (combinational)
    always @ (*) begin
        case ( current_state )
            byte1:	next_state = ( 1'b1 == in[3] ) ? byte2 : byte1;
            byte2:	next_state = byte3;
            byte3:	next_state = dones;
            dones:	next_state = ( 1'b1 == in[3] ) ? byte2 : byte1;
        endcase
    end

    // State flip-flops (sequential)
    always @ ( posedge clk ) begin
        if ( reset ) 
            current_state <= byte1;
        else
            current_state <=  next_state;
    end
 
    // Output logic
    assign done = ( dones == current_state ) ? 1'b1 : 1'b0;

    // New: Datapath to store incoming bytes.
    reg [23:0]	bytes;
    
    always @ ( posedge clk ) begin
        bytes <= {bytes[15:0], in};
    end
    
    assign out_bytes = bytes;

endmodule
