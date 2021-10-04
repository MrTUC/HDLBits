module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    wire[2:0] carry;
    
    FA stage0 ( .x(x[0]), .y(y[0]), .cin(1'b0), .sum(sum[0]), .cout(carry[0]) );
    FA stage1 ( .x(x[1]), .y(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]) );
    FA stage2 ( .x(x[2]), .y(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]) );
    FA stage3 ( .x(x[3]), .y(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(sum[4]) );
    
    
endmodule

module FA ( input x, input y, input cin, output sum, output cout );
    assign sum = x ^ y ^ cin;
    assign cout = (( x & y ) | ( x & cin ) | ( y & cin ));
endmodule
