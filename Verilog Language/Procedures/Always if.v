// synthesis verilog_input_version verilog_2001
module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output reg out_assign,
    output reg out_always   ); 
    
    //assign out_assign = (sel_b1 & sel_b2) ? b : a;
    /* */
    always @(*) begin
        case ( {sel_b1, sel_b2} )
            2'b11	: out_assign = b;
            default : out_assign = a;
        endcase
    end
	/* */
    
    always @(*) begin
        if ( sel_b1 & sel_b2 ) begin
            out_always = b;
        end
        else begin
            out_always = a;                
        end
    end

endmodule
