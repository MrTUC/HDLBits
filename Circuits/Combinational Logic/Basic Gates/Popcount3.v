module top_module ( 
    input [2:0] in,
    output [1:0] out );

    integer i;
    reg[1:0] count;
    
    always @(*) begin
        count = 0;
        for ( i = 0; i <=2; i = i + 1 ) begin
            if ( in[i] )
                count = count + 1;
        end // for
        out = count;
    end // always @(*)
    
endmodule
