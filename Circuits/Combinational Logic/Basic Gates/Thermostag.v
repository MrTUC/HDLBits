module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
    
    wire fanout_switch, fanout_furnace;
    
    always @ (*) begin
        if (fan_on) 
            fanout_switch = 1'b1;
        else
            fanout_switch = 1'b0;
    end
    
    always @ (*) begin
        if (~mode & too_hot) begin
            aircon = 1'b1;
            heater = 1'b0;
            fanout_furnace = 1'b1;
        end
        else if (mode & too_cold) begin
            aircon = 1'b0;
            heater = 1'b1;
            fanout_furnace = 1'b1;
        end
        else begin
            fanout_furnace = 1'b0;
        	aircon = 1'b0;
            heater = 1'b0;
    	end
   
    end // always @ (*)

    assign fan = fanout_switch | fanout_furnace;
    
endmodule
