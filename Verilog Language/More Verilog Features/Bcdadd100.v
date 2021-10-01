module top_module ( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire[99:0] couts;
    
    genvar i;
    bcd_fadd firststage ( .a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(couts[0]), .sum(sum[3:0]) );
                         
    generate
        for ( i = 1; i <= 99; i = i + 1 ) begin : instantiation
            bcd_fadd bcdadder ( .a(a[(4*i)+3 -:4]), .b(b[(4*i)+3 -:4]), .cin(couts[i-1]), .cout(couts[i]), .sum(sum[(4*i)+3 -:4]) );
        end // instantiation
    endgenerate
    
    assign cout = couts[99];

endmodule
