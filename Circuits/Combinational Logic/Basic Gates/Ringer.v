module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
    
    always @ (*) begin
        if ( ring ) begin
            ringer = ~vibrate_mode;
            motor = vibrate_mode;
        end
        else begin
            ringer = 1'b0;
            motor = 1'b0;
        end 
    end

endmodule
