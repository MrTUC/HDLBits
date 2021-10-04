module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    
    tr_table plug ( .in3(x3), .in2(x2), .in1(x1), .out(f) );

endmodule

primitive tr_table ( output out, input in3, input in2,input in1 );
	table
0	0	0	:	0;
0	0	1	:	0;
0	1	0	:	1;
0	1	1	:	1;
1	0	0	:	0;
1	0	1	:	1;
1	1	0	:	0;
1	1	1	:	1;
        
    endtable
endprimitive
