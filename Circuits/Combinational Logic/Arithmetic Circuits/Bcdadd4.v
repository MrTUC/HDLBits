module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire[2:0] carries;
    
    bcd_fadd stage0 ( .a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(carries[0]), .sum(sum[3:0]) );
    bcd_fadd stage1 ( .a(a[7:4]), .b(b[7:4]), .cin(carries[0]), .cout(carries[1]), .sum(sum[7:4]) );
    bcd_fadd stage2 ( .a(a[11:8]), .b(b[11:8]), .cin(carries[1]), .cout(carries[2]), .sum(sum[11:8]) );
    bcd_fadd stage3 ( .a(a[15:12]), .b(b[15:12]), .cin(carries[2]), .cout(cout), .sum(sum[15:12]) );

endmodule
