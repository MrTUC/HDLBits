module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);
    
    reg	[3:0]	seconds, tenseconds, minutes, tenminutes, hours, tenhours = 0;
    reg			pmled;
    
    // seconds
    always @ ( posedge clk ) begin
		if	( 1 == reset ) begin
			seconds		=	4'd0;
            tenseconds	=	4'd0;
            minutes		=	4'd0;
            tenminutes	=	4'd0;
            hours		=	4'd2;
            tenhours	=	4'd1;
            pmled		=	0;
		end else begin
            if ( ena ) begin
				seconds	=	seconds + 4'd1;
			
            	if ( 4'd10 == seconds ) begin
					seconds		=	4'd0;
					tenseconds	=	tenseconds + 4'd1;
                	if ( 4'd6 == tenseconds ) begin
                    	tenseconds	=	0;
                    	minutes		=	minutes + 4'd1;
                        if ( 4'd10 == minutes ) begin
                            minutes	=	4'd0;
                            tenminutes =	tenminutes + 4'd1;
                            if ( 4'd6 == tenminutes ) begin
                                hours = hours + 4'd1;
                                tenminutes	=	0;
                                if ( 4'd10 == hours ) begin
                                    hours		=	0;
                                    tenhours	=	tenhours + 4'd1;
                                end
                                if (( 4'd1	==	tenhours ) & ( 4'd2 == hours )) begin
									pmled	=	~pmled;
                                end 
                                if (( 4'd1	==	tenhours ) & ( 4'd3 == hours )) begin
                                	tenhours	=	0;
                                    hours		=	4'd1;
                                end                                   
                            end
                        end
                	end
				end
            end
		end
	end
    
    assign	hh		=	{tenhours, hours};
    assign	mm		=	{tenminutes, minutes};
    assign	ss		=	{tenseconds, seconds};
    assign	pm		=	pmled;
    
endmodule
