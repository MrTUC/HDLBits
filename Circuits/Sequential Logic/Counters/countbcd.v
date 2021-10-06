module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    wire[3:0] ones, tens, hundreds, thousands;
    /*
    assign ones = q[3:0];
    assign tens = q[7:4];
    assign hundreds = q[11:8];
    assign thousands = q[15:12];
    */
    
    assign q[3:0] = ones;
    assign q[7:4] = tens;
    assign q[11:8] = hundreds;
    assign q[15:12] = thousands;
    
    always @ (posedge clk) begin
        if ( reset ) begin
            ones <= 0;
            tens <= 0;
            hundreds <= 0;
            thousands <= 0;
        end
        else begin
        
            // einer
            if ( 4'd9 == ones )
                ones <= 4'd0;
            else
                ones <= ones + 1;

            // zehner
            if (( 4'd9 == tens ) & ( 4'd9 == ones ))
                tens <= 4'd0;
            else if ( ena[1] )
                tens <= tens + 1;
            else 
                tens <= tens;
           

            // hundreds
            if (( 4'd9 == tens ) & ( 4'd9 == ones ) & ( 4'd9 == hundreds ) )
                hundreds <= 4'd0;
            else if ( ena[2] )
                hundreds <= hundreds + 1;
            else 
                hundreds <= hundreds;

            // tausender
            if (( 4'd9 == tens ) & ( 4'd9 == ones ) & ( 4'd9 == hundreds ) & ( 4'd9 == thousands ) )
                thousands <= 4'd0;
            else if ( ena[3] )
                thousands <= thousands + 1;
            else 
                thousands <= thousands;
            
            
        end
             	        
    end // always
    
    assign ena[1] = (4'b1001 == ones) ? 1'b1 : 1'b0;
    assign ena[2] = (8'b10011001 == {tens, ones}) ? 1'b1 : 1'b0;
    assign ena[3] = (12'b100110011001 == {hundreds, tens, ones}) ? 1'b1 : 1'b0;

endmodule
