module fsm (input clk,reset,data_in,output data_out);

parameter IDLE=2'b00,
	  STATE1=2'b01,
	  STATE11=2'b10;
reg [1:0] state,next_state;

always@(posedge clk)
 begin
  if(reset)
    state<=IDLE;
  else
    state<=next_state;
 end

always@(*)
  begin
   next_state=IDLE;
    case(state)
	    IDLE:begin
		    if(data_in)
			    next_state=STATE1;
		    else 
			    next_state=IDLE;
	   	 end  
            STATE1:begin
		    if(data_in)
			    next_state=STATE11;
		    else 
			    next_state=IDLE;
	   	 end 
	    STATE11:begin
		    if(data_in)
			    next_state=STATE11;
		    else 
			    next_state=IDLE;
	   	 end  
	 endcase
 end

assign data_out=(state==STATE11);

endmodule
