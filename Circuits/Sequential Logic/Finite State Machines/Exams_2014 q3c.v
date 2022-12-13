module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    always @ ( * ) begin
        begin
            Y0 = 1'b0;
            z = 1'b0;
        end
        case ( y ) 
            3'b000: begin
                		Y0 = x ? 1'b1 : 1'b0;
                		z = 1'b0;
            		end
            3'b001: begin
                		Y0 = x ? 1'b0 : 1'b1;
                		z = 1'b0;
            		end
            3'b010: begin
                		Y0 = x ? 1'b1 : 1'b0;
                		z = 1'b0;
            		end
            3'b011: begin
                		Y0 = x ? 1'b0 : 1'b1;
                		z = 1'b1;
            		end  
            3'b100: begin
                		Y0 = x ? 1'b0 : 1'b1;
                		z = 1'b1;
            		end            
        endcase
    end

endmodule
