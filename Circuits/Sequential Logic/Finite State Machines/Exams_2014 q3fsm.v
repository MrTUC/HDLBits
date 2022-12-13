module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
	localparam A=1'b0, B=1'b1;
    
    reg current_state, next_state;
    reg [1:0] clockcycles;
    reg [2:0] examine;
    
    always @ ( * ) begin
        next_state = A;
        case ( current_state)
            A: next_state = s ? B : A;
            B: next_state = B;
        endcase
    end
    
    always @ ( posedge clk ) begin
        if(reset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    always @ ( posedge clk ) begin
        if(reset) begin
            examine <= 3'b000;
            clockcycles <= 2'b00;
        end
        else if ( A == current_state ) begin
            examine <= 3'b000;
            clockcycles <= 2'b00;
        end
        else if ( 2'b11 == clockcycles ) begin
            clockcycles <= 2'b01;
            examine <= {w, examine[2:1]};
        end
        else begin
            clockcycles <= clockcycles + 1'b1;
            examine <= {w, examine[2:1]};
        end
    end
      
    assign z = ( 3'b011 == examine || 3'b110 == examine || 3'b101 == examine ) && clockcycles == 3;
          
endmodule
