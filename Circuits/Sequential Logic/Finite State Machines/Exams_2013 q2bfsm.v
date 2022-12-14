module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    localparam 	A = 4'b0000,
    			B = 4'b0001, 
    			C = 4'b0010, 
    			D =	4'b0011, 
    			E = 4'b0100, 
    			F = 4'b0101, 
				G = 4'b0110, 
    			H = 4'b0111, 
    			J = 4'b1000;
    			
    
    reg [3:0]	current_state, next_state;
    wire [1:0]	fandg;
    assign f = fandg[1];
    assign g = fandg[0];
    
    always @ ( * ) begin
        next_state = A;
        case ( current_state )
            A:	next_state = resetn ? B : A;
            B:	next_state = C;
            C:	next_state = x ? D : C;
            D:	next_state = !x ? E : D;
            E:	next_state = x ? F : C;
            F:	next_state = y ? H : G;
            G:	next_state = y ? H : J;
            H:	next_state = H;
            J:	next_state = J;
        endcase
    end

    always @ ( * ) begin
        fandg = 2'b00;
        case ( current_state )
            A:	fandg = 2'b00;
            B:	fandg = 2'b10;
            C:	fandg = 2'b00;
            D:	fandg = 2'b00;
            E:	fandg = 2'b00;
            F:	fandg = 2'b01;
            G:	fandg = 2'b01;
            H:	fandg = 2'b01;
            J:	fandg = 2'b00;
        endcase
    end
    
    always @ ( posedge clk ) begin
        if ( !resetn )
            current_state <= A;
        else
            current_state <= next_state;
    end
endmodule
