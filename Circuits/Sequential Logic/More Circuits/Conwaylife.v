module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    reg [255:0] currentcells, nextcells;
    genvar position,coloumn;
    integer j;
        
    wire [255:0] 	top,
    				left, 
    				right, 
    				bottom,
    				topright,
    				topleft,
    				bottomright,
    				bottomleft;
    wire [255:0][3:0] sum;
    
    generate
        for ( position = 0; position <= 15; position = position + 1 ) begin : cells
            for ( coloumn = 0; coloumn <= 15; coloumn = coloumn + 1 ) begin : coloumns
                assign bottom[position + coloumn*16] 		= q[(position + 1)%16 + coloumn*16];
                assign top[position + coloumn*16] 			= q[(position + 15)%16 + coloumn*16];
                assign left[position + coloumn*16] 			= q[(position + (15 + coloumn)*16)%256];
                assign right[position + coloumn*16] 		= q[position+((1 + coloumn)*16)%256];
                
                assign topright[position + coloumn*16] 		= q[( (position+15)%16 + ( (1 + coloumn)*16 )%256 )%256];
                assign topleft[position + coloumn*16] 		= q[( (position + 15)%16 + ( (15 + coloumn)*16)%256 )%256];
                assign bottomright[position + coloumn*16]	= q[( (position + 1)%16 + ( ( (1 + coloumn)*16) )%256 )%256];
                assign bottomleft[position + coloumn*16] 	= q[( (position + 1)%16 + ( (15+coloumn)*16)%256 )%256];
            end
    	end
    endgenerate

    always @ ( * ) begin
        for ( j = 0; j <= 255; j = j + 1 ) begin
            sum[j][3:0]	= (top[j] + left[j] + right[j] + bottom[j] + topright[j] + topleft[j] + bottomright[j] + bottomleft[j]);
            nextcells[j] = ( 4'b0100 <= sum[j] ) ? 1'b0 : ( ( 4'b0011 == sum[j] ) ? 1'b1 : ( ( 4'b0001 >= sum[j] ) ? 1'b0 : q[j] ) );
        end
    end
    
    
    always @ ( posedge clk ) begin
        if ( load )
            q <= data;
        else
            q <= nextcells;
    end
    

endmodule
