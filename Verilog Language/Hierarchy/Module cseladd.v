module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire[15:0] sum_wo_carry, sum_w_carry, mux_out;
    wire cout_i;
    
    add16 lowerword ( .cin(1'b0), .a(a[15:0]), .b(b[15:0]), .sum(sum[15:0]), .cout(cout_i) );
    add16 upperword_wc (.cin(1'b1), .a(a[31:16]), .b(b[31:16]), .sum(sum_w_carry) );
    add16 upperword_woc (.cin(1'b0), .a(a[31:16]), .b(b[31:16]), .sum(sum_wo_carry) );
    
    always @(*) begin
        case (cout_i)
            1'b0	:	sum[31:16] = sum_wo_carry;
            1'b1	:	sum[31:16] = sum_w_carry;
        endcase
    end    
    
endmodule
