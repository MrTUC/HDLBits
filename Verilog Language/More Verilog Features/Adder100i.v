module top_module ( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    genvar i;
    fulladder zero ( .a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout[0]) );
    
    generate
        for ( i = 1; i <= 99; i = i + 1 ) begin : instantiation
            fulladder stage ( .a(a[i]), .b(b[i]), .cin(cout[i-1]), .sum(sum[i]), .cout(cout[i]) );
        end
    endgenerate

endmodule

module fulladder ( input a, input b, input cin, output sum, output cout );
    
    wire carry;
    wire [1:0] sum_i;
    assign sum_i = a + b + cin;
    assign cout = sum_i[1];
    assign sum = sum_i[0];
    
endmodule
