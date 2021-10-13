/*
 *  This solution does not match the expected behaviour. But since there is a 
 *  one hot coding there shouldn't be an "a" as a state.
 */
module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = (~in)&(state[A] | state[C]);
    assign next_state[B] = in&(~state[C]);
    assign next_state[C] = (~in)&(state[B] | state[D]);
    assign next_state[D] = in&state[C];

    // Output logic: 
    assign out = ( state[D] )	?	1'b1	:	1'b0;

endmodule
