module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    
    wire[99:0] carries;
    
    genvar i;
    
    FA stage0 ( .a(a[0]), .b(b[0]), .cin(cin), .cout(carries[0]), .sum(sum[0]) );
    
    generate
        for ( i = 1; i <= 99; i = i + 1 ) begin : generating
            FA stages ( .a(a[i]), .b(b[i]), .cin(carries[i-1]), .cout(carries[i]), .sum(sum[i]) );
        end // generating
    endgenerate
                   
    assign cout = carries[99];
    

endmodule

module FA ( 
    input a, b, cin,
    output cout, sum );
    
    assign cout = ((a & b) | (cin & a) | (cin & b));
    assign sum = a ^ b ^ cin;

endmodule
