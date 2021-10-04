module top_module ( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    wire[2:0] cout_i;
    
    genvar i;
    	fa stage0 ( .a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout_i[0]) );
    generate
        for (i = 1; i<=2; i = i + 1) begin : generating
            fa stages ( .a(a[i]), .b(b[i]), .cin(cout_i[i-1]), .sum(sum[i]), .cout(cout_i[i]) );
        end // generating
    endgenerate
    
    assign cout = cout_i;
endmodule

module fa ( input a, input b, input cin, output sum, output cout );
    
    assign cout = ((a & b) | (cin & a) | (cin & b));
    assign sum = a ^ b ^ cin;

endmodule
