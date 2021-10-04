module top_module (input x, input y, output z);
    
    wire[3:0] z_i;
    wire top, bottom;

    IA oneA ( .x(x), .y(y), .z(z_i[3]) );
    IB oneB ( .x(x), .y(y), .z(z_i[2]) );
    IA twoA ( .x(x), .y(y), .z(z_i[1]) );
    IB twoB ( .x(x), .y(y), .z(z_i[0]) );
    
    assign top = z_i[3] | z_i[2];
    assign bottom = z_i[1] & z_i[0];
    assign z = top ^ bottom; 
    
endmodule

module IA (input x, input y, output z);
    assign z = ( x ^ y ) & x;
endmodule

module IB ( input x, input y, output z );
    assign z = ~(x ^ y);
endmodule

