module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//

    wire carry;
    add16 lowerword ( .a(a[15:0]), .b(b[15:0]), .cin(1'b0), .cout(carry), .sum(sum[15:0]) );
    add16 upperword ( .a(a[31 -:16]), .b(b[31 -:16]), .cin(carry), .sum(sum[31 -:16]) );
    
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

    wire carry;
    wire[1:0] sum_i;
	  assign sum_i = a + b + cin;
    assign cout = sum_i[1];
    assign sum = sum_i[0];
    

endmodule
