module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
	
    wire [7:0] ab_comp, cd_comp;

    assign ab_comp = (( a < b ) ? a : b);
    assign cd_comp = (( c < d ) ? c : d);
    assign min = (( ab_comp < cd_comp ) ? ab_comp : cd_comp);  
    // assign intermediate_result1 = compare? true: false;

endmodule
