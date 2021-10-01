module top_module (
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire[31:0] exored_i;
    wire carry_i;
    
    add16 lowerword ( .cin(sub), .a(a[15:0]), .b(exored_i[15:0]), .cout(carry_i), .sum(sum[15:0]) );
    add16 upperword ( .cin(carry_i), .a(a[31:16]), .b(exored_i[31:16]), .sum(sum[31:16]) );
    
    genvar i;
    generate
        for ( i = 0; i <= 31; i = i + 1 ) begin : xoring
            assign exored_i[i] = sub ^ b[i];
        end
    endgenerate
                                                                   
endmodule
